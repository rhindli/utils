select * from ROLE_TAB_PRIVS  where ROLE = 'UNIT_TEST_ROLE' and TABLE_NAME='SCWI_EXTENDED_PRODUCT';


--list tables/view on which UNIT_TEST_ROLE has no privilege
select t.TableName, t.EntityType from AD_Table t
where not exists(select * from ROLE_TAB_PRIVS r where r.ROLE = 'UNIT_TEST_ROLE' and r.TABLE_NAME=upper(TableName))
and t.IsActive='Y'
and t.EntityType in ('SRPD') --('SCWI', 'STLN')
order by t.TableName;

--create script to grant privileges on tables/views
select 'GRANT ALL ON SCTCASE.'||t.TableName||' TO UNIT_TEST_ROLE;' from AD_Table t
where not exists(select * from ROLE_TAB_PRIVS r where r.ROLE = 'UNIT_TEST_ROLE' and r.TABLE_NAME=upper(TableName))
and t.IsActive='Y'
and t.EntityType in ('SRPD') --('SCWI', 'STLN')
order by t.TableName;
 
