alter session set current_schema=scloud;

select e1.entitytype as ent_in_plus, e1.name, 'scloud' as db_schema
from ad_entitytype e1
      left outer join scsoref.ad_entitytype e2 on (e1.entitytype=e2.entitytype)
where e2.entitytype is null
union
select e1.entitytype as ent_in_plus, e1.name, 'soref' as db_schema
from scsoref.ad_entitytype e1
      left outer join ad_entitytype e2 on (e1.entitytype=e2.entitytype)
where e2.entitytype is null
order by 2, 1;

