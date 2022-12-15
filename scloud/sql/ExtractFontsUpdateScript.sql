/*
 * Before running the extraction script for fonts update
 * replace all occurrences of string ###
 * with the csv of print format ids to extract.
 * 
 * The resulting update script will create a backup of the print formats
 * that will be updated in tables:
 *   - AD_PrintFormat_bkfontupd_YYYY_MM_DD__HH24_MI_SS
 *   - AD_PrintFormatItem_bkfontupd_YYYY_MM_DD__HH24_MI_SS
 *   - AD_PrintFormatItem_trl_bkfontupd_YYYY_MM_DD__HH24_MI_SS
 * 
 * These tables will remain in DB after the update.
 * You will have to drop them manually later.
 */
SELECT 'DO $fontupd$' AS Script
UNION ALL
SELECT 'DECLARE'
UNION ALL
SELECT 'p_printformat_ids bigint[] := ARRAY[' ||
 string_agg(AD_PrintFormat_ID::TEXT, ',') || '];'
FROM AD_PrintFormat
WHERE AD_PrintFormat_ID IN (###)
UNION ALL
SELECT 'BEGIN'
UNION ALL
SELECT ''
UNION ALL
SELECT '--backup printformats'
UNION ALL
SELECT 'CREATE TABLE AD_PrintFormat_bkfontupd_' || to_char(transaction_timestamp(), 'YYYY_MM_DD__HH24_MI_SS') || ' AS SELECT * FROM ad_printformat WHERE AD_PrintFormat_ID = ANY(p_printformat_ids);'
UNION ALL
SELECT 'CREATE TABLE AD_PrintFormatItem_bkfontupd_' || to_char(transaction_timestamp(), 'YYYY_MM_DD__HH24_MI_SS') || ' AS SELECT * FROM ad_printformatitem WHERE AD_PrintFormat_ID = ANY(p_printformat_ids);'
UNION ALL
SELECT 'CREATE TABLE AD_PrintFormatItem_trl_bkfontupd_' || to_char(transaction_timestamp(), 'YYYY_MM_DD__HH24_MI_SS') || ' AS SELECT * FROM ad_printformatitem_trl WHERE AD_PrintFormatItem_ID IN (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem WHERE AD_PrintFormat_ID = ANY(p_printformat_ids));'
UNION ALL
SELECT ''
UNION ALL
SELECT '--Update print format header'
UNION ALL
SELECT 'UPDATE AD_PrintFormat SET (updated, updatedby, ad_printpaper_id, ad_printcolor_id, ad_printfont_id, isstandardheaderfooter, headermargin, footermargin, ad_printtableformat_id) = (''' 
|| updated || ''', ' || updatedby || ', ' || ad_printpaper_id || ', ' || ad_printcolor_id || ', ' || ad_printfont_id || ', $$' || isstandardheaderfooter || '$$, ' || headermargin || ', ' || footermargin || ', ' || COALESCE(ad_printtableformat_id::TEXT, 'NULL') || 
') WHERE AD_PrintFormat_ID = ' || AD_PrintFormat_ID || ';'
FROM AD_PrintFormat
WHERE AD_PrintFormat_ID IN (###)
UNION ALL
SELECT ''
UNION ALL
SELECT '--Delete old print format items'
UNION ALL
SELECT 'DELETE FROM AD_PrintFormatItem WHERE AD_PrintFormat_ID = ANY(p_printformat_ids);'
UNION ALL
SELECT ''
UNION ALL
SELECT '--Insert updated print format items'
UNION ALL
SELECT 'INSERT INTO AD_PrintFormatItem (ad_printformatitem_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_printformat_id, name, printname, isprinted, printareatype, seqno, printformattype, ad_column_id, ad_printformatchild_id, isrelativeposition, isnextline, xspace, yspace, xposition, yposition, maxwidth, isheightoneline, maxheight, fieldalignmenttype, linealignmenttype, ad_printcolor_id, ad_printfont_id, isorderby, sortno, isgroupby, ispagebreak, issummarized, imageisattached, imageurl, isaveraged, iscounted, issetnlposition, issuppressnull, belowcolumn, ad_printgraph_id, isfixedwidth, isnextpage, printnamesuffix, ismincalc, ismaxcalc, isrunningtotal, runningtotallines, isvariancecalc, isdeviationcalc, isfilledrectangle, linewidth, arcdiameter, shapetype, iscentrallymaintained, isimagefield, barcodetype, ad_fieldgroup_id, isascending, warninglogic, warning_printcolor_id, warning_bgprintcolor_id, warning_printfont_id, iswarningline, priceprecision, imageissourceattached, attachmenttable_id, isvirtualfield, ad_targetcolumn_id) VALUES ('
 || ad_printformatitem_id ||
', ' || ad_client_id ||
', ' || ad_org_id ||
', $$' || isactive ||
'$$, ''' || created ||
''', ' || createdby ||
', ''' || updated ||
''', ' || updatedby ||
', ' || ad_printformat_id ||
', $$' || name ||
'$$, ' || CASE WHEN printname IS NULL THEN 'NULL' ELSE '$$' || printname || '$$' END ||
', $$' || isprinted ||
'$$, $$' || printareatype ||
'$$, ' || seqno ||
', $$' || printformattype ||
'$$, ' || COALESCE(ad_column_id::TEXT, 'NULL') ||
', ' || COALESCE(ad_printformatchild_id::TEXT, 'NULL') ||
', $$' || isrelativeposition ||
'$$, $$' || isnextline ||
'$$, ' || xspace ||
', ' || yspace ||
', ' || xposition ||
', ' || yposition ||
', ' || maxwidth ||
', $$' || isheightoneline ||
'$$, ' || maxheight ||
', $$' || fieldalignmenttype ||
'$$, $$' || linealignmenttype ||
'$$, ' || COALESCE(ad_printcolor_id::TEXT, 'NULL') ||
', ' || COALESCE(ad_printfont_id::TEXT, 'NULL') ||
', $$' || isorderby ||
'$$, ' || sortno ||
', $$' || isgroupby ||
'$$, $$' || ispagebreak ||
'$$, $$' || issummarized ||
'$$, $$' || imageisattached ||
'$$, ' || CASE WHEN imageurl IS NULL THEN 'NULL' ELSE '$$' || imageurl || '$$' END ||
', $$' || isaveraged ||
'$$, $$' || iscounted ||
'$$, $$' || issetnlposition ||
'$$, $$' || issuppressnull ||
'$$, ' || COALESCE(belowcolumn::TEXT, 'NULL') ||
', ' || COALESCE(ad_printgraph_id::TEXT, 'NULL') ||
', $$' || isfixedwidth ||
'$$, $$' || isnextpage ||
'$$, ' || CASE WHEN printnamesuffix IS NULL THEN 'NULL' ELSE '$$' || printnamesuffix || '$$' END ||
', $$' || ismincalc ||
'$$, $$' || ismaxcalc ||
'$$, $$' || isrunningtotal ||
'$$, ' || COALESCE(runningtotallines::TEXT, 'NULL') ||
', $$' || isvariancecalc ||
'$$, $$' || isdeviationcalc ||
'$$, $$' || isfilledrectangle ||
'$$, ' || COALESCE(linewidth::TEXT, 'NULL') ||
', ' || COALESCE(arcdiameter::TEXT, 'NULL') ||
', ' || CASE WHEN shapetype IS NULL THEN 'NULL' ELSE '$$' || shapetype || '$$' END ||
', $$' || iscentrallymaintained ||
'$$, $$' || isimagefield ||
'$$, ' || CASE WHEN barcodetype IS NULL THEN 'NULL' ELSE '$$' || barcodetype || '$$' END ||
', ' || COALESCE(ad_fieldgroup_id::TEXT, 'NULL') ||
', $$' || isascending ||
'$$, ' || CASE WHEN warninglogic IS NULL THEN 'NULL' ELSE '$$' || warninglogic || '$$' END ||
', ' || COALESCE(warning_printcolor_id::TEXT, 'NULL') ||
', ' || COALESCE(warning_bgprintcolor_id::TEXT, 'NULL') ||
', ' || COALESCE(warning_printfont_id::TEXT, 'NULL') ||
', ' || CASE WHEN iswarningline IS NULL THEN 'NULL' ELSE '$$' || iswarningline || '$$' END ||
', ' || COALESCE(priceprecision::TEXT, 'NULL') ||
', ' || CASE WHEN imageissourceattached IS NULL THEN 'NULL' ELSE '$$' || imageissourceattached || '$$' END ||
', ' || COALESCE(attachmenttable_id::TEXT, 'NULL') ||
', $$' || isvirtualfield ||
'$$, ' || COALESCE(ad_targetcolumn_id::TEXT, 'NULL') || ');' 
FROM AD_PrintFormatItem
WHERE AD_PrintFormat_ID IN (###)
UNION ALL
SELECT ''
UNION ALL
SELECT '--Insert print format items translations (from backup)'
UNION ALL
SELECT 'INSERT INTO AD_PrintFormatItem_Trl (ad_printformatitem_id, ad_language, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, printname, istranslated, printnamesuffix)'
UNION ALL
SELECT 'SELECT ad_printformatitem_id, ad_language, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, printname, istranslated, printnamesuffix'
UNION ALL
SELECT 'FROM AD_PrintFormatItem_trl_bkfontupd_' || to_char(transaction_timestamp(), 'YYYY_MM_DD__HH24_MI_SS')
UNION ALL
SELECT 'WHERE EXISTS(SELECT * FROM AD_PrintFormatItem pfi where AD_PrintFormatItem_trl_bkfontupd_' || to_char(transaction_timestamp(), 'YYYY_MM_DD__HH24_MI_SS') || '.AD_PrintFormatItem_ID = pfi.AD_PrintFormatItem_ID);'
UNION ALL
SELECT ''
UNION ALL
SELECT '--Insert print format items translations for new items (if any)'
UNION ALL
SELECT 'INSERT INTO AD_PrintFormatItem_Trl (ad_printformatitem_id, ad_language, ad_client_id, ad_org_id, created, createdby, updated, updatedby, printname, istranslated, printnamesuffix)'
UNION ALL
SELECT 'SELECT t.ad_printformatitem_id, l.ad_language, t.ad_client_id, t.ad_org_id, t.created, t.createdby, t.updated, t.updatedby, t.printname, $$N$$, t.printnamesuffix'
UNION ALL
SELECT 'FROM AD_Language l, AD_PrintFormatItem t'
UNION ALL
SELECT 'WHERE l.IsActive=''Y'' AND l.IsSystemLanguage=''Y'' AND l.IsBaseLanguage=''N'''
UNION ALL
SELECT '  AND t.AD_PrintFormatItem_ID IN(SELECT AD_PrintFormatItem_ID FROM AD_PrintFormat WHERE AD_PrintFormat_ID = ANY(p_printformat_ids))'
UNION ALL
SELECT '  AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID);'
UNION ALL
SELECT ''
UNION ALL
SELECT 'END $fontupd$;'
;
