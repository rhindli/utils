
select c.Name, Round(count(*)/3, 0) As RequestsNo
from CAPI_UsageLog l
join AD_Client c on l.AD_ClientInclude_ID=c.AD_Client_ID
group by c.Name
order by 2 desc;



select c.Name, ROUND(count(*)/9, 0) As NrCalls
from SWSS_WebService_Log l
JOIN AD_Client c on c.AD_Client_ID = l.AD_Client_ID
where l.created >= to_date('01.01.2016', 'DD.MM.YYYY')
group by c.Name
order by NrCalls desc;


select c.Name, count (*) As RequestsNo
from CAPI_UsageLog l
join AD_Client c on l.AD_ClientInclude_ID=c.AD_Client_ID
Where l.created > trunc(sysdate - 30, 'DD')
group by c.Name
order by 2 desc;

select c.Name, l.RoleName, l.Email, l.MethodName, count (*) As RequestsNo
from CAPI_UsageLog l
join AD_Client c on l.AD_ClientInclude_ID=c.AD_Client_ID
group by c.Name, l.RoleName, l.Email, l.MethodName
order by 1, 2, 3, 4;