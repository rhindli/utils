select c.Name, count(*) 
from C_Order d
join AD_Client c on c.AD_Client_ID = d.AD_client_ID
where d.Created >= to_date('01-10-2015', 'DD-MM-YYYY')
group by c.Name
order by 2 desc;



