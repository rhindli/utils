delete from SO_TAXDECLARATIONACCT_BIT where AD_Client_ID=1001248
;
delete from Fact_Acct where AD_Client_ID=1001248
;
delete from Fact_Acct_Balance where AD_Client_ID=1001248
;
delete from AD_WF_Process where AD_Client_ID=1001248
;
delete from M_CostDetail where ad_client_id=1001248
;
delete from M_CostQueue where AD_Client_ID=1001248
;
delete from M_Cost where AD_Client_ID=1001248
;
delete from C_AllocationHdr where AD_Client_ID=1001248
;
delete from C_BANKSTATEMENT where AD_Client_ID=1001248
;
delete from C_ALLOCATIONLINE where AD_Client_ID=1001248
;
delete from C_PAYSELECTIONLINE where AD_Client_ID=1001248
;
delete from C_PAYSELECTIONCHECK where AD_Client_ID=1001248
;
update C_Invoice set C_Payment_id=null where AD_Client_ID=1001248
;
delete from C_Payment where AD_Client_ID=1001248
;
delete from M_Transaction where AD_Client_ID=1001248
;
delete from M_Storage where AD_Client_ID=1001248
;
delete from M_INOUTCONFIRM where AD_Client_ID=1001248
;
delete from W_MATCHWO where AD_Client_ID=1001248
;
delete from M_SO_AVERAGECOSTHISTORY where AD_Client_ID=1001248
;
delete from M_Inventory where AD_Client_ID=1001248
;
update M_InOutLine set c_invoiceline_id=null where AD_Client_ID=1001248
;
delete from M_MatchShip where AD_Client_ID=1001248
;
delete from M_MatchInv where AD_Client_ID=1001248
;
delete from M_MatchPO where AD_Client_ID=1001248
;
delete from C_CASHLINE where AD_Client_ID=1001248
;
update C_Invoice set C_CASHLINE_id=null where AD_Client_ID=1001248
;
update C_CASHLINE set c_invoice_id=null where AD_Client_ID=1001248
;
update C_CASHLINE set c_order_id=null where AD_Client_ID=1001248
;
delete from S_TIMEEXPENSELINE where AD_Client_ID=1001248
;
delete from SFLT_INVMOCDISTRIBUTION where AD_Client_ID=1001248
;
update M_InOut set c_invoice_id=null where AD_Client_ID=1001248
;
update M_InOut set c_order_id=null where AD_Client_ID=1001248
;
delete from C_PAYMENTDELAY where AD_Client_ID=1001248
;
delete from C_COMMISSIONRUN where AD_Client_ID=1001248
;
delete from M_SO_CREDITNOTE where AD_Client_ID=1001248
;
delete from SFLT_COSTALLOCATION where AD_Client_ID=1001248
;
delete from C_Invoice where AD_Client_ID=1001248
;
delete from C_LANDEDCOSTALLOCATION where AD_Client_ID=1001248
;
delete from C_LANDEDCOST where AD_Client_ID=1001248
;
update M_INOUTLINE set c_orderline_id=null where AD_Client_ID=1001248
;
delete from M_SO_RECEIPT_REVALUATION where AD_Client_ID=1001248
;
delete from M_REQUISITIONLINE where AD_Client_ID=1001248
;
delete from C_ORDERPAYSCHEDULE where AD_Client_ID=1001248
;
delete from C_OrderLine where AD_Client_ID=1001248
;
delete from M_PACKINGLINE where AD_Client_ID=1001248
;
delete from M_INOUTLINE where AD_Client_ID=1001248
;
update M_INOUT set c_order_id=null, c_invoice_id=null, c_project_id=null, ref_inout_id=null, so_meanofconveyance_id=null where AD_Client_ID=1001248
;
update C_Order set c_payment_id=null, c_cashline_id=null, c_project_id=null, ref_order_id=null, orig_inout_id=null where AD_Client_ID=1001248
;
delete from R_REQUESTACTION where AD_Client_ID=1001248
;
delete from M_INOUT where AD_Client_ID=1001248
;
delete from M_Movement where AD_Client_ID=1001248
;
delete from C_PROJECTISSUE where AD_Client_ID=1001248
;
delete from c_projectline where AD_Client_ID=1001248
;
delete from SHRM_TIMESHEET where AD_Client_ID=1001248
;
delete from SFLT_RESOURCEREPORTLINE where AD_Client_ID=1001248
;
delete from A_ASSET_USE where AD_Client_ID=1001248
;
delete from c_projectphase where AD_Client_ID=1001248
;
delete from C_Order where AD_Client_ID=1001248
;
delete from C_Cash where AD_Client_ID=1001248
;
delete from M_SO_PRICELISTUPDATED where AD_Client_ID=1001248
;
delete from M_PRICELIST_VERSION where AD_Client_ID=1001248
;
delete from M_PRICELIST where AD_Client_ID=1001248
;
delete from A_ASSET_ADDITION where AD_Client_ID=1001248
;
delete from A_ASSET_DPR_RATE where AD_Client_ID=1001248
;
delete from A_ASSET_CHANGE where AD_Client_ID=1001248
;
delete from SFLT_MOCINVENTORY where AD_Client_ID=1001248
;
delete from SFLT_RESOURCEREPORT where AD_Client_ID=1001248
;
delete from SFLT_MOCRENT where AD_Client_ID=1001248
;
delete from SFLT_MOCINSPECTION where AD_Client_ID=1001248
;
delete from SFLT_MOCCONTRACT where AD_Client_ID=1001248
;
delete from SFLT_MOCINOUT where AD_Client_ID=1001248
;
delete from SO_MEANOFCONVEYANCE where AD_Client_ID=1001248
;
delete from R_REQUESTACTION where AD_Client_ID=1001248
;
delete from SO_REQUESTUPDMAILNOTIFS where AD_Client_ID=1001248
;
delete from R_REQUESTUPDATE where AD_Client_ID=1001248
;
delete from R_REQUEST where AD_Client_ID=1001248
;
delete from R_REQUESTPROCESSOR where AD_Client_ID=1001248
;
delete from A_ASSET_ACCT_TRANSFER where AD_Client_ID=1001248
;
delete from A_SO_ASSET_ACCT_TRANSFER where AD_Client_ID=1001248
;
delete from A_ASSET_ACCT where ad_client_id=1001248
;
delete from A_ASSET where AD_Client_ID=1001248
;
delete from GL_JOURNALLINE where AD_Client_ID=1001248
;
delete from GL_JOURNAL where AD_Client_ID=1001248
;
delete from GL_JOURNALBATCH where AD_Client_ID=1001248
;
delete from C_VALIDCOMBINATION where AD_Client_ID=1001248 and c_project_id is not null
;
delete from C_PROJECT_MEMBER where AD_Client_ID=1001248
;
delete from C_PROJECT where AD_Client_ID=1001248
;
delete from S_TimeExpense where AD_Client_ID=1001248
;
delete from C_SO_AcctReevaluation where AD_Client_ID=1001248
;
delete from AD_TREENODEPR where AD_Client_ID=1001248
;
delete from C_ACCTSCHEMA_DEFAULT where AD_Client_ID=1001248
;
delete from C_BPARTNER where AD_Client_ID=1001248
;
delete from C_BP_GROUP_TRL where AD_Client_ID=1001248
;
delete from C_BP_GROUP where AD_Client_ID=1001248
;
delete from C_CHARGE where AD_Client_ID=1001248
;
delete from M_PRODUCT where AD_Client_ID=1001248
;
delete from M_PRODUCT_CATEGORY_TRL where AD_Client_ID=1001248
;
delete from M_PRODUCT_CATEGORY where AD_Client_ID=1001248
;
delete from M_ATTRIBUTESET where AD_Client_ID=1001248
;
delete from C_BANK where AD_Client_ID=1001248
;
delete from C_PAYMENTTERM where AD_Client_ID=1001248
;
delete from M_WAREHOUSE where AD_Client_ID=1001248
;
delete from AD_OrgType where AD_Client_ID=1001248
;
delete from AD_PINSTANCE where AD_Client_ID=1001248
;
delete from C_ACCTSCHEMA_ELEMENT where AD_Client_ID=1001248
;
delete from AD_WINDOWLOG where AD_Client_ID=1001248
;
delete from AD_Org where AD_Client_ID=1001248
;
update AD_ClientInfo set C_AcctSchema1_ID = null where AD_Client_ID=1001248
;
delete from A_ASSET_GROUP_ACCT where AD_Client_ID=1001248
;
delete from A_Asset_Group where AD_Client_ID=1001248
;
delete from FACT_ACCUMULATION where AD_Client_ID=1001248
;
delete from C_ACCTPROCESSOR where AD_Client_ID=1001248
;
delete from C_AcctSchema where AD_Client_ID=1001248
;
delete from PA_REPORTSOURCE where AD_Client_ID=1001248
;
delete from PA_REPORT where AD_Client_ID=1001248
;
delete from SO_TAXCOLUMN_BIT where AD_Client_ID=1001248
;
delete from SO_TaxColumnSet_Bit where AD_Client_ID=1001248
;
delete from PA_REPORTCOLUMN where AD_Client_ID=1001248
;
delete from PA_REPORTLINE where AD_Client_ID=1001248
;
delete from PA_REPORTCOLUMNSET where AD_Client_ID=1001248
;
delete from PA_REPORTLINESET where AD_Client_ID=1001248
;
delete from C_Element where AD_Client_ID=1001248
;
delete from AD_USER where AD_Client_ID=1001248
;
delete from AD_SESSION where AD_Client_ID=1001248
;
delete from AD_Role where AD_Client_ID=1001248
;
delete from C_DOCTYPE where AD_Client_ID=1001248
;
delete from AD_SEQUENCE where AD_Client_ID=1001248
;
delete from C_PERIODCONTROL where AD_Client_ID=1001248
;
delete from C_PERIOD where AD_Client_ID=1001248
;
delete from AD_CLIENTINFO where AD_Client_ID=1001248
;
delete from C_YEAR where AD_Client_ID=1001248
;
delete from C_CALENDAR where AD_Client_ID=1001248
;
delete from C_NONBUSINESSDAY where AD_Client_ID=1001248
;
delete from C_LOCATION where AD_Client_ID=1001248
;
delete from GL_CATEGORY where AD_Client_ID=1001248
;
delete from M_DISCOUNTSCHEMA where AD_Client_ID=1001248
;
delete from C_TAX where AD_Client_ID=1001248
;
delete from C_TAXCATEGORY where AD_Client_ID=1001248
;
delete from M_COSTELEMENT where AD_Client_ID=1001248
;
delete from AD_PRINTFORM where AD_Client_ID=1001248
;
delete from AD_PRINTFORMATITEM where AD_Client_ID=1001248
;
delete from AD_PRINTFORMAT where AD_Client_ID=1001248
;
delete from C_PAYMENTMODE where AD_Client_ID=1001248
;
delete from PA_HIERARCHY where AD_Client_ID=1001248
;
delete from AD_TREENODE where AD_Client_ID=1001248
;
delete from AD_CLIENTQUEUE where Tenant_ID=1001248
;
delete from AD_CLIENTCOMPONENT where AD_ClientInclude_ID=1001248
;
delete from SCQM_TenantQuota where AD_ClientInclude_ID=1001248
;
delete from M_COSTTYPE where AD_Client_ID=1001248
;
delete from AD_TREE where AD_Client_ID=1001248
;
delete from AD_PREFERENCE where AD_Client_ID=1001248
;
delete from AD_TREENODEBP where AD_Client_ID=1001248
;
delete from C_INVOICESCHEDULE where AD_Client_ID=1001248
;
delete from M_RETURNPOLICY where AD_Client_ID=1001248
;
delete from SEMS_Message where AD_Client_ID=1001248
;

delete from AD_Client where AD_Client_ID=1001248
;


--select * from user_constraints where constraint_name = 'FK432_5722'
--;