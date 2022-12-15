CREATE OR REPLACE VIEW ad_sql_v_componentizare
AS SELECT c.ad_column_id AS update_key,
    'ad_column_id'::text AS update_column_key,
    'columnsql'::text AS update_column,
    c.ad_client_id,
    c.ad_org_id,
    c.isactive,
    c.created,
    c.updated,
    'AD_Column'::text AS tablename,
    t.tablename AS tabledesc,
    c.columnname,
    c.entitytype,
    c.columnsql AS sql
   FROM ad_column c
     JOIN ad_table t ON c.ad_table_id = t.ad_table_id
  WHERE c.columnsql IS NOT NULL
UNION ALL
 SELECT c.ad_column_id AS update_key,
    'ad_column_id'::text AS update_column_key,
    'defaultvalue'::text AS update_column,
    c.ad_client_id,
    c.ad_org_id,
    c.isactive,
    c.created,
    c.updated,
    'AD_Column'::text AS tablename,
    t.tablename AS tabledesc,
    'DefaultValue'::character varying AS columnname,
    c.entitytype,
    c.defaultvalue AS sql
   FROM ad_column c
     JOIN ad_table t ON c.ad_table_id = t.ad_table_id
  WHERE c.defaultvalue IS NOT NULL 
UNION ALL
 SELECT c.ad_column_id AS update_key,
    'ad_column_id'::text AS update_column_key,
    'readonlylogic'::text AS update_column,
    c.ad_client_id,
    c.ad_org_id,
    c.isactive,
    c.created,
    c.updated,
    'AD_Column'::text AS tablename,
    t.tablename AS tabledesc,
    'ReadOnlyLogic'::character varying AS columnname,
    c.entitytype,
    c.readonlylogic AS sql
   FROM ad_column c
     JOIN ad_table t ON c.ad_table_id = t.ad_table_id
  WHERE c.readonlylogic IS NOT NULL 
UNION ALL
 SELECT c.ad_column_id AS update_key,
    'ad_column_id'::text AS update_column_key,
    'mandatorylogic'::text AS update_column,
    c.ad_client_id,
    c.ad_org_id,
    c.isactive,
    c.created,
    c.updated,
    'AD_Column'::text AS tablename,
    t.tablename AS tabledesc,
    'MandatoryLogic'::character varying AS columnname,
    c.entitytype,
    c.mandatorylogic AS sql
   FROM ad_column c
     JOIN ad_table t ON c.ad_table_id = t.ad_table_id
  WHERE c.mandatorylogic IS NOT null
UNION ALL
 SELECT t.ad_tab_id AS update_key,
    'ad_tab_id'::text AS update_column_key,
    'whereclause'::text AS update_column,
    t.ad_client_id,
    t.ad_org_id,
    t.isactive,
    t.created,
    t.updated,
    'AD_Tab'::text AS tablename,
    t.name AS tabledesc,
    'WhereClause'::character varying AS columnname,
    t.entitytype,
    t.whereclause AS sql
   FROM ad_tab t
  WHERE t.whereclause IS NOT NULL
UNION ALL
 SELECT t.ad_tab_id AS update_key,
    'ad_tab_id'::text AS update_column_key,
    'orderbyclause'::text AS update_column,
    t.ad_client_id,
    t.ad_org_id,
    t.isactive,
    t.created,
    t.updated,
    'AD_Tab'::text AS tablename,
    t.name AS tabledesc,
    'OrderByClause'::character varying AS columnname,
    t.entitytype,
    t.orderbyclause AS sql
   FROM ad_tab t
  WHERE t.orderbyclause IS NOT NULL
UNION ALL
 SELECT t.ad_tab_id AS update_key,
    'ad_tab_id'::text AS update_column_key,
    'warninglogic'::text AS update_column,
    t.ad_client_id,
    t.ad_org_id,
    t.isactive,
    t.created,
    t.updated,
    'AD_Tab'::text AS tablename,
    t.name AS tabledesc,
    'WarningLogic'::character varying AS columnname,
    t.entitytype,
    t.warninglogic AS sql
   FROM ad_tab t
  WHERE t.warninglogic IS NOT NULL
UNION ALL
 SELECT t.ad_tab_id AS update_key,
    'ad_tab_id'::text AS update_column_key,
    'readonlylogicallfields'::text AS update_column,
    t.ad_client_id,
    t.ad_org_id,
    t.isactive,
    t.created,
    t.updated,
    'AD_Tab'::text AS tablename,
    t.name AS tabledesc,
    'ReadOnlyLogicAllFields'::character varying AS columnname,
    t.entitytype,
    t.ReadOnlyLogicAllFields AS sql
   FROM ad_tab t
  WHERE t.ReadOnlyLogicAllFields IS NOT NULL
UNION ALL
 SELECT t.ad_tab_id AS update_key,
    'ad_tab_id'::text AS update_column_key,
    'displaylogic'::text AS update_column,
    t.ad_client_id,
    t.ad_org_id,
    t.isactive,
    t.created,
    t.updated,
    'AD_Tab'::text AS tablename,
    t.name AS tabledesc,
    'DisplayLogic'::character varying AS columnname,
    t.entitytype,
    t.displaylogic AS sql
   FROM ad_tab t
  WHERE t.displaylogic IS NOT NULL
UNION ALL
 SELECT f.ad_field_id AS update_key,
    'ad_field_id'::text AS update_column_key,
    'readonlylogic'::text AS update_column,
    f.ad_client_id,
    f.ad_org_id,
    f.isactive,
    f.created,
    f.updated,
    'AD_Field'::text AS tablename,
    f.name AS tabledesc,
    'ReadOnlyLogic'::character varying AS columnname,
    f.entitytype,
    f.readonlylogic AS sql
   FROM ad_field f
  WHERE f.readonlylogic IS NOT NULL
UNION ALL
 SELECT f.ad_field_id AS update_key,
    'ad_field_id'::text AS update_column_key,
    'displaylogic'::text AS update_column,
    f.ad_client_id,
    f.ad_org_id,
    f.isactive,
    f.created,
    f.updated,
    'AD_Field'::text AS tablename,
    f.name AS tabledesc,
    'DisplayLogic'::character varying AS columnname,
    f.entitytype,
    f.displaylogic AS sql
   FROM ad_field f
  WHERE f.displaylogic IS NOT NULL
UNION ALL
 SELECT vr.ad_val_rule_id AS update_key,
    'ad_val_rule_id'::text AS update_column_key,
    'code'::text AS update_column,
    vr.ad_client_id,
    vr.ad_org_id,
    vr.isactive,
    vr.created,
    vr.updated,
    'AD_Val_Rule'::text AS tablename,
    vr.name AS tabledesc,
    'Code'::character varying AS columnname,
    vr.entitytype,
    vr.code AS sql
   FROM ad_val_rule vr
  WHERE vr.code IS NOT NULL
UNION ALL
 SELECT iw.ad_infowindow_id AS update_key,
    'ad_infowindow_id'::text AS update_column_key,
    'fromclause'::text AS update_column,
    iw.ad_client_id,
    iw.ad_org_id,
    iw.isactive,
    iw.created,
    iw.updated,
    'AD_InfoWindow'::text AS tablename,
    iw.name AS tabledesc,
    'FromClause'::character varying AS columnname,
    iw.entitytype,
    iw.fromclause AS sql
   FROM ad_infowindow iw
  WHERE iw.fromclause IS NOT NULL
UNION ALL
 SELECT iw.ad_infowindow_id AS update_key,
    'ad_infowindow_id'::text AS update_column_key,
    'fromclause2'::text AS update_column,
    iw.ad_client_id,
    iw.ad_org_id,
    iw.isactive,
    iw.created,
    iw.updated,
    'AD_InfoWindow'::text AS tablename,
    iw.name AS tabledesc,
    'FromClause2'::character varying AS columnname,
    iw.entitytype,
    iw.fromclause2 AS sql
   FROM ad_infowindow iw
  WHERE iw.fromclause2 IS NOT NULL
UNION ALL
 SELECT iw.ad_infowindow_id AS update_key,
    'ad_infowindow_id'::text AS update_column_key,
    'otherclause'::text AS update_column,
    iw.ad_client_id,
    iw.ad_org_id,
    iw.isactive,
    iw.created,
    iw.updated,
    'AD_InfoWindow'::text AS tablename,
    iw.name AS tabledesc,
    'OtherClause'::character varying AS columnname,
    iw.entitytype,
    iw.otherclause AS sql
   FROM ad_infowindow iw
  WHERE iw.otherclause IS NOT NULL
UNION ALL
 SELECT iw.ad_infowindow_id AS update_key,
    'ad_infowindow_id'::text AS update_column_key,
    'autocompfromclause'::text AS update_column,
    iw.ad_client_id,
    iw.ad_org_id,
    iw.isactive,
    iw.created,
    iw.updated,
    'AD_InfoWindow'::text AS tablename,
    iw.name AS tabledesc,
    'AutoCompFromClause'::character varying AS columnname,
    iw.entitytype,
    iw.autocompfromclause AS sql
   FROM ad_infowindow iw
  WHERE iw.autocompfromclause IS NOT NULL
UNION ALL
 SELECT ic.ad_infocolumn_id AS update_key,
    'ad_infocolumn_id'::text AS update_column_key,
    'selectclause'::text AS update_column,
    ic.ad_client_id,
    ic.ad_org_id,
    ic.isactive,
    ic.created,
    ic.updated,
    'AD_InfoColumn'::text AS tablename,
    iw.name AS tabledesc,
    e.columnname,
    ic.entitytype,
    ic.selectclause AS sql
   FROM ad_infocolumn ic
     LEFT JOIN ad_element e ON ic.ad_element_id = e.ad_element_id
     JOIN ad_infowindow iw ON ic.ad_infowindow_id = iw.ad_infowindow_id
  WHERE ic.selectclause IS NOT NULL
UNION ALL
 SELECT ar.ad_alertrule_id AS update_key,
    'ad_alertrule_id'::text AS update_column_key,
    'selectclause'::text AS update_column,
    ar.ad_client_id,
    ar.ad_org_id,
    ar.isactive,
    ar.created,
    ar.updated,
    'AD_AlertRule'::text AS tablename,
    a.name AS tabledesc,
    'SelectClause'::character varying AS columnname,
    NULL::character varying AS entitytype,
    ar.selectclause AS sql
   FROM ad_alertrule ar
     JOIN ad_alert a ON ar.ad_alert_id = a.ad_alert_id
  WHERE ar.selectclause IS NOT NULL
UNION ALL
 SELECT ar.ad_alertrule_id AS update_key,
    'ad_alertrule_id'::text AS update_column_key,
    'fromclause'::text AS update_column,
    ar.ad_client_id,
    ar.ad_org_id,
    ar.isactive,
    ar.created,
    ar.updated,
    'AD_AlertRule'::text AS tablename,
    a.name AS tabledesc,
    'FromClause'::character varying AS columnname,
    NULL::character varying AS entitytype,
    ar.fromclause AS sql
   FROM ad_alertrule ar
     JOIN ad_alert a ON ar.ad_alert_id = a.ad_alert_id
  WHERE ar.fromclause IS NOT NULL
UNION ALL
 SELECT ar.ad_alertrule_id AS update_key,
    'ad_alertrule_id'::text AS update_column_key,
    'whereclause'::text AS update_column,
    ar.ad_client_id,
    ar.ad_org_id,
    ar.isactive,
    ar.created,
    ar.updated,
    'AD_AlertRule'::text AS tablename,
    a.name AS tabledesc,
    'WhereClause'::character varying AS columnname,
    NULL::character varying AS entitytype,
    ar.whereclause AS sql
   FROM ad_alertrule ar
     JOIN ad_alert a ON ar.ad_alert_id = a.ad_alert_id
  WHERE ar.whereclause IS NOT NULL
UNION ALL
 SELECT ar.ad_alertrule_id AS update_key,
    'ad_alertrule_id'::text AS update_column_key,
    'otherclause'::text AS update_column,
    ar.ad_client_id,
    ar.ad_org_id,
    ar.isactive,
    ar.created,
    ar.updated,
    'AD_AlertRule'::text AS tablename,
    a.name AS tabledesc,
    'OtherClause'::character varying AS columnname,
    NULL::character varying AS entitytype,
    ar.otherclause AS sql
   FROM ad_alertrule ar
     JOIN ad_alert a ON ar.ad_alert_id = a.ad_alert_id
  WHERE ar.otherclause IS NOT NULL
UNION ALL
 SELECT ar.ad_alertrule_id AS update_key,
    'ad_alertrule_id'::text AS update_column_key,
    'otherclause'::text AS update_column,
    ar.ad_client_id,
    ar.ad_org_id,
    ar.isactive,
    ar.created,
    ar.updated,
    'AD_AlertRule'::text AS tablename,
    a.name AS tabledesc,
    'OtherClause'::character varying AS columnname,
    NULL::character varying AS entitytype,
    ar.otherclause AS sql
   FROM ad_alertrule ar
     JOIN ad_alert a ON ar.ad_alert_id = a.ad_alert_id
  WHERE ar.otherclause IS NOT NULL
UNION ALL
 SELECT rv.ad_reportview_id AS update_key,
    'ad_reportview_id'::text AS update_column_key,
    'whereclause'::text AS update_column,
    rv.ad_client_id,
    rv.ad_org_id,
    rv.isactive,
    rv.created,
    rv.updated,
    'AD_ReportView'::text AS tablename,
    rv.name AS tabledesc,
    'WhereClause'::character varying AS columnname,
    rv.entitytype,
    rv.whereclause AS sql
   FROM ad_reportview rv
  WHERE rv.whereclause IS NOT NULL
UNION ALL
 SELECT rv.ad_reportview_id AS update_key,
    'ad_reportview_id'::text AS update_column_key,
    'orderbyclause'::text AS update_column,
    rv.ad_client_id,
    rv.ad_org_id,
    rv.isactive,
    rv.created,
    rv.updated,
    'AD_ReportView'::text AS tablename,
    rv.name AS tabledesc,
    'OrderByClause'::character varying AS columnname,
    rv.entitytype,
    rv.orderbyclause AS sql
   FROM ad_reportview rv
  WHERE rv.orderbyclause IS NOT NULL
UNION ALL
 SELECT pp.ad_process_para_id AS update_key,
    'ad_process_para_id'::text AS update_column_key,
    'defaultvalue'::text AS update_column,
    pp.ad_client_id,
    pp.ad_org_id,
    pp.isactive,
    pp.created,
    pp.updated,
    'AD_Process_Para'::text AS tablename,
    p.name AS tabledesc,
    'DefaultValue'::character varying AS columnname,
    pp.entitytype,
    pp.defaultvalue AS sql
   FROM ad_process_para pp
     JOIN ad_process p ON pp.ad_process_id = p.ad_process_id
  WHERE pp.defaultvalue IS NOT null
UNION ALL
 SELECT pp.ad_process_para_id AS update_key,
    'ad_process_para_id'::text AS update_column_key,
    'defaultvalue2'::text AS update_column,
    pp.ad_client_id,
    pp.ad_org_id,
    pp.isactive,
    pp.created,
    pp.updated,
    'AD_Process_Para'::text AS tablename,
    p.name AS tabledesc,
    'DefaultValue2'::character varying AS columnname,
    pp.entitytype,
    pp.defaultvalue2 AS sql
   FROM ad_process_para pp
     JOIN ad_process p ON pp.ad_process_id = p.ad_process_id
  WHERE pp.defaultvalue2 IS NOT NULL 
UNION ALL
 SELECT rt.ad_reference_id AS update_key,
    'ad_reference_id'::text AS update_column_key,
    'whereclause'::text AS update_column,
    rt.ad_client_id,
    rt.ad_org_id,
    rt.isactive,
    rt.created,
    rt.updated,
    'AD_Ref_Table'::text AS tablename,
    r.name AS tabledesc,
    'WhereClause'::character varying AS columnname,
    rt.entitytype,
    rt.whereclause AS sql
   FROM ad_ref_table rt
     JOIN ad_reference r ON rt.ad_reference_id = r.ad_reference_id
  WHERE rt.whereclause IS NOT NULL
UNION ALL
 SELECT rt.ad_reference_id AS update_key,
    'ad_reference_id'::text AS update_column_key,
    'orderbyclause'::text AS update_column,
    rt.ad_client_id,
    rt.ad_org_id,
    rt.isactive,
    rt.created,
    rt.updated,
    'AD_Ref_Table'::text AS tablename,
    r.name AS tabledesc,
    'OrderByClause'::character varying AS columnname,
    rt.entitytype,
    rt.orderbyclause AS sql
   FROM ad_ref_table rt
     JOIN ad_reference r ON rt.ad_reference_id = r.ad_reference_id
  WHERE rt.orderbyclause IS NOT NULL;