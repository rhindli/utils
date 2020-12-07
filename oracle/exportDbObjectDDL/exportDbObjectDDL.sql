SET PAGESIZE 0
SET FEEDBACK OFF

spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/export-proc.sql
select 
'SET PAGESIZE 0'||chr(10)||
'SET FEEDBACK OFF' from sys.dual
UNION ALL
select
'spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/proc/'||object_name||'.sql'||chr(10)||
'SELECT Text FROM SYS.Dba_SOURCE WHERE TYPE = '''||object_type||''' AND OWNER = ''SOREFDEV'' AND NAME = '''||object_name||''' order by Line;'||chr(10)||
'spool off'||chr(10)||
'/'||chr(10)
from user_objects
where object_type = 'PROCEDURE'
;
spool off

/

spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/export-func.sql
select 
'SET PAGESIZE 0'||chr(10)||
'SET FEEDBACK OFF' from sys.dual
UNION ALL
select
'spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/func/'||object_name||'.sql'||chr(10)||
'SELECT Text FROM SYS.Dba_SOURCE WHERE TYPE = '''||object_type||''' AND OWNER = ''SOREFDEV'' AND NAME = '''||object_name||''' order by Line;'||chr(10)||
'spool off'||chr(10)||
'/'||chr(10)
from user_objects
where object_type = 'FUNCTION'
;
spool off

/

spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/export-type.sql
select 
'SET PAGESIZE 0'||chr(10)||
'SET FEEDBACK OFF' from sys.dual
UNION ALL
select
'spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/type/'||object_name||'.sql'||chr(10)||
'SELECT Text FROM SYS.Dba_SOURCE WHERE TYPE = '''||object_type||''' AND OWNER = ''SOREFDEV'' AND NAME = '''||object_name||''' order by Line;'||chr(10)||
'spool off'||chr(10)||
'/'||chr(10)
from user_objects
where object_type = 'TYPE'
;
spool off

/

spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/export-trigger.sql
select 
'SET PAGESIZE 0'||chr(10)||
'SET FEEDBACK OFF' from sys.dual
UNION ALL
select
'spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/trigger/'||object_name||'.sql'||chr(10)||
'SELECT Text FROM SYS.Dba_SOURCE WHERE TYPE = '''||object_type||''' AND OWNER = ''SOREFDEV'' AND NAME = '''||object_name||''' order by Line;'||chr(10)||
'spool off'||chr(10)||
'/'||chr(10)
from user_objects
where object_type = 'TRIGGER'
;
spool off

/


spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/export-view.sql
select 'java -jar scheme2ddl-2.4.2.jar -url user/pwd@host:1521:db_name -tf "''VIEW''" -o /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/view' from dual
;
spool off

/


spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/export-package.sql
select 
'SET PAGESIZE 0'||chr(10)||
'SET FEEDBACK OFF' from sys.dual
UNION ALL
select
'spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/package/'||object_name||'.sql'||chr(10)||
'SELECT Text FROM SYS.Dba_SOURCE WHERE TYPE = '''||object_type||''' AND OWNER = ''SOREFDEV'' AND NAME = '''||object_name||''' order by Line;'||chr(10)||
'spool off'||chr(10)||
'/'||chr(10)
from user_objects
where object_type = 'PACKAGE'
;
spool off

/


spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/export-packagebody.sql
select 
'SET PAGESIZE 0'||chr(10)||
'SET FEEDBACK OFF' from sys.dual
UNION ALL
select
'spool /Users/hrobert/dev/tmp/postgresdiff/oracle/soref/packagebody/'||object_name||'.sql'||chr(10)||
'SELECT Text FROM SYS.Dba_SOURCE WHERE TYPE = '''||object_type||''' AND OWNER = ''SOREFDEV'' AND NAME = '''||object_name||''' order by Line;'||chr(10)||
'spool off'||chr(10)||
'/'||chr(10)
from user_objects
where object_type = 'PACKAGE BODY'
;
spool off

/
