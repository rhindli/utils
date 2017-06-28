SELECT * FROM v$session;

SELECT schemaname, count(*) 
FROM v$session 
group by schemaname
order by schemaname;

SELECT schemaname, module, count(*) 
FROM v$session 
where SchemaName='SCLOUD'
group by schemaname, module
order by schemaname, module;

SELECT count(*) 
FROM v$session 
where SchemaName='SCLOUD'
;

select * from AD_User_Roles where AD_User_ID=100;