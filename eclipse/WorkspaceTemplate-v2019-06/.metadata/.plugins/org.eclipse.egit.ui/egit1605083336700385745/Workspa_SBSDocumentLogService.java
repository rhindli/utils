/**
 * 
 */
package org.bitsoftware.sbs.documentlog;

import static org.glowroot.agent.api.Instrumentation.AlreadyInTransactionBehavior.CAPTURE_TRACE_ENTRY;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import java.util.logging.Level;

import org.bitsoftware.sbs.SBSInternalErrorNotifier;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogAttribute;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogAuthor;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogEventLocation;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogEventSource;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogValue;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateLogBatchResponse.SBSCreateLogBatch;
import org.bitsoftware.sbs.exception.SBSException;
import org.bitsoftware.sbs.exception.SBSUnauthorizedException;
import org.compiere.db.CloseableIterator;
import org.compiere.db.DBQuery;
import org.compiere.db.handler.PojoHandler;
import org.compiere.framework.Lookup;
import org.compiere.framework.PO;
import org.compiere.framework.POInfo;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MSystem;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.Ctx;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Pair;
import org.compiere.util.Trx;
import org.glowroot.agent.api.Instrumentation.Transaction;

import com.bitsoftware.util.Util;

/**
 * @author Robert Hindli
 * @date Feb 5, 2020
 *
 */
public class SBSDocumentLogService {

	private static final int SBS_PUSH_BATCH_SIZE = 1000;
	private static final int MAX_PARALLEL_PUSH_JOBS_COUNT = 4;
	public static final int QUEUE_READ_BATCH_SIZE = 10000;
	private static final String INTERNAL_ERROR_NOTIFICATION_SUBJECT = "SBS Document Log error";
	private static final String SBS_DOCUMENTLOG_PUSH_DISPLAY_VALUES_PROP_NAME = "sbs.documentlog.push_display_values";

	private static CLogger log = CLogger.getCLogger(SBSDocumentLogService.class);

	/** Constructor */
	public SBSDocumentLogService() {
	}

	/**
	 * 
	 * @return number of change logs pushed
	 */
	@Transaction(transactionType = "Background", transactionName = "SBS work: push document log", alreadyInTransactionBehavior = CAPTURE_TRACE_ENTRY, traceHeadline = "SBS work: push document log", timer = "sbs")
	public static int pushChangeLogsToSBS() {
		if (isSBSLogDisabled())
			return 0;

		PushData pushData = loadPushData(QUEUE_READ_BATCH_SIZE);

		if (pushData.isEmpty())
			return 0;

		pushDataToSBS(pushData);

		return pushData.getRecordsCount();
	}

	private static boolean isSBSLogDisabled() {
		return !MSystem.get().isSBSDocumentLogEnabled();
	}

	private static PushData loadPushData(int maxRecordsCount) {
		String sql = "SELECT * FROM ( \n"
				+ "SELECT queue.AD_Client_ID \n"
				+ "	, queue.AD_ChangeLog_ID \n"
				+ "	, queue.AD_Table_ID \n"
				+ " , COALESCE(tbl.TableName, TO_NCHAR(queue.AD_Table_ID)) As TableName \n"
				+ "	, queue.AD_Column_ID \n"
				+ "	, COALESCE(c.ColumnName, TO_NCHAR(queue.AD_Column_ID)) As ColumnName \n"
				+ "	, queue.Updated \n"
				+ "	, queue.UpdatedBy \n"
				+ "	, queue.Record_ID \n"
				+ "	, queue.Record2_ID \n"
				+ "	, CASE WHEN UPPER(queue.OldValue) <> 'NULL' THEN OldValue END As OldValue \n"
				+ "	, CASE WHEN UPPER(queue.NewValue) <> 'NULL' THEN NewValue END As NewValue \n"
				+ "	, queue.TrxName \n"
				+ "	, queue.ChangeLogType \n"
				+ "	, queue.IsCustomization \n"
				+ "	, queue.Note \n"
				+ "	, s.Remote_Addr \n"
				+ "FROM AD_ChangeLog queue \n"
				+ "LEFT JOIN AD_Table tbl ON tbl.AD_Table_ID = queue.AD_Table_ID \n"
				+ "LEFT JOIN AD_Column c ON c.AD_Column_ID = queue.AD_Column_ID \n"
				+ "LEFT JOIN AD_Session s ON s.AD_Session_ID = queue.AD_Session_ID \n"
				+ "JOIN AD_ClientInfo ci ON ci.AD_Client_ID = queue.AD_Client_ID \n"
				+ "WHERE ci.IsSBSAccessKeyValid = 'Y' \n"
				+ "ORDER BY queue.AD_ChangeLog_ID) \n"
				+ "WHERE rownum <= ?";

		PushData pushData = new PushData();

		HashMap<Integer, TenantPushData> tenantPushDataByTenant = new HashMap<>();

		Function<ResultSet, QueuedChangeLogRecord> handler = new PojoHandler<>(QueuedChangeLogRecord.class);

		try (CloseableIterator<QueuedChangeLogRecord> it = DBQuery.iterator(sql.toString(), handler, (Trx) null,
				Arrays.asList(maxRecordsCount))) {
			while (it.hasNext()) {
				QueuedChangeLogRecord changeLog = it.next();

				TenantPushData tenantPushData = tenantPushDataByTenant.get(changeLog.AD_Client_ID);
				if (tenantPushData == null) {
					tenantPushData = new TenantPushData(changeLog.AD_Client_ID);
					tenantPushDataByTenant.put(changeLog.AD_Client_ID, tenantPushData);
					pushData.add(tenantPushData);
				}

				tenantPushData.add(changeLog);
			}
		}

		return pushData;
	}

	private static void pushDataToSBS(PushData pushData) {

		int jobsCount = getPushJobsCount(pushData.getRecordsCount(), QUEUE_READ_BATCH_SIZE,
				MAX_PARALLEL_PUSH_JOBS_COUNT);

		List<PushData> jobPushDataList = pushData.splitByJobAndBatchSize(jobsCount, SBS_PUSH_BATCH_SIZE);

		pushMultipleJobDataToSBS(jobPushDataList);
	}

	private static int getPushJobsCount(int pushDataRecordsCount, int maxPushDataSize, int maxPushJobsCount) {
		int maxRecordsCountPerJob = maxPushDataSize / maxPushJobsCount;
		if ((maxPushDataSize % maxPushJobsCount) != 0) {
			maxRecordsCountPerJob += 1;
		}

		int jobsCount = new BigDecimal(pushDataRecordsCount)
				.divide(new BigDecimal(maxRecordsCountPerJob), RoundingMode.HALF_UP)
				.intValue();

		if (jobsCount == 0)
			jobsCount = 1;

		return jobsCount;
	}

	private static void pushMultipleJobDataToSBS(List<PushData> jobPushDataList) {
		if (jobPushDataList.size() == 1) {
			pushSingleJobDataToSBS(jobPushDataList.get(0));
			return;
		}

		ExecutorService execService = Executors.newFixedThreadPool(jobPushDataList.size());

		for (PushData pushData : jobPushDataList) {
			execService.submit(new PushJob(pushData));
		}

		execService.shutdown();
		boolean workCompleted = false;
		boolean isInterrupted = false;

		while (!workCompleted) {
			try {
				execService.awaitTermination(Long.MAX_VALUE, TimeUnit.SECONDS);
				workCompleted = true;
			} catch (InterruptedException e) {
				log.info(
						"SBS Document Log: Interrupt while waiting push data completion; keep waiting until completion");
				isInterrupted = true;
			}
		}

		if (isInterrupted) {
			Thread.currentThread().interrupt();
		}
	}

	private static void pushSingleJobDataToSBS(PushData jobPushData) {
		for (TenantPushData tenantPushData : jobPushData.getData()) {
			pushTenantDataToSBS(tenantPushData);
		}
	}

	private static void pushTenantDataToSBS(TenantPushData tenantPushData) {
		String sbsAccessKey = MClientInfo.get(Env.getCtx(), tenantPushData.getTenantId()).getSBSAccessKey();
		String sbsDocumentLogEndpoint = MSystem.get().getSBSDocumentLogServiceURL();

		try {
			ArrayList<SBSDocumentLogCreateInput> documentLogsCreateInputs = new ArrayList<>();

			for (QueuedChangeLogRecord queuedChangeLog : tenantPushData.getQueuedChangeLogRecords()) {
				if (isPushDisplayValues()) {
					documentLogsCreateInputs
							.add(queuedChangeLog.convertToSBSDocumentLogCreateInputWithDisplayValues());
				} else {
					documentLogsCreateInputs
							.add(queuedChangeLog.convertToSBSDocumentLogCreateInputWithoutDisplayValues());
				}
			}

			List<SBSCreateLogBatch> documentLogs = SBSDocumentLogGraphQl.callSBSForCreateBatch(documentLogsCreateInputs,
					sbsDocumentLogEndpoint, sbsAccessKey);

			StringBuilder errors = new StringBuilder();
			ArrayList<QueuedChangeLogRecord> pushedQueuedChangedLogs = new ArrayList<>();

			for (int i = 0; i < documentLogs.size(); i++) {
				SBSCreateLogBatch documentLog = documentLogs.get(i);
				QueuedChangeLogRecord changeLog = tenantPushData.getQueuedChangeLogRecords().get(i);

				if (documentLog.hasErrors()) {
					if (errors.length() > 0) {
						errors.append("\n\n");
					}
					errors.append("==> AD_ChangeLog_ID=").append(changeLog.AD_ChangeLog_ID)
							.append("; ").append(documentLog.getError().getMessage());
				} else {
					pushedQueuedChangedLogs.add(changeLog);
				}
			}

			deletePushedChangeLogsFromQueue(pushedQueuedChangedLogs);

			if (errors.length() > 0) {
				throw new SBSException(errors.toString());
			}
		} catch (SBSUnauthorizedException e) {
			deactivateSBSKeyForTenant(tenantPushData.getTenantId());
		} catch (Exception e) {
			String tenantName = MClient.get(Env.getCtx(), tenantPushData.getTenantId()).getName();
			String err = "SBS Document Log: Error at pushing change logs to SBS document log for tenant '" + tenantName
					+ "'";
			log.log(Level.SEVERE, err, e);
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, e);
		}
	}

	private static boolean isPushDisplayValues() {
		return Util.getBoolen(System.getProperty(SBS_DOCUMENTLOG_PUSH_DISPLAY_VALUES_PROP_NAME));
	}

	private static void deactivateSBSKeyForTenant(int AD_Client_ID) {
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), AD_Client_ID);
		clientInfo.setIsSBSAccessKeyValid(false);
		if (!clientInfo.save()) {
			String tenantName = MClient.get(Env.getCtx(), AD_Client_ID).getName();
			String err = "SBS Document Log: Failed to deactivate SBS access key for tenant '" + tenantName + "'";
			log.severe(err);

			String errCause = CLogger.getLastErrorMsg();
			if (errCause != null) {
				err = err + ": " + errCause;
			}
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, (Exception) null);
		}
	}

	private static void deletePushedChangeLogsFromQueue(List<QueuedChangeLogRecord> changeLogs) {
		if (changeLogs.isEmpty())
			return;

		// copy pushed records to AD_ChangeLog_History
		String sql = "INSERT INTO AD_ChangeLog_History ( \n"
				+ "AD_CHANGELOG_ID,AD_SESSION_ID,AD_TABLE_ID,AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID, \n"
				+ "ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,RECORD_ID,OLDVALUE,NEWVALUE,UNDO,REDO, \n"
				+ "ISCUSTOMIZATION,TRXNAME,DESCRIPTION,AD_ROLE_ID,CHANGELOGTYPE,RECORD2_ID,NOTE) \n"
				+ "SELECT AD_CHANGELOG_ID,AD_SESSION_ID,AD_TABLE_ID,AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID, \n"
				+ "ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,RECORD_ID,OLDVALUE,NEWVALUE,UNDO,REDO, \n"
				+ "ISCUSTOMIZATION,TRXNAME,DESCRIPTION,AD_ROLE_ID,CHANGELOGTYPE,RECORD2_ID,NOTE \n"
				+ "FROM AD_ChangeLog \n"
				+ "WHERE AD_ChangeLog_ID = ?";
		ArrayList<Object[]> bulkParams = new ArrayList<>();
		for (QueuedChangeLogRecord changeLog : changeLogs) {
			bulkParams.add(new Object[] { changeLog.AD_ChangeLog_ID });
		}

		int cnt = DB.executeBulkUpdate(sql, bulkParams, false, (Trx) null, true);
		if (cnt < 0) {
			String err = "SBS Document Log: Failed to move pushed change logs to change log history";
			log.severe(err);

			String errCause = CLogger.getLastErrorMsg();
			if (errCause != null) {
				err = err + ": " + errCause;
			}
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, (Exception) null);
		}

		// delete pushed records
		sql = "DELETE AD_ChangeLog WHERE AD_ChangeLog_ID = ?";

		cnt = DB.executeBulkUpdate(sql, bulkParams, false, (Trx) null, true);
		if (cnt < 0) {
			String err = "SBS Document Log: Failed to delete pushed change logs";
			log.severe(err);

			String errCause = CLogger.getLastErrorMsg();
			if (errCause != null) {
				err = err + ": " + errCause;
			}
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, (Exception) null);
		}
	}

	public static List<SBSChangeLogRecord> getByDocument(Ctx ctx, int AD_Table_ID, String recordId) {
		List<SBSChangeLogRecord> retVal = new ArrayList<>();

		if (isSBSLogDisabled())
			return retVal;

		String sbsAccessKey = MClientInfo.get(ctx).getSBSAccessKey();
		String sbsDocumentLogEndpoint = MSystem.get().getSBSDocumentLogServiceURL();

		try {
			MTable table = MTable.get(ctx, AD_Table_ID);
			String documentType = table.getTableName();

			List<SBSDocumentLogLog> documentLogs = SBSDocumentLogGraphQl.callSBSForQueryByDocument(documentType,
					recordId,
					sbsDocumentLogEndpoint, sbsAccessKey);

			for (SBSDocumentLogLog documentLog : documentLogs) {
				SBSChangeLogRecord changeLog = new SBSChangeLogRecord(documentLog);
				retVal.add(changeLog);
			}

		} catch (SBSUnauthorizedException e) {
			deactivateSBSKeyForTenant(ctx.getAD_Client_ID());
		} catch (Exception e) {
			String tenantName = MClient.get(ctx).getName();
			String err = "SBS Document Log: Error at calling query logs SBS endpoint for tenant '" + tenantName + "'";
			log.log(Level.SEVERE, err, e);
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, e);
		}

		return retVal;
	}

	public static void updateDocumentLogCustomization(Ctx ctx, String sbsDocumentLogId, boolean isCustomization)
			throws Exception {
		String sbsAccessKey = MClientInfo.get(ctx).getSBSAccessKey();
		String sbsDocumentLogEndpoint = MSystem.get().getSBSDocumentLogServiceURL();

		try {
			SBSDocumentLogGraphQl.callSBSForUpdateIsCustomization(sbsDocumentLogId, isCustomization,
					sbsDocumentLogEndpoint,
					sbsAccessKey);
		} catch (SBSUnauthorizedException e) {
			deactivateSBSKeyForTenant(ctx.getAD_Client_ID());
		} catch (Exception e) {
			String tenantName = MClient.get(ctx).getName();
			String err = "SBS Document Log: Error at calling update document log customization SBS endpoint for tenant '"
					+ tenantName
					+ "'";
			log.log(Level.SEVERE, err, e);
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, e);
			throw e; // rethrow
		}
	}

	public static void updateDocumentLogNote(Ctx ctx, String sbsDocumentLogId, String note)
			throws Exception {
		String sbsAccessKey = MClientInfo.get(ctx).getSBSAccessKey();
		String sbsDocumentLogEndpoint = MSystem.get().getSBSDocumentLogServiceURL();

		try {
			SBSDocumentLogGraphQl.callSBSForUpdateComment(sbsDocumentLogId, note, sbsDocumentLogEndpoint,
					sbsAccessKey);
		} catch (SBSUnauthorizedException e) {
			deactivateSBSKeyForTenant(ctx.getAD_Client_ID());
		} catch (Exception e) {
			String tenantName = MClient.get(ctx).getName();
			String err = "SBS Document Log: Error at calling update document log customization SBS endpoint for tenant '"
					+ tenantName
					+ "'";
			log.log(Level.SEVERE, err, e);
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, e);
			throw e; // rethrow
		}
	}

	public static Optional<SBSChangeLogRecord> getById(Ctx ctx, String sbsDocumentLogId) {

		if (isSBSLogDisabled())
			return Optional.empty();

		String sbsAccessKey = MClientInfo.get(ctx).getSBSAccessKey();
		String sbsDocumentLogEndpoint = MSystem.get().getSBSDocumentLogServiceURL();

		try {

			SBSDocumentLogLog documentLog = SBSDocumentLogGraphQl.callSBSForQueryByIdLogEntry(sbsDocumentLogId,
					sbsDocumentLogEndpoint, sbsAccessKey);

			SBSChangeLogRecord changeLog = new SBSChangeLogRecord(documentLog);
			return Optional.of(changeLog);

		} catch (SBSUnauthorizedException e) {
			deactivateSBSKeyForTenant(ctx.getAD_Client_ID());
		} catch (Exception e) {
			String tenantName = MClient.get(ctx).getName();
			String err = "SBS Document Log: Error at calling query logs SBS endpoint for tenant '" + tenantName + "'";
			log.log(Level.SEVERE, err, e);
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, e);
		}

		return Optional.empty();
	}

	public static List<SBSChangeLogRecord> getAllCustomized(Ctx ctx) {
		List<SBSChangeLogRecord> retVal = new ArrayList<>();

		if (isSBSLogDisabled())
			return retVal;

		String sbsAccessKey = MClientInfo.get(ctx).getSBSAccessKey();
		String sbsDocumentLogEndpoint = MSystem.get().getSBSDocumentLogServiceURL();

		try {

			List<SBSDocumentLogLog> documentLogs = SBSDocumentLogGraphQl
					.callSBSForQueryAllCustomized(sbsDocumentLogEndpoint, sbsAccessKey);

			for (SBSDocumentLogLog documentLog : documentLogs) {
				SBSChangeLogRecord changeLog = new SBSChangeLogRecord(documentLog);
				retVal.add(changeLog);
			}
		} catch (SBSUnauthorizedException e) {
			deactivateSBSKeyForTenant(ctx.getAD_Client_ID());
		} catch (Exception e) {
			String tenantName = MClient.get(ctx).getName();
			String err = "SBS Document Log: Error at calling query logs SBS endpoint for tenant '" + tenantName + "'";
			log.log(Level.SEVERE, err, e);
			SBSInternalErrorNotifier.notifyError(INTERNAL_ERROR_NOTIFICATION_SUBJECT, err, e);
		}

		return retVal;
	}

	private static class QueuedChangeLogRecord {
		public int AD_Client_ID;
		public long AD_ChangeLog_ID;
		public int AD_Table_ID;
		public String TableName;
		public int AD_Column_ID;
		public String ColumnName;
		public Timestamp Updated;
		public int UpdatedBy;
		public int Record_ID;
		public String Record2_ID;
		public String OldValue;
		public String NewValue;
		public String TrxName;
		public String ChangeLogType;
		public boolean IsCustomization;
		public String Note;
		public String Remote_Addr;

		public SBSDocumentLogCreateInput convertToSBSDocumentLogCreateInputWithDisplayValues() {
			return convertToSBSDocumentLogCreateInput(true);
		}

		public SBSDocumentLogCreateInput convertToSBSDocumentLogCreateInputWithoutDisplayValues() {
			return convertToSBSDocumentLogCreateInput(false);
		}

		private SBSDocumentLogCreateInput convertToSBSDocumentLogCreateInput(boolean isIncludeDisplayValues) {
			SBSDocumentLogCreateInput retVal = new SBSDocumentLogCreateInput();

			if (Record2_ID != null) {
				retVal.setDocumentId(Record2_ID);
			} else {
				retVal.setDocumentId(String.valueOf(Record_ID));
			}

			retVal.setDocumentType(TableName);
			retVal.setAttribute(
					new SBSDocumentLogAttribute(
							String.valueOf(AD_Column_ID),
							ColumnName));

			DisplayValue displayValue = new DisplayValue();

			if (isIncludeDisplayValues) {
				displayValue = getDisplayValue();
			}

			retVal.setAttributeNewValue(
					new SBSDocumentLogValue(
							NewValue,
							displayValue.NewDisplayValue));

			retVal.setAttributeOldValue(
					new SBSDocumentLogValue(
							OldValue,
							displayValue.OldDisplayValue));

			retVal.setDateTime(Updated);

			retVal.setAuthor(
					new SBSDocumentLogAuthor(
							String.valueOf(UpdatedBy),
							null));

			retVal.setEventSource(
					new SBSDocumentLogEventSource(
							TrxName,
							null));
			retVal.setEventLocation(
					new SBSDocumentLogEventLocation(
							Remote_Addr,
							null));
			retVal.setComment(Note);
			retVal.setAction(ChangeLogType);
			retVal.setCustom1(String.valueOf(IsCustomization));

			return retVal;
		}

		private DisplayValue getDisplayValue() {
			DisplayValue retVal = new DisplayValue();

			POInfo poInfo = POInfo.getPOInfo(Env.getCtx(), AD_Table_ID);
			int columnIdx = poInfo.getColumnIndex(AD_Column_ID);

			int displayType = poInfo.getColumnDisplayType(columnIdx);
			Language lang = Language.getBaseLanguage();

			if (DisplayType.isNumeric(displayType)) {
				BigDecimal bdValue;
				if (NewValue != null) {
					bdValue = Util.getBigDecimal(NewValue);
					retVal.NewDisplayValue = DisplayType.getNumberFormat(displayType, lang).format(bdValue);
				}
				if (OldValue != null) {
					bdValue = Util.getBigDecimal(OldValue);
					retVal.OldDisplayValue = DisplayType.getNumberFormat(displayType, lang).format(bdValue);
				}
			} else if (DisplayType.isDate(displayType)) {
				Timestamp dateValue;
				if (NewValue != null) {
					dateValue = PO.convertToTimestamp(NewValue);
					retVal.NewDisplayValue = DisplayType.getDateFormat(displayType, lang).format(dateValue);
				}
				if (OldValue != null) {
					dateValue = PO.convertToTimestamp(OldValue);
					retVal.OldDisplayValue = DisplayType.getDateFormat(displayType, lang).format(dateValue);
				}
			} else if (DisplayType.isLookup(displayType)) {
				Lookup lookup = poInfo.getColumnLookupNoLoadData(Env.getCtx(), columnIdx);

				if (NewValue != null) {
					if (lookup != null)
						retVal.NewDisplayValue = lookup.getDisplay(NewValue);
					else
						retVal.NewDisplayValue = NewValue;
				}
				if (OldValue != null) {
					if (lookup != null)
						retVal.OldDisplayValue = lookup.getDisplay(OldValue);
					else
						retVal.OldDisplayValue = OldValue;
				}
			} else {
				if (NewValue != null) {
					retVal.NewDisplayValue = NewValue;
				}
				if (OldValue != null) {
					retVal.OldDisplayValue = OldValue;
				}
			}

			return retVal;
		}

		private static class DisplayValue {
			public String NewDisplayValue;
			public String OldDisplayValue;
		}
	}

	public static class SBSChangeLogRecord {
		private String id;
		private String tableName;
		private int AD_Column_ID;
		private String columnName;
		private Timestamp updated;
		private int updatedBy;
		private int record_ID;
		private String record2_ID;
		private String oldValue;
		private String newValue;
		private String trxName;
		private String changeLogType;
		private boolean isCustomization;
		private String note;
		private String remote_Addr;

		public SBSChangeLogRecord() {

		}

		private SBSChangeLogRecord(SBSDocumentLogLog sbsDocumentLog) {
			id = sbsDocumentLog.getId();
			tableName = sbsDocumentLog.getDocumentType();
			AD_Column_ID = Integer.parseInt(sbsDocumentLog.getAttribute().getId());
			columnName = sbsDocumentLog.getAttribute().getName();
			updated = new Timestamp(sbsDocumentLog.getDateTime().getTime());
			updatedBy = Integer.parseInt(sbsDocumentLog.getAuthorId());

			String documentId = sbsDocumentLog.getDocumentId();
			try {
				record_ID = new BigDecimal(documentId).intValue();
			} catch (Exception e) {
				record2_ID = documentId;
			}

			oldValue = sbsDocumentLog.getAttributeOldValue().getRaw();
			newValue = sbsDocumentLog.getAttributeNewValue().getRaw();
			trxName = sbsDocumentLog.getEventSource().getId();
			changeLogType = sbsDocumentLog.getAction();
			isCustomization = Util.getBoolen(sbsDocumentLog.getCustom1());
			note = sbsDocumentLog.getComment();
			remote_Addr = sbsDocumentLog.getEventLocation().getIp();
		}

		public String getId() {
			return id;
		}

		public String getTableName() {
			return tableName;
		}

		public int getAD_Column_ID() {
			return AD_Column_ID;
		}

		public String getColumnName() {
			return columnName;
		}

		public Timestamp getUpdated() {
			return updated;
		}

		public int getUpdatedBy() {
			return updatedBy;
		}

		public int getRecord_ID() {
			return record_ID;
		}

		public String getRecord2_ID() {
			return (record2_ID == null ? "" : record2_ID);
		}

		public String getOldValue() {
			return oldValue;
		}

		public String getNewValue() {
			return newValue;
		}

		public String getTrxName() {
			return trxName;
		}

		public String getChangeLogType() {
			return changeLogType;
		}

		public boolean isCustomization() {
			return isCustomization;
		}

		public String getNote() {
			return note;
		}

		public String getRemote_Addr() {
			return remote_Addr;
		}
	}

	private static class PushData {
		private ArrayList<TenantPushData> data = new ArrayList<>();

		public void add(TenantPushData data) {
			this.data.add(data);
		}

		public List<TenantPushData> getData() {
			return data;
		}

		public int getRecordsCount() {
			int recordsCount = 0;
			for (TenantPushData tenantPushData : data) {
				recordsCount += tenantPushData.getRecordsCount();
			}
			return recordsCount;
		}

		public boolean isEmpty() {
			for (TenantPushData tenantPushData : data) {
				if (!tenantPushData.getQueuedChangeLogRecords().isEmpty())
					return false;
			}

			return true;
		}

		public List<PushData> splitByJobAndBatchSize(int jobsCount, int batchSize) {
			ArrayList<PushData> pushDataSplitByJobs = new ArrayList<>();
			for (int i = 0; i < jobsCount; i++) {
				pushDataSplitByJobs.add(new PushData());
			}

			List<TenantPushData> batchSplitTenantPushData = new ArrayList<>();
			for (TenantPushData tenantPushData : data) {
				batchSplitTenantPushData.addAll(tenantPushData.splitByBatchSize(batchSize));
			}

			int idx = 0;

			for (TenantPushData tenantPushData : batchSplitTenantPushData) {
				pushDataSplitByJobs.get(idx).add(tenantPushData);
				idx++;
				idx = idx % jobsCount;
			}

			return pushDataSplitByJobs;
		}
	}

	private static class TenantPushData {
		private final Pair<Integer, List<QueuedChangeLogRecord>> data;

		public TenantPushData(Integer tenantId) {
			this(tenantId, new ArrayList<>());
		}

		public TenantPushData(Integer tenantId, List<QueuedChangeLogRecord> queuedChangeLogs) {
			data = new Pair<>(tenantId, queuedChangeLogs);
		}

		public Integer getTenantId() {
			return data.getFirst();
		}

		public List<QueuedChangeLogRecord> getQueuedChangeLogRecords() {
			return data.getSecond();
		}

		public void add(QueuedChangeLogRecord changeLogRecord) {
			getQueuedChangeLogRecords().add(changeLogRecord);
		}

		public int getRecordsCount() {
			return getQueuedChangeLogRecords().size();
		}

		public List<TenantPushData> splitByBatchSize(int batchSize) {
			List<TenantPushData> retVal = new ArrayList<>();
			if (getRecordsCount() <= batchSize) {
				retVal.add(this);
			} else {
				int batchesCount = getRecordsCount() / batchSize;
				if (getRecordsCount() % batchSize != 0) {
					batchesCount += 1;
				}

				List<QueuedChangeLogRecord> allChangeLogs = getQueuedChangeLogRecords();

				for (int i = 0; i < batchesCount; i++) {
					int startIdx = i * batchSize;
					int endIdx = (i + 1) * batchSize;
					if (endIdx > allChangeLogs.size()) {
						endIdx = allChangeLogs.size();
					}
					if (startIdx == endIdx)
						break;

					List<QueuedChangeLogRecord> batchSizeChangeLogs = allChangeLogs.subList(startIdx, endIdx);
					TenantPushData batchSizeTenantPushData = new TenantPushData(getTenantId(), batchSizeChangeLogs);
					retVal.add(batchSizeTenantPushData);
				}
			}

			return retVal;
		}
	}

	private static class PushJob implements Runnable {
		private final PushData pushData;

		public PushJob(PushData pushData) {
			this.pushData = pushData;
		}

		@Override
		public void run() {
			SBSDocumentLogService.pushSingleJobDataToSBS(pushData);
		}
	}
}
