package org.bitsoftware.sbs.documentlog;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.bitsoftware.sbs.SBSEndpointService;
import org.bitsoftware.sbs.documentlog.SBSDocumentLogCreateLogBatchResponse.SBSCreateLogBatch;
import org.bitsoftware.sbs.exception.SBSException;
import org.bitsoftware.sbs.exception.SBSUnauthorizedException;
import org.compiere.util.CLogger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * @author Cristian Manea
 * @date Feb 7, 2020
 */
public class SBSDocumentLogGraphQl {
	private static final String PARAMS_PLACEHOLDER = "my_params_placehoder";
	private static final String MUTATION_CREATE_BATCH = "{\"variables\":{\"input\":"
			+ PARAMS_PLACEHOLDER
			+ "},\"query\":\"mutation createBatchLogsWithParams($input: [CreateLogInput!]!) {  createLogBatch(input: $input) {results {itemId error {message}}}}\"}";

	private static final String MUTATION_UPDATE_LOG = "{\"variables\":{\"input\":"
			+ PARAMS_PLACEHOLDER
			+ "},\"query\":\"mutation updateLog($input: UpdateLogInput!) {\\n  updateLog(input: $input) {\\n    id\\n    custom1\\n    custom2\\n    comment\\n  }\\n}\\n\"}";
	private static final String QUERY_BY_DOCUMENT = "{\"variables\":"
			+ PARAMS_PLACEHOLDER
			+ ",\"query\":\"query queryByDocument($logsFilter:LogsFilter!, $nextToken:String) {logs(filter:$logsFilter, nextToken:$nextToken) {items {id documentId documentType attributeId attribute {id   name} attributeNewValue {raw   display} attributeOldValue {raw   display} dateTime authorId author {id   name} eventSource {id   name} eventLocation {ip   geoLocation} comment custom1 custom2 action\\n   } nextToken}}\"}";

	private static CLogger log = CLogger.getCLogger(SBSDocumentLogGraphQl.class);

	public static List<SBSCreateLogBatch> callSBSForCreateBatch(
			List<SBSDocumentLogCreateInput> documentLogsCreateInputs,
			String sbsEndpoint,
			String sbsAccessKey) throws SBSUnauthorizedException, SBSException, IOException {

		log.info("Call SBSForCreate Batch with number of logs: " + documentLogsCreateInputs.size());

		String jsonResponse = SBSEndpointService.callSBSEndpoint(
				sbsAccessKey, sbsEndpoint, getJsonForCreateBatch(documentLogsCreateInputs));

		return getCreateBatchResult(jsonResponse);
	}

	private static String getJsonForCreateBatch(List<SBSDocumentLogCreateInput> documentLogsCreateInputs) {
		Gson gson = getGsonFromBuilder();
		String jsonParameters = gson.toJson(documentLogsCreateInputs);
		String jsonForCreateBatch = MUTATION_CREATE_BATCH.replace(PARAMS_PLACEHOLDER, jsonParameters);
		return jsonForCreateBatch;
	}

	private static List<SBSCreateLogBatch> getCreateBatchResult(String jsonQueryResult) {
		Gson gson = getGsonFromBuilder();
		SBSDocumentLogCreateLogBatchResponse response = gson.fromJson(jsonQueryResult,
				SBSDocumentLogCreateLogBatchResponse.class);
		return response.getData().getCreateLogBatch().getResults();
	}

	public static void callSBSForUpdateIsCustomization(
			String idSBSDocumentLog, boolean isCustomization,
			String sbsEndpoint, String sbsAccessKey) throws SBSUnauthorizedException, SBSException, IOException {
		callSBSForUpdate(idSBSDocumentLog, isCustomization, null, sbsEndpoint, sbsAccessKey);
	}

	public static void callSBSForUpdateComment(
			String idSBSDocumentLog, String comment,
			String sbsEndpoint, String sbsAccessKey) throws SBSUnauthorizedException, SBSException, IOException {
		if (comment == null)
			comment = ""; // to force JSON serialization of comment and remove it
		callSBSForUpdate(idSBSDocumentLog, null, comment, sbsEndpoint, sbsAccessKey);
	}

	private static void callSBSForUpdate(
			String idSBSDocumentLog, Boolean isCustomization, String comment,
			String sbsEndpoint, String sbsAccessKey) throws SBSUnauthorizedException, SBSException, IOException {

		SBSDocumentLogUpdateInput input = new SBSDocumentLogUpdateInput();
		input.setId(idSBSDocumentLog);
		input.setCustom1((isCustomization == null ? null : isCustomization.toString()));
		input.setComment(comment == null ? null : comment);

		Gson gson = getGsonFromBuilder();
		String inputJson = gson.toJson(input);

		inputJson = MUTATION_UPDATE_LOG.replace(PARAMS_PLACEHOLDER, inputJson);
		log.info("Call SBSForCreate Batch with " + input.toString());

		SBSEndpointService.callSBSEndpoint(
				sbsAccessKey, sbsEndpoint, getJsonForUpdate(input));
	}

	private static String getJsonForUpdate(SBSDocumentLogUpdateInput input) {
		Gson gson = getGsonFromBuilder();
		String inputJson = gson.toJson(input);

		inputJson = MUTATION_UPDATE_LOG.replace(PARAMS_PLACEHOLDER, inputJson);

		return inputJson;
	}

	public static List<SBSDocumentLogLog> callSBSForQueryByDocument(String documentType, String documentId,
			String sbsEndpoint, String sbsAccessKey)
			throws SBSUnauthorizedException, SBSException, IOException {

		// pass gson from here in order to optimize in case of next calls
		Gson gson = getGsonFromBuilder();
		SBSDocumentLogLogsFilter logFilter = new SBSDocumentLogLogsFilter();
		logFilter.setDocumentType(documentType);
		logFilter.setDocumentId(documentId);
		List<SBSDocumentLogLog> sbsDocumentLogLogs = callSBSForQuery(sbsEndpoint, sbsAccessKey, gson,
				logFilter);
		return sbsDocumentLogLogs;
	}

	public static SBSDocumentLogLog callSBSForQueryByIdLogEntry(String idLogEntryInSBS,
			String sbsEndpoint, String sbsAccessKey)
			throws SBSUnauthorizedException, SBSException, IOException {

		Gson gson = getGsonFromBuilder();
		SBSDocumentLogLogsFilter logFilter = new SBSDocumentLogLogsFilter();
		logFilter.setId(idLogEntryInSBS);
		List<SBSDocumentLogLog> sbsDocumentLogLogs = callSBSForQuery(sbsEndpoint, sbsAccessKey, gson,
				logFilter);
		if (sbsDocumentLogLogs.size() > 0)
			return sbsDocumentLogLogs.get(0);

		return null;
	}

	public static List<SBSDocumentLogLog> callSBSForQueryAllCustomized(
			String sbsEndpoint, String sbsAccessKey)
			throws SBSUnauthorizedException, SBSException, IOException {

		// pass gson from here in order to optimize in case of next calls
		Gson gson = getGsonFromBuilder();
		SBSDocumentLogLogsFilter logFilter = new SBSDocumentLogLogsFilter();
		Boolean isCustomization = true;
		logFilter.setCustom1(isCustomization.toString());
		List<SBSDocumentLogLog> sbsDocumentLogLogs = callSBSForQuery(sbsEndpoint, sbsAccessKey, gson,
				logFilter);
		return sbsDocumentLogLogs;
	}

	private static List<SBSDocumentLogLog> callSBSForQuery(String sbsEndpoint, String sbsAccessKey,
			Gson gson, SBSDocumentLogLogsFilter logFilter)
			throws SBSUnauthorizedException, SBSException, IOException {
		List<SBSDocumentLogLog> sbsDocumentLogLogs = new ArrayList<SBSDocumentLogLog>();
		String nextToken = null;
		log.info("Query for document logs with filter: " + logFilter);
		do {
			String jsonForQuery = getJsonForQuery(logFilter, nextToken);

			String jsonQueryResult = SBSEndpointService.callSBSEndpoint(sbsAccessKey, sbsEndpoint,
					jsonForQuery);

			SBSDocumentLogQueryResponse responseData = gson.fromJson(jsonQueryResult,
					SBSDocumentLogQueryResponse.class);
			nextToken = responseData.getData().getLogs().getNextToken();
			sbsDocumentLogLogs.addAll(responseData.getData().getLogs().getItems());
			log.info(String.format("Received a response from query; adding %s items",
					responseData.getData().getLogs().getItems().size()));
		} while (nextToken != null);
		return sbsDocumentLogLogs;
	}

	private static String getJsonForQuery(SBSDocumentLogLogsFilter logsFilter, String nextToken) {
		Gson gson = getGsonFromBuilder();
		SBSDocumentLogLogsQueryArgs queryArgs = new SBSDocumentLogLogsQueryArgs(logsFilter, nextToken);
		String jsonLogFilter = gson.toJson(queryArgs);
		String jsonForQueryByDocument = QUERY_BY_DOCUMENT.replace(PARAMS_PLACEHOLDER, jsonLogFilter);
		return jsonForQueryByDocument;
	}

	private static List<SBSDocumentLogLog> getQueryResultsFromJson(String jsonQueryResult) {
		Gson gson = getGsonFromBuilder();
		SBSDocumentLogQueryResponse response = gson.fromJson(jsonQueryResult, SBSDocumentLogQueryResponse.class);
		return response.getData().getLogs().getItems();
	}

	private static Gson getGsonFromBuilder() {
		return new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").disableHtmlEscaping().create();
	}

}
