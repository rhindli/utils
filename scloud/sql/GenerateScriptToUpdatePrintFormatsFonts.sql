SELECT 'CREATE TABLE AD_PrintFormat_bkfontsupd AS SELECT * FROM ad_printformat WHERE AD_PrintFormat_ID IN (' ||
string_agg(AD_PrintFormat_ID::TEXT, ',') || ');'
FROM AD_PrintFormat
WHERE AD_PrintFormat_ID IN (2140900721, 2140900814)
UNION ALL
SELECT 'CREATE TABLE AD_PrintFormatItem_bkfontsupd AS SELECT * FROM ad_printformatitem WHERE AD_PrintFormat_ID IN (' ||
string_agg(AD_PrintFormat_ID::TEXT, ',') || ');'
FROM AD_PrintFormat
WHERE AD_PrintFormat_ID IN (2140900721, 2140900814)
UNION ALL
SELECT 'CREATE TABLE AD_PrintFormatItem_trl_bkfontsupd AS SELECT * FROM ad_printformatitem_trl WHERE AD_PrintFormatItem_ID IN (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem WHERE AD_PrintFormat_ID IN (' ||
string_agg(AD_PrintFormat_ID::TEXT, ',') || '));'
FROM AD_PrintFormat
WHERE AD_PrintFormat_ID IN (2140900721, 2140900814)
UNION ALL
SELECT 'UPDATE AD_PrintFormat SET (updated, updatedby, ad_printpaper_id, ad_printcolor_id, ad_printfont_id, isstandardheaderfooter, headermargin, footermargin, ad_printtableformat_id) = (''' 
|| updated || ''', ' || updatedby || ', ' || ad_printpaper_id || ', ' || ad_printcolor_id || ', ' || ad_printfont_id || ', $$' || isstandardheaderfooter || '$$, ' || headermargin || ', ' || footermargin || ', ' || COALESCE(ad_printtableformat_id::TEXT, 'NULL') || 
') WHERE AD_PrintFormat_ID = ' || AD_PrintFormat_ID || ';' AS SQL
FROM AD_PrintFormat
WHERE AD_PrintFormat_ID IN (2140900721, 
2140900814)
UNION ALL
SELECT 'DELETE FROM AD_PrintFormatItem WHERE AD_PrintFormat_ID = ' || AD_PrintFormat_ID || ';'
FROM AD_PrintFormat
WHERE AD_PrintFormat_ID IN (1007136, 1008928, 1014410, 1046015, 1065865, 1069702, 1069703, 1069705, 1069706, 1071106, 1073463, 1093451, 1096706, 1099409, 1103220, 1112430, 1120145, 1129967, 1152558, 
1152561, 1159469, 1160071, 1160471, 1160473, 1162473, 1169382, 1174191, 1174842, 1175092, 1175093, 1175094, 1175099, 1184005, 1185302, 1185305, 1185307, 1185309, 1185311, 
1185314, 1185317, 1186554, 1205342, 1206780, 1207749, 1207754, 1208687, 1208688, 1208691, 1211823, 1220056, 1230472, 1234332, 1245658, 1245660, 1249264, 1251625, 1259625, 
1259725, 1260328, 1260329, 1262929, 1263383, 1263385, 1263494, 1264982, 1265102, 1265683, 1272658, 1275661, 1275662, 1285372, 1286174, 1286176, 1286976, 1286977, 1287976, 
1294493, 1294496, 1294728, 1297250, 1303759, 1305109, 1308616, 1308617, 1312367, 1313367, 1313718, 1313720, 1313725, 1313727, 1313729, 1315269, 1315271, 1315273, 1315277, 
1315278, 1315280, 1315282, 1315290, 1315771, 1323779, 1326731, 1327180, 1328032, 1328102, 1328103, 1329830, 1333534, 1333586, 1334334, 1334336, 1334433, 1334434, 1334435, 
1336985, 1336988, 1336989, 1336991, 1340055, 1341587, 1353640, 1357241, 1357389, 1357442, 1357456, 1359789, 1368141, 1371949, 1371950, 1371953, 1995512, 2140900721, 
2140900814, 2394833, 2494736, 2605474, 2611927, 6358837)
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
WHERE AD_PrintFormat_ID IN (1007136, 1008928, 1014410, 1046015, 1065865, 1069702, 1069703, 1069705, 1069706, 1071106, 1073463, 1093451, 1096706, 1099409, 1103220, 1112430, 1120145, 1129967, 1152558, 
1152561, 1159469, 1160071, 1160471, 1160473, 1162473, 1169382, 1174191, 1174842, 1175092, 1175093, 1175094, 1175099, 1184005, 1185302, 1185305, 1185307, 1185309, 1185311, 
1185314, 1185317, 1186554, 1205342, 1206780, 1207749, 1207754, 1208687, 1208688, 1208691, 1211823, 1220056, 1230472, 1234332, 1245658, 1245660, 1249264, 1251625, 1259625, 
1259725, 1260328, 1260329, 1262929, 1263383, 1263385, 1263494, 1264982, 1265102, 1265683, 1272658, 1275661, 1275662, 1285372, 1286174, 1286176, 1286976, 1286977, 1287976, 
1294493, 1294496, 1294728, 1297250, 1303759, 1305109, 1308616, 1308617, 1312367, 1313367, 1313718, 1313720, 1313725, 1313727, 1313729, 1315269, 1315271, 1315273, 1315277, 
1315278, 1315280, 1315282, 1315290, 1315771, 1323779, 1326731, 1327180, 1328032, 1328102, 1328103, 1329830, 1333534, 1333586, 1334334, 1334336, 1334433, 1334434, 1334435, 
1336985, 1336988, 1336989, 1336991, 1340055, 1341587, 1353640, 1357241, 1357389, 1357442, 1357456, 1359789, 1368141, 1371949, 1371950, 1371953, 1995512, 2140900721, 
2140900814, 2394833, 2494736, 2605474, 2611927, 6358837)
UNION ALL
SELECT 'INSERT INTO AD_PrintFormatItem_Trl (ad_printformatitem_id, ad_language, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, printname, istranslated, printnamesuffix) VALUES ('
 || ad_printformatitem_id ||
', $$' || ad_language ||
'$$, ' || ad_client_id ||
', ' || ad_org_id ||
', $$' || isactive ||
'$$, ''' || created ||
''', ' || createdby ||
', ''' || updated ||
''', ' || updatedby ||
', ' || CASE WHEN printname IS NULL THEN 'NULL' ELSE '$$' || printname || '$$' END ||
', $$' || istranslated ||
'$$, ' || CASE WHEN printnamesuffix IS NULL THEN 'NULL' ELSE '$$' || printnamesuffix || '$$' END || ');' 
FROM AD_PrintFormatItem_Trl
WHERE AD_PrintFormatItem_ID IN (
	SELECT AD_PrintFormatItem_ID 
	FROM AD_PrintFormatItem 
	WHERE AD_PrintFormat_ID IN (1007136, 1008928, 1014410, 1046015, 1065865, 1069702, 1069703, 1069705, 1069706, 1071106, 1073463, 1093451, 1096706, 1099409, 1103220, 1112430, 1120145, 1129967, 1152558, 
1152561, 1159469, 1160071, 1160471, 1160473, 1162473, 1169382, 1174191, 1174842, 1175092, 1175093, 1175094, 1175099, 1184005, 1185302, 1185305, 1185307, 1185309, 1185311, 
1185314, 1185317, 1186554, 1205342, 1206780, 1207749, 1207754, 1208687, 1208688, 1208691, 1211823, 1220056, 1230472, 1234332, 1245658, 1245660, 1249264, 1251625, 1259625, 
1259725, 1260328, 1260329, 1262929, 1263383, 1263385, 1263494, 1264982, 1265102, 1265683, 1272658, 1275661, 1275662, 1285372, 1286174, 1286176, 1286976, 1286977, 1287976, 
1294493, 1294496, 1294728, 1297250, 1303759, 1305109, 1308616, 1308617, 1312367, 1313367, 1313718, 1313720, 1313725, 1313727, 1313729, 1315269, 1315271, 1315273, 1315277, 
1315278, 1315280, 1315282, 1315290, 1315771, 1323779, 1326731, 1327180, 1328032, 1328102, 1328103, 1329830, 1333534, 1333586, 1334334, 1334336, 1334433, 1334434, 1334435, 
1336985, 1336988, 1336989, 1336991, 1340055, 1341587, 1353640, 1357241, 1357389, 1357442, 1357456, 1359789, 1368141, 1371949, 1371950, 1371953, 1995512, 2140900721, 
2140900814, 2394833, 2494736, 2605474, 2611927, 6358837)
);
