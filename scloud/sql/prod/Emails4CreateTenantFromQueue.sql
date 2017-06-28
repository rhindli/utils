--Emails sent to emails that have registered for a tenant
select u.Email, m.* from SEMS_MESSAGE m
join sems_message_to mt on mt.SEMS_Message_ID=m.SEMS_Message_ID
join AD_User u on u.AD_User_ID = mt.AD_User_ID
where u.Email IN (select q.Email from
AD_ClientQueue q
where
q.Tenant_ID is not null
and trunc(q.Created, 'DD') >= to_date('08-10-2016', 'DD-MM-YYYY')
)
union all
select mt.Email, m.* from SEMS_MESSAGE m
join SEMS_Message_To_NoUser mt on mt.SEMS_Message_ID=m.SEMS_Message_ID
where mt.Email IN (select q.Email from
AD_ClientQueue q
where
q.Tenant_ID is not null
and trunc(q.Created, 'DD') >= to_date('08-10-2016', 'DD-MM-YYYY')
)
order by Email;

-- Domains that have registered for a tenant and have tenant created but no login
select distinct q.Domain from
AD_ClientQueue q
left join AD_Session s on s.AD_Client_ID=q.Tenant_ID
where
q.Tenant_ID is not null
and s.AD_Client_ID is null
and trunc(q.Created, 'DD') >= to_date('07-02-2016', 'DD-MM-YYYY');

select s.Created, s.Updated, u.* from AD_Session s
join AD_User u on u.AD_User_ID = s.CreatedBy
where s.AD_Client_ID=1004012;

--Email sent to a specified Email address
select m.* from SEMS_MESSAGE m
join sems_message_to mt on mt.SEMS_Message_ID=m.SEMS_Message_ID
join AD_User u on u.AD_User_ID = mt.AD_User_ID
where u.Email = '<email>'
union all
select m.* from SEMS_MESSAGE m
join SEMS_Message_To_NoUser mt on mt.SEMS_Message_ID=m.SEMS_Message_ID
where mt.Email = '<email>'
;


select * from AD_Session where AD_Client_ID IN (1004313, 1004312, 1004311, 1004315, 1004314, 1004317, 1004316);