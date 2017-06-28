select c.Name as Tenant, TRUNC(o.DateOrdered, 'Month'), COUNT(*) AS cnt 
from C_Order o
join AD_Client c on c.AD_Client_ID=o.AD_Client_ID
where o.IsSoTrx='Y'
  and o.DateOrdered < to_date('01-06-2016', 'DD-MM-YYYY')
  and o.DateOrdered >= to_date('01-01-2016', 'DD-MM-YYYY')
group by c.Name, TRUNC(o.DateOrdered, 'Month')
order by c.Name, TRUNC(o.DateOrdered, 'Month');

select Tenant, ROUND(sum(cnt)/5, 0) as Avg, MAX(cnt) as Max, Min(cnt) as Min
from (
  select c.Name as Tenant
    , TRUNC(o.DateOrdered, 'Month') as Month
    , COUNT(*) AS cnt
  from C_Order o
  join AD_Client c on c.AD_Client_ID=o.AD_Client_ID
  where o.IsSoTrx='Y'
    and o.DateOrdered < to_date('01-06-2016', 'DD-MM-YYYY')
    and o.DateOrdered >= to_date('01-01-2016', 'DD-MM-YYYY')
  group by c.Name, TRUNC(o.DateOrdered, 'Month')
) x
group by Tenant
order by avg desc;

  