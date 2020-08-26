package org.bitsoftware.sgap.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.bitsoftware.ejb.WebModule;
import org.bitsoftware.web.WebModuleManager;
import org.compiere.Compiere;
import org.compiere.framework.CThreadPools;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 * Servlet implementation for SocrateOpen Google Apps - used to setup
 * environment and destroy
 *
 * @author Florin David
 * @date 10 October 2012
 */
public class SOGAppsServlet extends HttpServlet {

	/** Generated Serial Version ID */
	private static final long serialVersionUID = 1928923916429489904L;

	/** Log */
	private static CLogger log;

	/** Initialization */
	@Override
	public void init() throws ServletException {
		try {
			Compiere.startupWeb(false, WebModule.getInstanceName(WebModule.WebModuleType_SOGApps));

			log = CLogger.getCLogger(getClass());
			log.info("SOGApps - Init");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} catch (Error e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	} // init

	/** Destroy */
	@Override
	public void destroy() {
		log.info("destroy");

		CLogMgt.removeHandlers();
		DB.closeTarget();

		WebModuleManager.fireDestroy();

		//
		CThreadPools.shutdown();

		super.destroy();
	} // destroy
} // SOGAppsServlet
