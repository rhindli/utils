--spool /Users/hrobert/dev/tmp/BeforeMigrate2007.txt
--@/Users/hrobert/dev/utils/scloud/sql/tmp/BeforeMigrate2007.sql
--spool off

--spool /Users/hrobert/dev/tmp/BeforeMigrate2003_UpdateHelp.txt
--@/Users/hrobert/dev/utils/scloud/sql/tmp/BeforeMigrate2003_UpdateHelp.sql
--spool off


spool /Users/hrobert/dev/tmp/DBMigration2007.txt
@/Users/hrobert/dev/utils/scloud/sql/tmp/DBMigration2007.sql
spool off


--spool /Users/hrobert/dev/tmp/v19.09.02.txt
--@/Users/hrobert/dev/utils/scloud/sql/tmp/v19.09.02.sql
--spool off


--ALTER PROCEDURE DBA_RECOMPILE COMPILE
--/
--EXEC DBA_RECOMPILE(NULL)
--/
