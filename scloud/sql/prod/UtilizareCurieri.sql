/*
Utilizare curieri intr-un an de zile.
Numar AWB-uri per titular/serviciu curieri.
*/

WITH cte AS (
--AWB count from shipments
SELECT io.ad_client_id, api.courierservice, array_length(string_to_array(io.trackingno, ','), 1) AS awbcnt
FROM M_InOut io 
JOIN srpd_apiprops api ON api.m_shipper_id = io.m_shipper_id
WHERE io.trackingno IS NOT NULL
	AND io.movementdate >= (statement_timestamp() - INTERVAL '1 year')
UNION ALL
--AWB count from requests
SELECT r.ad_client_id, 'FCX', array_length(string_to_array(r.trackingno, ','), 1)
FROM r_request r 
WHERE r.trackingno IS NOT NULL
	AND r.created >= (statement_timestamp() - INTERVAL '1 year')
UNION ALL
--Deleted AWB count from shipments
SELECT pi.ad_client_id, api.courierservice, array_length(string_to_array(pia.p_string, ','), 1)
FROM AD_PInstance pi 
JOIN m_inout io ON io.M_Inout_ID = pi.Record_ID
JOIN srpd_apiprops api ON api.m_shipper_id = io.m_shipper_id
JOIN ad_pinstance_para pia ON pia.ad_pinstance_id = pi.ad_pinstance_id
WHERE pi.ad_process_id IN (2140901080,2140901162,2140900672,2140901096,2140900850,2140900871,900088,2140900959)
	AND pi.created >= (statement_timestamp() - INTERVAL '1 year')
	AND pia.parametername = 'AWB'
UNION ALL
--Deleted AWB count from warehouseboxes
SELECT pi.ad_client_id, x.courierservice, array_length(string_to_array(pia.p_string, ','), 1)
FROM AD_PInstance pi 
JOIN ad_pinstance_para pia ON pia.ad_pinstance_id = pi.ad_pinstance_id
JOIN LATERAL ( SELECT api.courierservice 
FROM ad_pinstance_para pia1
JOIN sror_warehousebox box ON box.SROR_WarehouseBox_ID = pia1.p_number
JOIN c_order o ON o.c_order_id = box.c_order_id
JOIN srpd_apiprops api ON api.m_shipper_id = o.m_shipper_id
WHERE pia1.ad_pinstance_id = pi.ad_pinstance_id
	AND pia1.parametername in ('SROR_Warehouse_ID', 'SRPD_Warehouse_ID')
) x ON true
WHERE pi.ad_process_id IN (2140900879, 2140900527)
	AND pi.created >= (statement_timestamp() - INTERVAL '1 year')
	AND pia.parametername = 'AWB'
	)
SELECT c.ad_client_id, c."name", (SELECT r.Name FROM AD_Ref_List r WHERE r.AD_Reference_ID = 2140900209 AND Value = courierservice),  sum(awbcnt)
FROM cte
JOIN ad_client c ON c.ad_client_id =cte.ad_client_id
GROUP BY c.ad_client_id, c.name, courierservice
ORDER BY c.ad_client_id, sum(awbcnt) desc;