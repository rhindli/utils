/**
 * 
 */
package org.bitsoftware.sbs.documentlog;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.function.Function;

import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogAttribute;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogAuthor;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogEventLocation;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogEventSource;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateInput.SBSDocumentLogValue;
import org.bitsoftware.sems.EmailCallback;
import org.bitsoftware.sems.EmailParameters;
import org.bitsoftware.sems.EmailResponse;
import org.bitsoftware.sems.SCEmailService;
import org.compiere.db.CloseableIterator;
import org.compiere.db.DBQuery;
import org.compiere.db.handler.PojoHandler;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MSystem;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;

/**
 * @author Robert Hindli
 * @date Feb 5, 2020
 *
 */
public class SBSDocumentLogService {

	private static final int CHANGE_LOG_BATCH_SIZE = 1000;
	private static final String SBS_DOCUMENT_LOG_ERROR_NOTIF_EMAILS_PROP_NAME = "SBSDocumentLogErrorNotifEmails";
	private static final String SCLOUD_SBS_DOCUMENT_LOG_ERROR_NOTIF_EMAILS_PROP_NAME = "SCloudSBSDocumentLogErrorNotifEmails";

	private static CLogger log = CLogger.getCLogger(SBSDocumentLogService.class);

	/** Constructor */
	public SBSDocumentLogService() {
	}

	public static void pushChangeLogsToSBS() {
		if (isSBSLogDisabled())
			return;

		HashMap<Integer, List<SCChangeLogRecord>> changeLogsByTenant = loadChangeLogsByTenant(
				CHANGE_LOG_BATCH_SIZE);

		if (changeLogsByTenant.isEmpty())
			return;

		for (Integer AD_Client_ID : changeLogsByTenant.keySet()) {
			pushTenantChangeLogsToSBS(AD_Client_ID, changeLogsByTenant.get(AD_Client_ID));
		}
	}

	private static boolean isSBSLogDisabled() {
		return !MSystem.get(Env.getCtx()).isSBSDocumentLogEnabled();
	}

	private static HashMap<Integer, List<SCChangeLogRecord>> loadChangeLogsByTenant(int batchSize) {
		HashMap<Integer, List<SCChangeLogRecord>> changeLogsByTenant = new HashMap<>();

		String sql = "SELECT * FROM ( \n"
				+ "SELECT queue.* \n"
				+ " , tbl.TableName \n"
				+ "	, c.ColumnName \n"
				+ "	, u.Name AS CreatedByName \n"
				+ "	, s.Remote_Addr \n"
				+ "FROM AD_ChangeLog queue \n"
				+ "JOIN AD_Table tbl ON tbl.AD_Table_ID = queue.AD_Table_ID \n"
				+ "JOIN AD_Column c ON c.AD_Column_ID = queue.AD_Column_ID \n"
				+ "JOIN AD_Session s ON s.AD_Session_ID = queue.AD_Session_ID \n"
				+ "JOIN AD_User u ON u.AD_User_ID = queue.CreatedBy \n"
				+ "JOIN AD_ClientInfo ci ON ci.AD_Client_ID = queue.AD_Client_ID \n"
				+ "WHERE ci.IsSBSAccessKeyValid = 'Y' \n"
				+ "ORDER BY queue.Created) \n"
				+ "WHERE rownum <= ?";

		Function<ResultSet, SCChangeLogRecord> handler = new PojoHandler<>(SCChangeLogRecord.class);

		try (CloseableIterator<SCChangeLogRecord> it = DBQuery.iterator(sql.toString(), handler, (Trx) null,
				Arrays.asList(batchSize))) {
			while (it.hasNext()) {
				SCChangeLogRecord changeLog = it.next();

				List<SCChangeLogRecord> tenantChangeLogs = changeLogsByTenant
						.get(changeLog.AD_Client_ID);
				if (tenantChangeLogs == null) {
					tenantChangeLogs = new ArrayList<>();
					changeLogsByTenant.put(changeLog.AD_Client_ID, tenantChangeLogs);
				}

				tenantChangeLogs.add(changeLog);
			}
		}

		return changeLogsByTenant;
	}

	private static void pushTenantChangeLogsToSBS(int AD_Client_ID,
			List<SCChangeLogRecord> changeLogs) {
		String sbsAccessKey = MClientInfo.get(Env.getCtx(), AD_Client_ID).getSBSAccessKey();
		String sbsDocumentLogEndpoint = MSystem.get(Env.getCtx()).getSBSDocumentLogServiceURL();

		try {
			ArrayList<SBSDocumentLogCreateInput> documentLogsCreateInputs = new ArrayList<>();

			for (SCChangeLogRecord scChangeLogRecord : changeLogs) {
				documentLogsCreateInputs.add(scChangeLogRecord.convertToSBSDocumentLogCreateInput());
			}

			SBSDocumentLogGraphQl.callSBSForCreateBatch(documentLogsCreateInputs, sbsDocumentLogEndpoint, sbsAccessKey);

			deletePushedChangeLogs(changeLogs);
//		} catch (SBSUnauthorizedException e) {
//			deactivateSBSKeyForTenant(AD_Client_ID);
//		} catch (SBSDocumentLogException | IOException e) {
		} catch (IOException e) {
			String tenantName = MClient.get(Env.getCtx(), AD_Client_ID).getName();
			String err = "SBS Document Log: Error at calling SBS endpoint for tenant '" + tenantName + "'";
			log.severe(err);
			boolean isNotifySBSServiceTeam = !(e instanceof IOException);
			internalNotifyErrorByEmail(err, isNotifySBSServiceTeam);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static void deactivateSBSKeyForTenant(int AD_Client_ID) {
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), AD_Client_ID);
		clientInfo.setIsSBSAccessKeyValid(false);
		if (!clientInfo.save()) {
			String tenantName = MClient.get(Env.getCtx(), AD_Client_ID).getName();
			String err = "SBS Document Log: Failed to deactivate SBS access key for tenant '" + tenantName + "'";
			log.severe(err);
			internalNotifyErrorByEmail(err, false);
		}
	}

	private static void deletePushedChangeLogs(List<SCChangeLogRecord> changeLogs) {
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
		for (SCChangeLogRecord changeLog : changeLogs) {
			bulkParams.add(new Object[] { changeLog.AD_ChangeLog_ID });
		}

		int cnt = DB.executeBulkUpdate(sql, bulkParams, false, (Trx) null, true);
		if (cnt < 0) {
			String err = "SBS Document Log: Failed to move pushed change logs to change log history";
			log.severe(err);
			internalNotifyErrorByEmail(err, false);
		}

		// delete pushed records
		sql = "DELETE AD_ChangeLog WHERE AD_ChangeLog_ID = ?";

		cnt = DB.executeBulkUpdate(sql, bulkParams, false, (Trx) null, true);
		if (cnt < 0) {
			String err = "SBS Document Log: Failed to delete pushed change logs";
			log.severe(err);
			internalNotifyErrorByEmail(err, false);
		}
	}

	private static void internalNotifyErrorByEmail(String errorMessage, boolean isNotifySBSServiceTeam) {
		ArrayList<String> emailAddresses = new ArrayList<>();
		emailAddresses.addAll(getErrorNotifEmailsFromProperty(SCLOUD_SBS_DOCUMENT_LOG_ERROR_NOTIF_EMAILS_PROP_NAME));
		if (isNotifySBSServiceTeam)
			emailAddresses.addAll(getErrorNotifEmailsFromProperty(SBS_DOCUMENT_LOG_ERROR_NOTIF_EMAILS_PROP_NAME));

		if (emailAddresses.isEmpty())
			return;

		EmailParameters emailParameters = new EmailParameters("SBS Document Log error", errorMessage);
		for (String emailAddress : emailAddresses) {
			emailParameters.addTo(emailAddress);
		}

		EmailCallback callback = new EmailCallback() {
			@Override
			public void onDone(EmailResponse response) throws Exception {
				if (response.isSentOk())
					return;

				log.warning("SBS Document Log: Failed to notify error by email - " + response.getErrorMessage());
			}
		};

		SCEmailService.sendEmailAsync(Env.getCtx(), emailParameters, callback);
	}

	private static List<String> getErrorNotifEmailsFromProperty(String propertyName) {
		ArrayList<String> retVal = new ArrayList<>();
		String emailsCsv = System.getProperty(propertyName, "").trim();
		if (emailsCsv.isEmpty()) {
			return retVal;
		}

		return Arrays.asList(emailsCsv.split("[;,]"));
	}

	private static class SCChangeLogRecord {
		public int AD_Client_ID;
		public int AD_ChangeLog_ID;
		public int AD_Table_ID;
		public String TableName;
		public int AD_Column_ID;
		public String ColumnName;
		public Timestamp Created;
		public int CreatedBy;
		public String CreatedByName;
		public int Record_ID;
		public String Record2_ID;
		public String OldValue;
		public String NewValue;
		public String TrxName;
		public String ChangeLogType;
		public boolean IsCustomization;
		public String Note;
		public String Remote_Addr;

		public SBSDocumentLogCreateInput convertToSBSDocumentLogCreateInput() {
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

			retVal.setAttributeNewValue(
					new SBSDocumentLogValue(
							NewValue,
							null));

			retVal.setAttributeOldValue(
					new SBSDocumentLogValue(
							OldValue,
							null));

			retVal.setDateTime(Created);

			retVal.setAuthor(
					new SBSDocumentLogAuthor(
							String.valueOf(CreatedBy),
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
	}
}
