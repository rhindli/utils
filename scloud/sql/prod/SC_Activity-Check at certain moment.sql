/* Activities count started in interval */
select to_char(created, 'DD-MM-YYYY HH24:MI:SS'), count(*) 
from SC_Activity 
where Created >= to_date('28-03-2017 05:59:00', 'DD-MM-YYYY HH24:MI:SS') 
  and Created < to_date('28-03-2017 06:00:00', 'DD-MM-YYYY HH24:MI:SS')
group by to_char(created, 'DD-MM-YYYY HH24:MI:SS')
--having count(*) > 20
order by to_char(created, 'DD-MM-YYYY HH24:MI:SS');

/* Activities count per Client, WebModule started in interval */
select ClientName, WebModule, count(*) 
from SC_Activity 
where Created >= to_date('18-08-2016 04:35:00', 'DD-MM-YYYY HH24:MI:SS') 
  and Created < to_date('18-08-2016 04:35:01', 'DD-MM-YYYY HH24:MI:SS')
group by ClientName, WebModule;

/* Activities started in interval */
select *
from SC_Activity 
where Created >= to_date('28-03-2017 05:45:00', 'DD-MM-YYYY HH24:MI:SS') 
  and Created < to_date('28-03-2017 06:00:00', 'DD-MM-YYYY HH24:MI:SS')
order by ElapsedTimeMM desc;

/* Activities running at certain moment */
select *
from SC_Activity 
where Created <= to_date('30-10-2019 09:00:00', 'DD-MM-YYYY HH24:MI:SS') 
  and Updated >=  to_date('30-10-2019 09:00:00', 'DD-MM-YYYY HH24:MI:SS')
union all
select *
from SC_Activity 
where Created <= to_date('30-10-2019 09:00:00', 'DD-MM-YYYY HH24:MI:SS') 
  and Created = Updated
  and IsClosed='N'
;


/* Nr. of activities running when another activity is running */
select 
(select count(*)
from SC_Activity b 
where b.Created <= x.Created 
  and b.Updated >=  x.Created) +
(select count(*)
from SC_Activity b 
where b.Created <= x.Created
  and b.Created = Updated
  and b.IsClosed='N'
) As Cnt,
x.Created
FROM
(SELECT DISTINCT a.Created
from SC_Activity a
where a.created >= to_date('26-03-2017 20:18', 'DD-MM-YYYY HH24:MI')
  and a.created < to_date('26-03-2017 20:19', 'DD-MM-YYYY HH24:MI')) x
order by 1 desc;

select ElapsedTimeMM, count(*)
from SC_Activity 
where WebModule='CloudAPI'
group by ElapsedTimeMM
order by ElapsedTimeMM desc;
