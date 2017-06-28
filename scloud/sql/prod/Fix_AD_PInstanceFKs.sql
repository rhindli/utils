-- *********** Fix C_EDILog *******************
select count(*) from C_EDILog a
left join AD_PInstance b on b.AD_PInstance_ID = a.AD_PInstance_ID
where a.AD_Pinstance_ID is not null
  and b.AD_PInstance_ID is null;
  

update C_EDILog a set a.AD_PInstance_ID = null
where a.AD_PInstance_ID is not null
  and not exists (select * from AD_PInstance b WHERE b.AD_PInstance_ID = a.AD_PInstance_ID);
  
  
-- *********** Fix AD_PInstance_Para *******************
select count(*) from AD_PInstance_Para a
left join AD_PInstance b on b.AD_PInstance_ID = a.AD_PInstance_ID
where a.AD_Pinstance_ID is not null
  and b.AD_PInstance_ID is null;

delete AD_PInstance_Para a
where not exists (select * from AD_PInstance b where b.AD_PInstance_ID = a.AD_PInstance_ID);


-- *********** Fix AD_PInstance_Log *******************
select count(*) from AD_PInstance_Log a
left join AD_PInstance b on b.AD_PInstance_ID = a.AD_PInstance_ID
where a.AD_Pinstance_ID is not null
  and b.AD_PInstance_ID is null;

delete AD_PInstance_Log a
where not exists (select * from AD_PInstance b where b.AD_PInstance_ID = a.AD_PInstance_ID);


-- *********** Fix AD_SchedulerLog *******************
select distinct a.AD_Scheduler_ID from AD_SchedulerLog a
left join AD_Scheduler b on b.AD_Scheduler_ID = a.AD_Scheduler_ID
where a.AD_Scheduler_ID is not null
  and b.AD_Scheduler_ID is null;
  

Insert into AD_Schedule (AD_CLIENT_ID,AD_ORG_ID,AD_SCHEDULE_ID,CREATED,CREATEDBY,DESCRIPTION,FREQUENCY,FREQUENCYTYPE,HELP,ISACTIVE,MONTHDAY,NAME,ONFRIDAY,ONMONDAY,ONSATURDAY,ONSUNDAY,ONTHURSDAY,ONTUESDAY,ONWEDNESDAY,RUNONLYONIP,RUNONLYSPECIFIEDTIME,RUNONLYSPECIFIEDTOLMIN,SCHEDULEHOUR,SCHEDULEMINUTE,SCHEDULETYPE,UPDATED,UPDATEDBY,WEEKDAY,SCHEDULETIME) values (0,0,995000,to_date('15-DEC-15','DD-MON-RR'),0,null,1,'D',null,'Y',1,'SCWI Nightly','Y','Y','Y','Y','Y','Y','Y',null,'N',null,null,null,'F',to_date('15-DEC-15','DD-MON-RR'),0,null,to_date('01-JAN-70','DD-MON-RR'));

Insert into AD_SCHEDULER (AD_SCHEDULER_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,AD_PROCESS_ID,FREQUENCYTYPE,FREQUENCY,DATELASTRUN,DATENEXTRUN,SUPERVISOR_ID,KEEPLOGDAYS,PROCESSING,AD_SCHEDULE_ID,AD_USER_ID,AD_ROLE_ID,AD_LANGUAGE,M_WAREHOUSE_ID) values (995000,0,0,'Y',to_date('15-DEC-15','DD-MON-RR'),0,to_date('15-DEC-15','DD-MON-RR'),0,'SCWI Nightly Process',null,995037,'D',1,null,null,0,7,'N',995000,0,0,'en_US',null);


-- *********** Fix AD_PInstance_Log - AD_SchedulerLog*******************
select count(*) from AD_SchedulerLog a
left join AD_PInstance b on b.AD_PInstance_ID = a.AD_PInstance_ID
where a.AD_Pinstance_ID is not null
  and b.AD_PInstance_ID is null;

update AD_SchedulerLog a set a.AD_PInstance_ID = null
where a.AD_PInstance_ID is not null
  and not exists (select * from AD_PInstance b where b.AD_PInstance_ID = a.AD_PInstance_ID);
