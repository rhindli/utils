SELECT pd.DownloadURL,
REPLACE(REPLACE(pd.DownloadURL, '16.02', '16.03'), '16_02', '16_03') as NewDownloadURL,
pd.Name,
REPLACE(REPLACE(pd.Name, '16.02', '16.03'), '16_02', '16_03') as NewName,
pd.Created,
pd.Updated
FROM M_ProductDownload pd 
INNER JOIN M_Product p ON (pd.M_Product_ID=p.M_Product_ID) 
INNER JOIN M_Product_Category pc ON (p.M_Product_Category_ID=pc.M_Product_Category_ID) 
WHERE pd.AD_Client_ID= 1000001
  AND (pc.Value='Extensii SocrateOpen' OR p.Value LIKE 'SOPEN-MNT%' OR p.Value LIKE 'SocrateBI%' OR p.Value LIKE 'MSTR%')
  AND (pd.Name LIKE '%16.02%' OR pd.Name LIKE '%16!_02%' ESCAPE '!') 
  AND (pd.DownloadURL LIKE '%16.02%' OR pd.DownloadURL LIKE '%16!_02%' ESCAPE '!')
  AND pd.Name NOT LIKE 'SocrateCloud 16.02 Professional%'
	AND pd.Name NOT LIKE 'SocrateCloud 16.02 Standard%' 
order by Updated desc
;
  
/* Updated=136 rows */ 
  
UPDATE M_ProductDownload pd SET 
pd.Name = REPLACE(REPLACE(pd.Name, '16.02', '16.03'), '16_02', '16_03'),
pd.DownloadUrl = REPLACE(REPLACE(pd.DownloadUrl, '16.02', '16.03'), '16_02', '16_03')
where exists(select *
FROM M_Product p  
INNER JOIN M_Product_Category pc ON (p.M_Product_Category_ID=pc.M_Product_Category_ID) 
WHERE pd.M_Product_ID=p.M_Product_ID
  AND (pc.Value='Extensii SocrateOpen' OR p.Value LIKE 'SOPEN-MNT%' OR p.Value LIKE 'SocrateBI%' OR p.Value LIKE 'MSTR%')
  AND (pd.Name LIKE '%16.02%' OR pd.Name LIKE '%16!_02%' ESCAPE '!') 
  AND (pd.DownloadURL LIKE '%16.02%' OR pd.DownloadURL LIKE '%16!_02%' ESCAPE '!')
  AND pd.Name NOT LIKE 'SocrateCloud 16.02 Professional%'
	AND pd.Name NOT LIKE 'SocrateCloud 16.02 Standard%')
  and pd.AD_Client_ID= 1000002;