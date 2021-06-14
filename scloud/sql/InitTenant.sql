Insert into AD_CLIENTQUEUE (AD_CLIENTQUEUE_ID,AD_CLIENT_ID,AD_ORG_ID,CREATED,CREATEDBY,ISACTIVE,UPDATED,UPDATEDBY,EMAIL,DESCRIPTION,USERNAME,COMPANY,CITY,TAXID,DUNS,URL,TENANT_ID,ADDRESS,C_COUNTRY_ID,PARTNER,C_BPARTNER_ID,ACTIVATIONCODE,PROCESSING,PROCESSED,C_CITY_ID,C_REGION_ID,REGION,PROCESSINGSO,GENPASSWORD,DOMAIN,COMPONENTTYPE,PHONE,SALESREPEMAIL,SUBSCRIPTIONTYPENAME,USERSNO,SENDEMAIL) values 
(1001215,0,0,statement_timestamp()::timestamp,0,'Y',statement_timestamp()::timestamp,0,'a@a',null,'Robert Hindli','Dev','Brasov','RO12345','J08/12/2005',null,null,'Hermann Oberth nr. 8',285,null,null,'uo0n22khgbl90mma3t8td0q9ek','N','N',2140900009,2140900008,'Brasov','N','aa','dev.ro','SFRO','1234',null,'SoHo','2','N');

Insert into AD_CLIENTQUEUE (AD_CLIENTQUEUE_ID,AD_CLIENT_ID,AD_ORG_ID,CREATED,CREATEDBY,ISACTIVE,UPDATED,UPDATEDBY,EMAIL,DESCRIPTION,USERNAME,COMPANY,CITY,TAXID,DUNS,URL,TENANT_ID,ADDRESS,C_COUNTRY_ID,PARTNER,C_BPARTNER_ID,ACTIVATIONCODE,PROCESSING,PROCESSED,C_CITY_ID,C_REGION_ID,REGION,PROCESSINGSO,GENPASSWORD,DOMAIN,COMPONENTTYPE,PHONE,SALESREPEMAIL,SUBSCRIPTIONTYPENAME,USERSNO,SENDEMAIL) values 
(1001216,0,0,statement_timestamp()::timestamp,0,'Y',statement_timestamp()::timestamp,0,'a@a',null,'Robert Hindli','Dev1','Brasov','RO12345','J08/12/2005',null,null,'Hermann Oberth nr. 8',285,null,null,'uo0n22khgbl90mma3t8td0q9ek1','N','N',2140900009,2140900008,'Brasov','N','aa','dev1.ro','SFRO','1234',null,'SoHo','2','N');

Insert into AD_CLIENTQUEUE (AD_CLIENTQUEUE_ID,AD_CLIENT_ID,AD_ORG_ID,CREATED,CREATEDBY,ISACTIVE,UPDATED,UPDATEDBY,EMAIL,DESCRIPTION,USERNAME,COMPANY,CITY,TAXID,DUNS,URL,TENANT_ID,ADDRESS,C_COUNTRY_ID,PARTNER,C_BPARTNER_ID,ACTIVATIONCODE,PROCESSING,PROCESSED,C_CITY_ID,C_REGION_ID,REGION,PROCESSINGSO,GENPASSWORD,DOMAIN,COMPONENTTYPE,PHONE,SALESREPEMAIL,SUBSCRIPTIONTYPENAME,USERSNO,SENDEMAIL) values 
(1001217,0,0,statement_timestamp()::timestamp,0,'Y',statement_timestamp()::timestamp,0,'a@a',null,'Robert Hindli','Dev2','Brasov','RO12345','J08/12/2005',null,null,'Hermann Oberth nr. 8',285,null,null,'uo0n22khgbl90mma3t8td0q9ek2','N','N',2140900009,2140900008,'Brasov','N','aa','dev2.ro','SFRO','1234',null,'SoHo','2','N');

Insert into AD_CLIENTQUEUE (AD_CLIENTQUEUE_ID,AD_CLIENT_ID,AD_ORG_ID,CREATED,CREATEDBY,ISACTIVE,UPDATED,UPDATEDBY,EMAIL,DESCRIPTION,USERNAME,COMPANY,CITY,TAXID,DUNS,URL,TENANT_ID,ADDRESS,C_COUNTRY_ID,PARTNER,C_BPARTNER_ID,ACTIVATIONCODE,PROCESSING,PROCESSED,C_CITY_ID,C_REGION_ID,REGION,PROCESSINGSO,GENPASSWORD,DOMAIN,COMPONENTTYPE,PHONE,SALESREPEMAIL,SUBSCRIPTIONTYPENAME,USERSNO,SENDEMAIL) values 
(1001218,0,0,statement_timestamp()::timestamp,0,'Y',statement_timestamp()::timestamp,0,'a@a',null,'Robert Hindli','Dev3','Brasov','RO12345','J08/12/2005',null,null,'Hermann Oberth nr. 8',285,null,null,'uo0n22khgbl90mma3t8td0q9ek3','N','N',2140900009,2140900008,'Brasov','N','aa','dev3.ro','SFRO','1234',null,'SoHo','2','N');

Insert into AD_CLIENTQUEUE (AD_CLIENTQUEUE_ID,AD_CLIENT_ID,AD_ORG_ID,CREATED,CREATEDBY,ISACTIVE,UPDATED,UPDATEDBY,EMAIL,DESCRIPTION,USERNAME,COMPANY,CITY,TAXID,DUNS,URL,TENANT_ID,ADDRESS,C_COUNTRY_ID,PARTNER,C_BPARTNER_ID,ACTIVATIONCODE,PROCESSING,PROCESSED,C_CITY_ID,C_REGION_ID,REGION,PROCESSINGSO,GENPASSWORD,DOMAIN,COMPONENTTYPE,PHONE,SALESREPEMAIL,SUBSCRIPTIONTYPENAME,USERSNO,SENDEMAIL) values 
(1001219,0,0,statement_timestamp()::timestamp,0,'Y',statement_timestamp()::timestamp,0,'a@a',null,'Robert Hindli','Dev4','Brasov','RO12345','J08/12/2005',null,null,'Hermann Oberth nr. 8',285,null,null,'uo0n22khgbl90mma3t8td0q9ek4','N','N',2140900009,2140900008,'Brasov','N','aa','dev4.ro','SFRO','1234',null,'SoHo','2','N');

/**
1. Define WebModules: WebUI and WebAPI in SC; Reset cache

2. Create tenant by calling:

http://robert-pc:8090/webapi/rest/public/provisioning/create_tenant/confirmation/uo0n22khgbl90mma3t8td0q9ek

http://robert-pc:8090/webapi/rest/public/provisioning/create_tenant/confirmation/uo0n22khgbl90mma3t8td0q9ek1


*/


select MAX(SC_TMPL_USAGE_id) from SC_TMPL_USAGE where AD_Client_ID=1000465;

select * from SC_TMPL_USAGE where AD_Client_ID=1000465 ORDER BY CREATED;

select * from sc_tmpl_usage where SC_TMPL_USAGE_id= 1000465;
DELETE sc_tmpl_usage where SC_TMPL_USAGE_id=1001361;

select max(AD_Sequence_ID) from AD_Sequence where AD_Sequence_ID < 2140000000;

select * from AD_Sequence where AD_Sequence_ID < 2140000000 order by AD_Sequence_ID desc;

select * from AD_Sequence where name='AD_Sequence';

select * from SC_ActivityLog where SC_Activity_ID = (select max(SC_Activity_ID) from SC_ACTIVITY where Name = 'Setup Tenant - dev.ro')
order by Created;
