SELECT FIRST_VALUE(ad.A_Asset_Addition_ID) OVER (PARTITION BY ad.A_Asset_ID, ad.PostingType ORDER BY TRUNC(ad.DateAcct, 'DD')) a
, ad.A_Asset_Addition_ID
, ad.A_Asset_ID
, ad.PostingType
FROM
A_Asset_Addition ad
where ad.A_Asset_ID=1000016;


SELECT a.AD_Client_ID, a.A_Asset_ID, a.Value, a1.A_Asset_Addition_ID, a1.DateAcct
FROM A_Asset_Addition a1
JOIN A_Asset a on a1.A_Asset_ID = a.A_Asset_ID
WHERE A_Asset_Addition_ID IN (SELECT FIRST_VALUE(ad.A_Asset_Addition_ID) OVER (PARTITION BY ad.A_Asset_ID ORDER BY TRUNC(ad.DateAcct, 'DD') Desc)
FROM A_Asset_Addition ad
JOIN A_AssetRevaluation ar ON ad.A_AssetRevaluation_ID = ar.A_AssetRevaluation_ID
JOIN A_AssetRevaluationLine arl ON ar.A_AssetRevaluation_ID = arl.A_AssetRevaluation_ID AND ad.A_Asset_ID = arl.A_Asset_ID);


