--Last connection date
select c.AD_Client_ID as IDTitular, c.Value As CodTitular, c.Name As DenumireTitular, TRUNC(max(s.LastActivityTime), 'DD') AS LastActivityDate
from AD_Session s
join AD_Client c on c.AD_Client_ID=s.AD_Client_ID
group by c.AD_Client_ID, c.Value, c.Name
order by LastActivityDate, CodTitular
;

select * from AD_Session s
where AD_Client_ID = 1005817
order by Created desc;