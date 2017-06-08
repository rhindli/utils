
--Tablespace size and usage
select
file_name,
autoextensible,
(bytes/1024)/1024 usedmb,
(maxbytes/1024)/1024 maxmb,
round((((bytes/1024)/1024)
/ ((maxbytes/1024)/1024)) * 100) used_percentage
from dba_data_files
where tablespace_name = 'SYSTEM';

/*
 * Increase max tablespace size;
 * datafile = FILE_NAME from previous select
 * maxsize = wanted size in MB * 1024 * 1024
 */
alter database datafile 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF' autoextend on maxsize 943718400;