select
  r_request.documentno,
  (SELECT MIN(created) 
  from R_RequestUpdate 
  where R_RequestUpdate.r_request_id = r_request.r_request_id 
      and R_RequestUpdate.r_group_id = 1000012) as in_cab,
  (SELECT MIN(created) 
  from R_RequestUpdate 
  where R_RequestUpdate.r_request_id = r_request.r_request_id 
      and R_RequestUpdate.created >
                              (SELECT MIN(created) 
                              from R_RequestUpdate 
                              where R_RequestUpdate.r_request_id = r_request.r_request_id 
                                  and R_RequestUpdate.r_group_id = 1000012) ) as next_cab,
  TRUNC((SELECT MIN(created) 
  from R_RequestUpdate 
  where R_RequestUpdate.r_request_id = r_request.r_request_id 
      and R_RequestUpdate.created >
                              (SELECT MIN(created) 
                              from R_RequestUpdate 
                              where R_RequestUpdate.r_request_id = r_request.r_request_id 
                                  and R_RequestUpdate.r_group_id = 1000012) ) 
  
  -
  (SELECT MIN(created) 
  from R_RequestUpdate 
  where R_RequestUpdate.r_request_id = r_request.r_request_id 
      and R_RequestUpdate.r_group_id = 1000012)) as delay
                                  
from r_request
WHERE R_REQUEST.R_REQUESTTYPE_ID = 1000003 --RFC
--      AND R_REQUEST.ISSELFSERVICE = 'Y'
      AND exists(SELECT * 
                  from R_RequestUpdate 
                  where R_RequestUpdate.r_request_id = r_request.r_request_id 
                          AND R_REQUESTUPDATE.R_GROUP_ID = 1000012)
      and r_request.created between to_date('01-03-2016', 'DD-MM-YYYY') AND to_date('31-03-2016', 'DD-MM-YYYY')
ORDER BY 4 DESC