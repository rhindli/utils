select job_name, session_id, 
'exec sys.dbms_scheduler.STOP_JOB(job_name=>''' || owner || '.' || job_name || ''', force=>true);'
from dba_scheduler_running_jobs;

exec sys.dbms_scheduler.STOP_JOB(job_name=>'SCLOUD_EU1_ADMIN.GATHER_SCHEMA_STATISTICS', force=>true);