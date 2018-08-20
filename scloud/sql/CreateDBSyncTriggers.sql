/*** Create triggers to sync table data ***/
DECLARE
    p_sorefSchemaName VARCHAR2(30) := 'SOREFDEV';
    p_targetSchemaName VARCHAR2(30) := 'sodev';
    v_sql VARCHAR2(2000);
BEGIN

        for tableToSync in (
                SELECT UPPER(T.TABLENAME) AS TABLENAME 
                FROM AD_TABLE T 
                    JOIN AD_ENTITYTYPE E ON T.ENTITYTYPE = E.ENTITYTYPE 
                WHERE T.ENTITYTYPE IN(  'C', 'D'
                 , 'SEDI', 'SFLT', 'SHRM', 'SMRP', 'SOBK', 'SOD', 'SOHH', 'SDEI', 'SWSS', 'SELE', 'SBIT', 'SOFF', 'SPOS', 'SMAG'
                 , 'SMST', 'SDWH', 'SWEB', 'SGAP', 'SAGR', 'SFXA', 'SFRO', 'SRPD', 'SMON', 'SCQM'
                 , 'CAPI', 'SMOB', 'SFHU', 'STLN', 'SWMS', 'SEMS', 'SCWI', 'SPRJ', 'SPRC', 'STRL', 'CSEC', 'SDEV', 'SZPM', 'SUMS', 'SMLM', 'SPRV'
                 , 'ITAS', 'SWST', 'SCLD', 'SICM'
                 , 'PAER', 'PF64', 'PRDS', 'PAUR', 'PBIT', 'PMED', 'PAVG', 'PIRW', 'PCSD', 'PDEL', 'PRKS', 'PROP' 
                 , 'XUOM', 'XHRS'
                  ) 
                    AND EXISTS (SELECT * 
                                FROM AD_COLUMN 
                            WHERE UPPER(COLUMNNAME) = 'ENTITYTYPE' 
                            AND AD_COLUMN.AD_TABLE_ID = T.AD_TABLE_ID) 
                    AND UPPER(T.TABLENAME) NOT IN ('AD_ENTITYTYPE', 'SO_DBOBJECT', 'AD_CLIENTCOMPONENT', 'SCQM_TENANTQUOTA') 
                    AND T.ISVIEW = 'N'
                UNION
                SELECT UPPER(TRL.TABLENAME) AS TRL_TABLENAME
                FROM AD_TABLE T 
                    JOIN AD_TABLE TRL ON UPPER(T.TABLENAME) || '_TRL' = UPPER(TRL.TABLENAME) 
                    JOIN AD_ENTITYTYPE E ON T.ENTITYTYPE = E.ENTITYTYPE 
                WHERE T.ENTITYTYPE IN(  'C', 'D'
                 , 'SEDI', 'SFLT', 'SHRM', 'SMRP', 'SOBK', 'SOD', 'SOHH', 'SDEI', 'SWSS', 'SELE', 'SBIT', 'SOFF', 'SPOS', 'SMAG'
                 , 'SMST', 'SDWH', 'SWEB', 'SGAP', 'SAGR', 'SFXA', 'SFRO', 'SRPD', 'SMON', 'SCQM'
                 , 'CAPI', 'SMOB', 'SFHU', 'STLN', 'SWMS', 'SEMS', 'SCWI', 'SPRJ', 'SPRC', 'STRL', 'CSEC', 'SDEV', 'SZPM', 'SUMS', 'SMLM', 'SPRV'
                 , 'ITAS', 'SWST', 'SCLD', 'SICM'
                 , 'PAER', 'PF64', 'PRDS', 'PAUR', 'PBIT', 'PMED', 'PAVG', 'PIRW', 'PCSD', 'PDEL', 'PRKS', 'PROP' 
                 , 'XUOM', 'XHRS'
                  ) 
                    AND EXISTS (SELECT * 
                                FROM AD_COLUMN 
                            WHERE UPPER(COLUMNNAME) = 'ENTITYTYPE' 
                            AND AD_COLUMN.AD_TABLE_ID = T.AD_TABLE_ID) 
                    AND UPPER(T.TABLENAME) NOT IN ('AD_ENTITYTYPE', 'SO_DBOBJECT', 'AD_CLIENTCOMPONENT', 'SCQM_TENANTQUOTA') 
                    AND T.ISVIEW = 'N'
                UNION
                SELECT N'AD_ENTITYTYPE' FROM DUAL
                UNION
                SELECT N'AD_IMPFORMAT' FROM DUAL
                UNION
                SELECT N'AD_IMPFORMAT_ROW' FROM DUAL
                UNION
                SELECT N'AD_MIGRATIONSTEP' FROM DUAL
                UNION
                SELECT N'AD_PRINTCOLOR' FROM DUAL
                UNION
                SELECT N'AD_PRINTFONT' FROM DUAL
                UNION
                SELECT N'AD_PRINTFORM' FROM DUAL
                UNION
                SELECT N'AD_PRINTFORMAT' FROM DUAL
                UNION
                SELECT N'AD_PRINTFORMAT_TRL' FROM DUAL
                UNION
                SELECT N'AD_PRINTFORMATITEM' FROM DUAL
                UNION
                SELECT N'AD_PRINTFORMATITEM_TRL' FROM DUAL
                UNION
                SELECT N'AD_PRINTGRAPH' FROM DUAL
                UNION
                SELECT N'AD_PRINTPAPER' FROM DUAL
                UNION
                SELECT N'AD_PRINTTABLEFORMAT' FROM DUAL
                UNION
                SELECT N'AD_REPORTVIEW_COL' FROM DUAL
                UNION
                SELECT N'AD_SCHEDULE' FROM DUAL
                UNION
                SELECT N'AD_SCHEDULER' FROM DUAL
                UNION
                SELECT N'AD_SCHEDULER_PARA' FROM DUAL
                UNION
                SELECT N'AD_TABLEINDEX' FROM DUAL
                UNION
                SELECT N'AD_WF_BLOCK' FROM DUAL
                UNION
                SELECT N'C_DOCTYPE' FROM DUAL
                UNION
                SELECT N'C_DOCTYPE_TRL' FROM DUAL
                UNION
                SELECT N'AD_TREE' FROM DUAL
                UNION
                SELECT N'AD_TREENODE' FROM DUAL
                UNION
                SELECT N'C_ELEMENTBASE' FROM DUAL
                UNION
                SELECT N'C_ELEMENTVALUEBASE' FROM DUAL
                UNION
                SELECT N'AD_FORMPROCESS' FROM DUAL
                UNION
                SELECT N'C_ACCOUNTGROUP' FROM DUAL
                UNION
                SELECT N'C_ACCOUNTGROUP_TRL' FROM DUAL
                UNION
                SELECT N'GL_CATEGORY_TMPL' FROM DUAL
                UNION
                SELECT N'GL_CATEGORY_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'C_DOCTYPE_TMPL' FROM DUAL
                UNION
                SELECT N'C_DOCTYPE_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'C_NONBUSINESSDAY_TMPL' FROM DUAL
                UNION
                SELECT N'AD_ORGTYPE_TMPL' FROM DUAL
                UNION
                SELECT N'AD_ORGTYPE_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'C_TAXCATEGORY_TMPL' FROM DUAL
                UNION
                SELECT N'C_TAXCATEGORY_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'C_TAX_TMPL' FROM DUAL
                UNION
                SELECT N'C_TAX_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'SO_TAXCOLUMNSET_TMPL' FROM DUAL
                UNION
                SELECT N'SO_TAXCOLUMN_TMPL' FROM DUAL
                UNION
                SELECT N'PA_REPORTLINESET_TMPL' FROM DUAL
                UNION
                SELECT N'PA_REPORTLINE_TMPL' FROM DUAL
                UNION
                SELECT N'PA_REPORTSOURCE_TMPL' FROM DUAL
                UNION
                SELECT N'PA_REPORTCOLUMNSET_TMPL' FROM DUAL
                UNION
                SELECT N'PA_REPORTCOLUMN_TMPL' FROM DUAL
                UNION
                SELECT N'PA_REPORT_TMPL' FROM DUAL
                UNION
                SELECT N'A_ASSET_GROUP_TMPL' FROM DUAL
                UNION
                SELECT N'A_ASSET_GROUP_ACCT_TMPL' FROM DUAL
                UNION
                SELECT N'C_CHARGE_TMPL' FROM DUAL
                UNION
                SELECT N'C_CHARGE_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'C_CHARGE_ACCT_TMPL' FROM DUAL
                UNION
                SELECT N'M_PRODUCT_CATEGORY_TMPL' FROM DUAL
                UNION
                SELECT N'M_PRODUCT_CATEGORY_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'M_PRODUCT_TMPL' FROM DUAL
                UNION
                SELECT N'M_PRODUCT_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'M_PRODUCT_ACCT_TMPL' FROM DUAL
                UNION
                SELECT N'C_PAYMENTMODE_TMPL' FROM DUAL
                UNION
                SELECT N'C_PAYMENTTERM_TMPL' FROM DUAL
                UNION
                SELECT N'C_PAYMENTTERM_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'C_BP_GROUP_TMPL' FROM DUAL
                UNION
                SELECT N'C_BP_GROUP_TMPL_TRL' FROM DUAL
                UNION
                SELECT N'C_BP_GROUP_ACCT_TMPL' FROM DUAL
            )
    LOOP
        BEGIN
            SC_Sync_Dictionary.create_table_trigger(p_table_name => tableToSync.TABLENAME, p_database_link_name => null, p_schema_name => p_targetSchemaName);
        EXCEPTION
            WHEN OTHERS THEN
                raise_application_error (-20001, 'CREATE TRIGGER FOR ' || tableToSync.TABLENAME || ' failed: ' || SQLERRM);
        END;
    END LOOP;
END;

/*** Create trigger to sync DDL ***/
DECLARE
    p_sorefSchemaName VARCHAR2(30) := 'SOREFDEV';
    p_targetSchemaName VARCHAR2(30) := 'sodev';
    v_sql VARCHAR2(2000);
BEGIN
    
    BEGIN
        SC_Sync_Dictionary.create_database_trigger(p_audited_schema_name => p_sorefSchemaName, p_database_link_name => null, p_schema_name => p_TargetSchemaName);
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error (-20001, 'CREATE DDL trigger failed: ' || SQLERRM);
    END;
END;


/* Drop created triggers */

/*

--Drop triggers to sync table data
BEGIN
    for object in (SELECT Object_Name FROM user_objects where Object_type='TRIGGER' AND 
        Object_NAME like 'TSC_%')
    loop
        execute immediate 'DROP TRIGGER ' || object.Object_Name;
    end loop;
END;
/
--Drop trigger to sync DDL
BEGIN
    execute immediate 'DROP TRIGGER TRG_SYNC_WITH_DEV';
END;

--Drop sql executor
DECLARE
    p_targetSchemaName VARCHAR2(30) := 'sodev';
    v_cnt NUMBER;
    v_sql CLOB;
BEGIN
		v_sql := 'SELECT COUNT(*) FROM all_sequences WHERE Sequence_Owner = '''||upper(p_targetSchemaName)||''' AND Sequence_Name = ''SC_SYNC_LOG_SEQ''';
	    EXECUTE IMMEDIATE v_sql INTO v_cnt;

	    IF v_cnt > 0 THEN
		    v_sql   := 'DROP SEQUENCE '||p_targetSchemaName||'.SC_SYNC_LOG_SEQ';
		    EXECUTE IMMEDIATE v_sql;
	    END IF;

		v_sql := 'SELECT COUNT(*) FROM all_tables WHERE Owner = '''||upper(p_targetSchemaName)||''' AND Table_Name = ''SC_SYNC_LOG''';
	    EXECUTE IMMEDIATE v_sql INTO v_cnt;

	    IF v_cnt > 0 THEN
		    v_sql   := 'DROP TABLE '||p_targetSchemaName||'.SC_SYNC_LOG';
		    EXECUTE IMMEDIATE v_sql;
	    END IF;
END;

--Disable triggers to sync table data
BEGIN
    for object in (SELECT Object_Name FROM user_objects where Object_type='TRIGGER' AND 
        Object_NAME like 'TSC_%')
    loop
        execute immediate 'ALTER TRIGGER ' || object.Object_Name || ' DISABLE';
    end loop;
END;
/
--Disable trigger to sync DDL
BEGIN
    execute immediate 'ALTER TRIGGER TRG_SYNC_WITH_DEV DISABLE';
END;

--Enable triggers to sync table data
BEGIN
    for object in (SELECT Object_Name FROM user_objects where Object_type='TRIGGER' AND 
        Object_NAME like 'TSC_%')
    loop
        execute immediate 'ALTER TRIGGER ' || object.Object_Name || ' ENABLE';
    end loop;
END;
/
--Enable trigger to sync DDL
BEGIN
    execute immediate 'ALTER TRIGGER TRG_SYNC_WITH_DEV ENABLE';
END;
*/

/*** Test create SQL executor ***/
DECLARE
    p_targetSchemaName VARCHAR2(30) := 'sodev';
BEGIN
    
    BEGIN
        SC_Sync_Dictionary.create_sql_executor(p_schema_name => p_TargetSchemaName);
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error (-20001, 'CREATE SQL Executor failed: ' || SQLERRM);
    END;
END;

/*** Get Entity types to be inserted in target schema that are not migrated ***/
select e.* from AD_EntityType e
left join sodev.AD_EntityType s on s.EntityType = e.EntityType
where s.EntityType is null;

