/*
SELECT --'SELECT ' || f.AD_Field_ID || ', ' || col.ColumnName || ' FROM ' || b.TableName || ' WHERE AD_Client_ID = ' || c.AD_Client_ID || ' AND ' || col.ColumnName || ' is not null;'
  c.AD_Client_ID
  , c.Name as Tenant
  , w.AD_Window_ID
  , w.Name as WindowName
  , w.IsActive as WindowActive
  , a.AD_Tab_ID
  , a.Name as TabName
  , a.IsActive as TabActive
  , b.TableName
  , f.AD_Field_ID
  , f.Name as FieldName
  , CASE WHEN w.IsActive = 'N' THEN 'N' 
    WHEN a.IsActive = 'N' THEN 'N'
    WHEN f.IsActive = 'N' THEN 'N'
    WHEN f.IsDisplayed = 'N' THEN 'N'
    ELSE 'Y'
    END AS Displayed
  , f.IsActive AS FieldActive
  , col.ColumnName
  , col.EntityType
 FROM AD_Tab a
join AD_Table b on b.AD_Table_ID = a.AD_Table_ID
join AD_Client c on c.AD_Client_ID=a.AD_Client_ID
join AD_Window w on w.AD_Window_ID = a.AD_Window_ID
join AD_Field f on f.AD_Tab_ID = a.AD_Tab_ID
join AD_Column col on col.AD_Column_ID = f.AD_Column_ID
where f.EntityType='U' 
  and col.EntityType not in (select EntityType 
                          from AD_EntityType 
                          where isrequiretenantlink = 'N'
                          UNION
                          select entitytype
                          from ad_clientcomponent
                          where ad_clientcomponent.ad_clientinclude_id = a.AD_Client_ID
                          UNION
                          select 'SHRM'
                          from dual
                          UNION
                          select 'SFLT'
                          from dual
        )
order by a.AD_Client_ID, a.ad_Window_ID, a.AD_Tab_ID, f.AD_Field_ID;
*/



--SELECT 1009064, ProcessingSo FROM C_Project WHERE AD_Client_ID = 1000001 AND ProcessingSo is not null;
--SELECT 1009078, M_Product_Subcategory_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000001 AND M_Product_Subcategory_ID is not null;
--SELECT 1009081, SRPD_DiscountLevel_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000001 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1009082, IsApplyQtyLevels FROM C_ProjectLine WHERE AD_Client_ID = 1000001 AND IsApplyQtyLevels <> 'N';

--SELECT 1007019, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000189 AND C_IndustrySubcode_ID is not null;

--SELECT 1012525, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000243 AND C_IndustrySubcode_ID is not null;
--SELECT 1012715, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000243 AND C_IndustrySubcode_ID is not null;
--SELECT 1016503, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000243 AND AttributeName1 is not null;
--SELECT 1016505, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000243 AND AttributeName2 is not null;
--SELECT 1022832, IsMultiLevelMarketing FROM C_BPartner WHERE AD_Client_ID = 1000243 AND IsMultiLevelMarketing is not null;
--SELECT 1026700, ProcessingSo FROM C_Project WHERE AD_Client_ID = 1000243 AND ProcessingSo is not null;
--SELECT 1026714, M_Product_Subcategory_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000243 AND M_Product_Subcategory_ID is not null;
--SELECT 1026717, SRPD_DiscountLevel_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000243 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1026718, IsApplyQtyLevels FROM C_ProjectLine WHERE AD_Client_ID = 1000243 AND IsApplyQtyLevels <> 'N';
--SELECT 1031202, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000243 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1031234, IsUseHH FROM M_Product WHERE AD_Client_ID = 1000243 AND IsUseHH is not null;
--SELECT 1031365, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1000243 AND DiscontinuedStatus is not null;
--SELECT 1031418, C_UOM_Offer_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND C_UOM_Offer_ID is not null;
--SELECT 1031420, PriceListUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND PriceListUOMOffer is not null;
--SELECT 1031422, PriceStdUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND PriceStdUOMOffer is not null;
--SELECT 1031424, PriceLimitUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND PriceLimitUOMOffer is not null;
--SELECT 1031425, Vendor_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND Vendor_ID is not null;
--SELECT 1031426, M_AttributeValue1_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND M_AttributeValue1_ID is not null;
--SELECT 1031427, M_AttributeValue2_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND M_AttributeValue2_ID is not null;
--SELECT 1031428, M_AttributeValue3_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000243 AND M_AttributeValue3_ID is not null;
--SELECT 1031595, UnitContent FROM M_Product WHERE AD_Client_ID = 1000243 AND UnitContent is not null;
--SELECT 1031597, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000243 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1031598, IsHazardous FROM M_Product WHERE AD_Client_ID = 1000243 AND IsHazardous <> 'N';
--SELECT 1031599, IsCalibrated FROM M_Product WHERE AD_Client_ID = 1000243 AND IsCalibrated <> 'N';
--SELECT 1031600, IsBHC FROM M_Product WHERE AD_Client_ID = 1000243 AND IsBHC <> 'N';
--SELECT 1031601, IsProductionPackaging FROM M_Product WHERE AD_Client_ID = 1000243 AND IsProductionPackaging <> 'N';
--SELECT 1031602, IsExtended FROM M_Product WHERE AD_Client_ID = 1000243 AND IsExtended <> 'N';
--SELECT 1031603, IsNew FROM M_Product WHERE AD_Client_ID = 1000243 AND IsNew <> 'N';
--SELECT 1031807, SeqNo FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND SeqNo is not null;
--SELECT 1031841, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND LinkOrderLine_ID is not null;
--SELECT 1031922, SubmitEDI FROM M_InOut WHERE AD_Client_ID = 1000243 AND SubmitEDI is not null;
--SELECT 1032249, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1000243 AND BillSendLocation_ID is not null;
--SELECT 1032263, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1000243 AND DeliveryOption <> 'STD';
--SELECT 1032267, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1000243 AND FreightAmtCalculated is not null;
--SELECT 1032268, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1000243 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1032285, IsProForma FROM C_Order WHERE AD_Client_ID = 1000243 AND IsProForma <> 'N';
--SELECT 1032298, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000243 AND CompletedBy is not null;
--SELECT 1032299, DateCompleted FROM C_Order WHERE AD_Client_ID = 1000243 AND DateCompleted is not null;
--SELECT 1032366, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND SupplierStockQty is not null;
--SELECT 1032367, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND PackQuantitySSM is not null;
--SELECT 1032368, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND IsBHC <> 'N';
--SELECT 1032369, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND IsProductionPackaging <> 'N';
--SELECT 1032370, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND IsHazardous <> 'N';
--SELECT 1032371, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000243 AND LinkOrderLine_ID is not null;

--SELECT 1007638, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000439 AND AttributeName1 is not null;
--SELECT 1007640, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000439 AND AttributeName2 is not null;
--SELECT 1009537, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1000439 AND BillSendLocation_ID is not null;
--SELECT 1009551, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1000439 AND DeliveryOption <> 'STD';
--SELECT 1009555, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1000439 AND FreightAmtCalculated is not null;
--SELECT 1009556, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1000439 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1009573, IsProForma FROM C_Order WHERE AD_Client_ID = 1000439 AND IsProForma <> 'N';
--SELECT 1009586, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000439 AND CompletedBy is not null;
--SELECT 1009587, DateCompleted FROM C_Order WHERE AD_Client_ID = 1000439 AND DateCompleted is not null;
--SELECT 1009655, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND SupplierStockQty is not null;
--SELECT 1009656, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND PackQuantitySSM is not null;
--SELECT 1009657, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND IsBHC <> 'N';
--SELECT 1009658, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND IsProductionPackaging <> 'N';
--SELECT 1009659, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND IsHazardous <> 'N';
--SELECT 1009660, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND LinkOrderLine_ID is not null;
--SELECT 1013476, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1000439 AND BillSendLocation_ID is not null;
--SELECT 1013490, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1000439 AND DeliveryOption <> 'STD';
--SELECT 1013494, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1000439 AND FreightAmtCalculated is not null;
--SELECT 1013495, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1000439 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1013512, IsProForma FROM C_Order WHERE AD_Client_ID = 1000439 AND IsProForma <>'N';
--SELECT 1013525, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000439 AND CompletedBy is not null;
--SELECT 1013526, DateCompleted FROM C_Order WHERE AD_Client_ID = 1000439 AND DateCompleted is not null;
--SELECT 1013593, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND SupplierStockQty is not null;
--SELECT 1013594, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND PackQuantitySSM is not null;
--SELECT 1013595, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND IsBHC <> 'N';
--SELECT 1013596, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND IsProductionPackaging <> 'N';
--SELECT 1013597, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND IsHazardous <> 'N';
--SELECT 1013598, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000439 AND LinkOrderLine_ID is not null;
--SELECT 1021611, TrackingNo FROM C_Invoice WHERE AD_Client_ID = 1000439 AND TrackingNo is not null;
--SELECT 1021765, SubmitEDI FROM M_InOut WHERE AD_Client_ID = 1000439 AND SubmitEDI is not null;
--SELECT 1021810, IsGenerateDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000439 AND IsGenerateDeliveryNote <> 'N';
--SELECT 1021811, IsCancelDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000439 AND IsCancelDeliveryNote <> 'N';
--SELECT 1021932, SubmitEDI FROM M_InOut WHERE AD_Client_ID = 1000439 AND SubmitEDI is not null;
--SELECT 1021977, IsGenerateDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000439 AND IsGenerateDeliveryNote <> 'N';
--SELECT 1021978, IsCancelDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000439 AND IsCancelDeliveryNote <> 'N';
--SELECT 1031047, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1000439 AND TrelloCardID is not null;
--SELECT 1031048, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1000439 AND Trello_Card_ID is not null;
--SELECT 1031062, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000439 AND AttributeName1 is not null;
--SELECT 1031064, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000439 AND AttributeName2 is not null;
--SELECT 1031095, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1000439 AND Trello_Card_Comment_ID is not null;
--SELECT 1031176, TrelloMemberID FROM R_Request_Member WHERE AD_Client_ID = 1000439 AND TrelloMemberID is not null;

--SELECT 1007822, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000714 AND CompletedBy is not null;
--SELECT 1008031, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000714 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1008087, IsUseHH FROM M_Product WHERE AD_Client_ID = 1000714 AND IsUseHH <> 'N';
--SELECT 1008201, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1000714 AND DiscontinuedStatus is not null;
--SELECT 1008372, UnitContent FROM M_Product WHERE AD_Client_ID = 1000714 AND UnitContent is not null;
--SELECT 1008374, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000714 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1008375, IsHazardous FROM M_Product WHERE AD_Client_ID = 1000714 AND IsHazardous <> 'N';
--SELECT 1008376, IsCalibrated FROM M_Product WHERE AD_Client_ID = 1000714 AND IsCalibrated <> 'N';
--SELECT 1008377, IsBHC FROM M_Product WHERE AD_Client_ID = 1000714 AND IsBHC <>'N';
--SELECT 1008378, IsProductionPackaging FROM M_Product WHERE AD_Client_ID = 1000714 AND IsProductionPackaging <> 'N';
--SELECT 1008379, IsExtended FROM M_Product WHERE AD_Client_ID = 1000714 AND IsExtended <> 'N';
--SELECT 1008380, IsNew FROM M_Product WHERE AD_Client_ID = 1000714 AND IsNew <> 'N';
--SELECT 1024700, IsMultiLevelMarketing FROM C_BPartner WHERE AD_Client_ID = 1000714 AND IsMultiLevelMarketing is not null;

--SELECT 1010108, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1000722 AND SupplierStockQty is not null;
--SELECT 1010109, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1000722 AND PackQuantitySSM is not null;
--SELECT 1010110, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1000722 AND IsBHC <> 'N';
--SELECT 1010111, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1000722 AND IsProductionPackaging <> 'N';
--SELECT 1010112, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1000722 AND IsHazardous <> 'N';
--SELECT 1010113, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000722 AND LinkOrderLine_ID is not null;
--SELECT 1011348, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000722 AND AttributeName1 is not null;
--SELECT 1011350, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000722 AND AttributeName2 is not null;
--SELECT 1035502, IsDeleteEventUsers FROM C_Project WHERE AD_Client_ID = 1000722 AND IsDeleteEventUsers <> 'N';
--SELECT 1035513, ProcessingSo FROM C_Project WHERE AD_Client_ID = 1000722 AND ProcessingSo is not null;
--SELECT 1012451, M_Product_Subcategory_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000722 AND M_Product_Subcategory_ID is not null;
--SELECT 1012454, SRPD_DiscountLevel_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000722 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1012455, IsApplyQtyLevels FROM C_ProjectLine WHERE AD_Client_ID = 1000722 AND IsApplyQtyLevels <> 'N';
--SELECT 1013213, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000722 AND AttributeName1 is not null;
--SELECT 1013214, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000722 AND AttributeName2 is not null;
--SELECT 1013306, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000722 AND AttributeName1 is not null;
--SELECT 1013307, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000722 AND AttributeName2 is not null;
--SELECT 1018983, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000722 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1019152, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1000722 AND DiscontinuedStatus is not null;
--SELECT 1019323, UnitContent FROM M_Product WHERE AD_Client_ID = 1000722 AND UnitContent is not null;
--SELECT 1019325, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000722 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1019326, IsHazardous FROM M_Product WHERE AD_Client_ID = 1000722 AND IsHazardous <> 'N';
--SELECT 1019327, IsCalibrated FROM M_Product WHERE AD_Client_ID = 1000722 AND IsCalibrated <> 'N';
--SELECT 1019328, IsBHC FROM M_Product WHERE AD_Client_ID = 1000722 AND IsBHC <> 'N';
--SELECT 1019329, IsProductionPackaging FROM M_Product WHERE AD_Client_ID = 1000722 AND IsProductionPackaging <> 'N';
--SELECT 1019330, IsExtended FROM M_Product WHERE AD_Client_ID = 1000722 AND IsExtended <> 'N';
--SELECT 1019331, IsNew FROM M_Product WHERE AD_Client_ID = 1000722 AND IsNew <> 'N';

--SELECT 1013676, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1000839 AND BillSendLocation_ID is not null;
--SELECT 1013690, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1000839 AND DeliveryOption <> 'STD';
--SELECT 1013694, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1000839 AND FreightAmtCalculated is not null;
--SELECT 1013695, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1000839 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1013712, IsProForma FROM C_Order WHERE AD_Client_ID = 1000839 AND IsProForma <> 'N';
--SELECT 1013725, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000839 AND CompletedBy is not null;
--SELECT 1013726, DateCompleted FROM C_Order WHERE AD_Client_ID = 1000839 AND DateCompleted is not null;
--SELECT 1013793, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND SupplierStockQty is not null;
--SELECT 1013794, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND PackQuantitySSM is not null;
--SELECT 1013795, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND IsBHC <> 'N';
--SELECT 1013796, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND IsProductionPackaging <> 'N';
--SELECT 1013797, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND IsHazardous <> 'N';
--SELECT 1013798, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND LinkOrderLine_ID is not null;
--SELECT 1013855, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1000839 AND BillSendLocation_ID is not null;
--SELECT 1013869, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1000839 AND DeliveryOption <> 'STD';
--SELECT 1013873, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1000839 AND FreightAmtCalculated is not null;
--SELECT 1013874, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1000839 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1013891, IsProForma FROM C_Order WHERE AD_Client_ID = 1000839 AND IsProForma <> 'N';
--SELECT 1013904, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000839 AND CompletedBy is not null;
--SELECT 1013905, DateCompleted FROM C_Order WHERE AD_Client_ID = 1000839 AND DateCompleted is not null;
--SELECT 1013972, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND SupplierStockQty is not null;
--SELECT 1013973, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND PackQuantitySSM is not null;
--SELECT 1013974, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND IsBHC <> 'N';
--SELECT 1013975, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND IsProductionPackaging <> 'N';
--SELECT 1013976, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND IsHazardous <> 'N';
--SELECT 1013977, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND LinkOrderLine_ID is not null;
--SELECT 1015613, TrackingNo FROM C_Invoice WHERE AD_Client_ID = 1000839 AND TrackingNo is not null;
--SELECT 1015869, SeqNo FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND SeqNo is not null;
--SELECT 1015903, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000839 AND LinkOrderLine_ID is not null;
--SELECT 1015988, SubmitEDI FROM M_InOut WHERE AD_Client_ID = 1000839 AND SubmitEDI is not null;
--SELECT 1016033, IsGenerateDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000839 AND IsGenerateDeliveryNote <> 'N';
--SELECT 1016034, IsCancelDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000839 AND IsCancelDeliveryNote <> 'N';
--SELECT 1032860, IsFromStock FROM M_InOutLine WHERE AD_Client_ID = 1000839 AND IsFromStock <> 'N';

--SELECT 1010399, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000857 AND C_IndustrySubcode_ID is not null;
--SELECT 1010661, M_Product_Subcategory_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000857 AND M_Product_Subcategory_ID is not null;
--SELECT 1010664, SRPD_DiscountLevel_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000857 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1010665, IsApplyQtyLevels FROM C_ProjectLine WHERE AD_Client_ID = 1000857 AND IsApplyQtyLevels <> 'N';
--SELECT 1014163, M_Product_Subcategory_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000857 AND M_Product_Subcategory_ID is not null;
--SELECT 1014166, SRPD_DiscountLevel_ID FROM C_ProjectLine WHERE AD_Client_ID = 1000857 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1014167, IsApplyQtyLevels FROM C_ProjectLine WHERE AD_Client_ID = 1000857 AND IsApplyQtyLevels <> 'N';
--SELECT 1015293, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000857 AND AttributeName1 is not null;
--SELECT 1015294, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000857 AND AttributeName2 is not null;
--SELECT 1021520, QtyToDeliver FROM R_Request WHERE AD_Client_ID = 1000857 AND QtyToDeliver is not null;
--SELECT 1021528, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1000857 AND Trello_Card_ID is not null;
--SELECT 1021529, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1000857 AND TrelloCardID is not null;
--SELECT 1017621, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1000857 AND DiscontinuedStatus is not null;
--SELECT 1018026, SeqNo FROM C_OrderLine WHERE AD_Client_ID = 1000857 AND SeqNo is not null;
--SELECT 1018186, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1000857 AND DeliveryOption <> 'STD';
--SELECT 1018208, IsProForma FROM C_Order WHERE AD_Client_ID = 1000857 AND IsProForma <> 'N';
--SELECT 1018221, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000857 AND CompletedBy is not null;
--SELECT 1018222, DateCompleted FROM C_Order WHERE AD_Client_ID = 1000857 AND DateCompleted is not null;
--SELECT 1018598, SubmitEDI FROM M_InOut WHERE AD_Client_ID = 1000857 AND SubmitEDI is not null;
--SELECT 1022158, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000857 AND AttributeName1 is not null;
--SELECT 1022160, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000857 AND AttributeName2 is not null;
--SELECT 1022493, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1000857 AND AttributeName1 is not null;
--SELECT 1022494, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1000857 AND AttributeName2 is not null;
--SELECT 1022568, QtyToDeliver FROM R_Request WHERE AD_Client_ID = 1000857 AND QtyToDeliver is not null;
--SELECT 1022576, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1000857 AND Trello_Card_ID is not null;
--SELECT 1022577, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1000857 AND TrelloCardID is not null;

--SELECT 1027425, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000864 AND C_IndustrySubcode_ID is not null;
--SELECT 1027512, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000864 AND C_IndustrySubcode_ID is not null;
--SELECT 1038394, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000864 AND C_IndustrySubcode_ID is not null;
--SELECT 1038427, ProcessingSo FROM C_Lead WHERE AD_Client_ID = 1000864 AND ProcessingSo is not null;

--SELECT 1019748, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000878 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1019780, IsUseHH FROM M_Product WHERE AD_Client_ID = 1000878 AND IsUseHH <> 'N';
--SELECT 1019909, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1000878 AND DiscontinuedStatus is not null;
--SELECT 1020048, UnitContent FROM M_Product WHERE AD_Client_ID = 1000878 AND UnitContent is not null;
--SELECT 1020050, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000878 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1020051, IsHazardous FROM M_Product WHERE AD_Client_ID = 1000878 AND IsHazardous <> 'N';
--SELECT 1020052, IsCalibrated FROM M_Product WHERE AD_Client_ID = 1000878 AND IsCalibrated <> 'N';
--SELECT 1020053, IsBHC FROM M_Product WHERE AD_Client_ID = 1000878 AND IsBHC <> 'N';
--SELECT 1020054, IsProductionPackaging FROM M_Product WHERE AD_Client_ID = 1000878 AND IsProductionPackaging <> 'N';
--SELECT 1020055, IsExtended FROM M_Product WHERE AD_Client_ID = 1000878 AND IsExtended <> 'N';
--SELECT 1020056, IsNew FROM M_Product WHERE AD_Client_ID = 1000878 AND IsNew <> 'N';
--SELECT 1020115, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1000878 AND C_IndustrySubcode_ID is not null;
--SELECT 1020139, TrelloCardID FROM C_Lead WHERE AD_Client_ID = 1000878 AND TrelloCardID is not null;
--SELECT 1020140, Trello_Card_ID FROM C_Lead WHERE AD_Client_ID = 1000878 AND Trello_Card_ID is not null;

--SELECT 1030444, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000879 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1030476, IsUseHH FROM M_Product WHERE AD_Client_ID = 1000879 AND IsUseHH <> 'N';
--SELECT 1030607, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1000879 AND DiscontinuedStatus is not null;
--SELECT 1030660, C_UOM_Offer_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND C_UOM_Offer_ID is not null;
--SELECT 1030662, PriceListUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND PriceListUOMOffer is not null;
--SELECT 1030664, PriceStdUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND PriceStdUOMOffer is not null;
--SELECT 1030666, PriceLimitUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND PriceLimitUOMOffer is not null;
--SELECT 1030667, Vendor_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND Vendor_ID is not null;
--SELECT 1030668, M_AttributeValue1_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND M_AttributeValue1_ID is not null;
--SELECT 1030669, M_AttributeValue2_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND M_AttributeValue2_ID is not null;
--SELECT 1030670, M_AttributeValue3_ID FROM M_ProductPrice WHERE AD_Client_ID = 1000879 AND M_AttributeValue3_ID is not null;
--SELECT 1030837, UnitContent FROM M_Product WHERE AD_Client_ID = 1000879 AND UnitContent is not null;
--SELECT 1030839, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1000879 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1030840, IsHazardous FROM M_Product WHERE AD_Client_ID = 1000879 AND IsHazardous <> 'N';
--SELECT 1030841, IsCalibrated FROM M_Product WHERE AD_Client_ID = 1000879 AND IsCalibrated <> 'N';
--SELECT 1030842, IsBHC FROM M_Product WHERE AD_Client_ID = 1000879 AND IsBHC <> 'N';
--SELECT 1030843, IsProductionPackaging FROM M_Product WHERE AD_Client_ID = 1000879 AND IsProductionPackaging <> 'N';
--SELECT 1030844, IsExtended FROM M_Product WHERE AD_Client_ID = 1000879 AND IsExtended <>'N';
--SELECT 1030845, IsNew FROM M_Product WHERE AD_Client_ID = 1000879 AND IsNew <> 'N';
--SELECT 1037182, SubmitEDI FROM M_InOut WHERE AD_Client_ID = 1000879 AND SubmitEDI is not null;
--SELECT 1037227, IsGenerateDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000879 AND IsGenerateDeliveryNote <> 'N';
--SELECT 1037228, IsCancelDeliveryNote FROM M_InOut WHERE AD_Client_ID = 1000879 AND IsCancelDeliveryNote <> 'N';

--SELECT 1023280, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1000938 AND BillSendLocation_ID is not null;
--SELECT 1023294, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1000938 AND DeliveryOption <> 'STD';
--SELECT 1023298, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1000938 AND FreightAmtCalculated is not null;
--SELECT 1023299, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1000938 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1023316, IsProForma FROM C_Order WHERE AD_Client_ID = 1000938 AND IsProForma <> 'N';
--SELECT 1023329, CompletedBy FROM C_Order WHERE AD_Client_ID = 1000938 AND CompletedBy is not null;
--SELECT 1023330, DateCompleted FROM C_Order WHERE AD_Client_ID = 1000938 AND DateCompleted is not null;
--SELECT 1023397, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1000938 AND SupplierStockQty is not null;
--SELECT 1023398, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1000938 AND PackQuantitySSM is not null;
--SELECT 1023399, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1000938 AND IsBHC <> 'N';
--SELECT 1023400, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1000938 AND IsProductionPackaging <> 'N';
--SELECT 1023401, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1000938 AND IsHazardous <> 'N';
--SELECT 1023402, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1000938 AND LinkOrderLine_ID is not null;

--SELECT 1025198, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1001100 AND BillSendLocation_ID is not null;
--SELECT 1025212, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1001100 AND DeliveryOption <> 'STD';
--SELECT 1025216, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1001100 AND FreightAmtCalculated is not null;
--SELECT 1025217, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1001100 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1025234, IsProForma FROM C_Order WHERE AD_Client_ID = 1001100 AND IsProForma <> 'N';
--SELECT 1025247, CompletedBy FROM C_Order WHERE AD_Client_ID = 1001100 AND CompletedBy is not null;
--SELECT 1025248, DateCompleted FROM C_Order WHERE AD_Client_ID = 1001100 AND DateCompleted is not null;
--SELECT 1025315, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1001100 AND SupplierStockQty is not null;
--SELECT 1025316, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1001100 AND PackQuantitySSM is not null;
--SELECT 1025317, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1001100 AND IsBHC <> 'N';
--SELECT 1025318, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1001100 AND IsProductionPackaging <> 'N';
--SELECT 1025319, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1001100 AND IsHazardous <> 'N';
--SELECT 1025320, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1001100 AND LinkOrderLine_ID is not null;

--SELECT 1023504, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1001154 AND C_IndustrySubcode_ID is not null;
--SELECT 1023528, TrelloCardID FROM C_Lead WHERE AD_Client_ID = 1001154 AND TrelloCardID is not null;
--SELECT 1023529, Trello_Card_ID FROM C_Lead WHERE AD_Client_ID = 1001154 AND Trello_Card_ID is not null;
--SELECT 1023655, IsDeleteEventUsers FROM C_Project WHERE AD_Client_ID = 1001154 AND IsDeleteEventUsers <> 'N';
--SELECT 1023685, ProcessingSo FROM C_Project WHERE AD_Client_ID = 1001154 AND ProcessingSo is not null;
--SELECT 1023709, IsApplyQtyLevels FROM C_ProjectLine WHERE AD_Client_ID = 1001154 AND IsApplyQtyLevels <> 'N';
--SELECT 1023717, SRPD_DiscountLevel_ID FROM C_ProjectLine WHERE AD_Client_ID = 1001154 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1023738, M_Product_Subcategory_ID FROM C_ProjectLine WHERE AD_Client_ID = 1001154 AND M_Product_Subcategory_ID is not null;
--SELECT 1023797, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1001154 AND BillSendLocation_ID is not null;
--SELECT 1023811, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1001154 AND DeliveryOption <> 'STD';
--SELECT 1023815, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1001154 AND FreightAmtCalculated is not null;
--SELECT 1023816, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1001154 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1023833, IsProForma FROM C_Order WHERE AD_Client_ID = 1001154 AND IsProForma <> 'N';
--SELECT 1023846, CompletedBy FROM C_Order WHERE AD_Client_ID = 1001154 AND CompletedBy is not null;
--SELECT 1023847, DateCompleted FROM C_Order WHERE AD_Client_ID = 1001154 AND DateCompleted is not null;
--SELECT 1023914, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND SupplierStockQty is not null;
--SELECT 1023915, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND PackQuantitySSM is not null;
--SELECT 1023916, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsBHC <> 'N';
--SELECT 1023917, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsProductionPackaging <> 'N';
--SELECT 1023918, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsHazardous <> 'N';
--SELECT 1023919, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND LinkOrderLine_ID is not null;
--SELECT 1024026, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1001154 AND BillSendLocation_ID is not null;
--SELECT 1024040, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1001154 AND DeliveryOption <> 'STD';
--SELECT 1024044, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1001154 AND FreightAmtCalculated is not null;
--SELECT 1024045, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1001154 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1024062, IsProForma FROM C_Order WHERE AD_Client_ID = 1001154 AND IsProForma <> 'N';
--SELECT 1024075, CompletedBy FROM C_Order WHERE AD_Client_ID = 1001154 AND CompletedBy is not null;
--SELECT 1024076, DateCompleted FROM C_Order WHERE AD_Client_ID = 1001154 AND DateCompleted is not null;
--SELECT 1025345, IsOrderAcknowledgment FROM C_Order WHERE AD_Client_ID = 1001154 AND IsOrderAcknowledgment <> 'N';
--SELECT 1025348, PrintReceipt FROM C_Order WHERE AD_Client_ID = 1001154 AND PrintReceipt <> 'N';
--SELECT 1024143, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND SupplierStockQty is not null;
--SELECT 1024144, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND PackQuantitySSM is not null;
--SELECT 1024145, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsBHC <> 'N';
--SELECT 1024146, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsProductionPackaging <> 'N';
--SELECT 1024147, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsHazardous <> 'N';
--SELECT 1024148, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND LinkOrderLine_ID is not null;
--SELECT 1024445, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName1 is not null;
--SELECT 1024446, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName2 is not null;
--SELECT 1024538, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName1 is not null;
--SELECT 1024539, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName2 is not null;
--SELECT 1025457, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName1 is not null;
--SELECT 1025458, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName2 is not null;
--SELECT 1025508, QtyToDeliver FROM R_Request WHERE AD_Client_ID = 1001154 AND QtyToDeliver is not null;
--SELECT 1025547, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1001154 AND Trello_Card_ID is not null;
--SELECT 1025548, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1001154 AND TrelloCardID is not null;
--SELECT 1025577, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1001154 AND Trello_Card_Comment_ID is not null;
--SELECT 1025578, TrelloCardCommentID FROM R_RequestUpdate WHERE AD_Client_ID = 1001154 AND TrelloCardCommentID is not null;
--SELECT 1025656, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1001154 AND TrelloCardID is not null;
--SELECT 1025657, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1001154 AND Trello_Card_ID is not null;
--SELECT 1025671, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName1 is not null;
--SELECT 1025673, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1001154 AND AttributeName2 is not null;
--SELECT 1025704, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1001154 AND Trello_Card_Comment_ID is not null;
--SELECT 1026769, IsMultiLevelMarketing FROM C_BPartner WHERE AD_Client_ID = 1001154 AND IsMultiLevelMarketing is not null;
--SELECT 1026816, IsAvailableToSync FROM C_BPartner WHERE AD_Client_ID = 1001154 AND IsAvailableToSync <> 'N';
--SELECT 1028436, IsOrderAcknowledgment FROM C_Order WHERE AD_Client_ID = 1001154 AND IsOrderAcknowledgment <> 'N';
--SELECT 1028439, PrintReceipt FROM C_Order WHERE AD_Client_ID = 1001154 AND PrintReceipt <> 'N';
--SELECT 1028475, IsProForma FROM C_Order WHERE AD_Client_ID = 1001154 AND IsProForma <> 'N';
--SELECT 1028476, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1001154 AND BillSendLocation_ID is not null;
--SELECT 1028487, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1001154 AND FreightAmtCalculated is not null;
--SELECT 1028488, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1001154 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1028512, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1001154 AND DeliveryOption <> 'STD';
--SELECT 1028540, CompletedBy FROM C_Order WHERE AD_Client_ID = 1001154 AND CompletedBy is not null;
--SELECT 1028541, DateCompleted FROM C_Order WHERE AD_Client_ID = 1001154 AND DateCompleted is not null;
--SELECT 1028571, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND SupplierStockQty is not null;
--SELECT 1028572, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND PackQuantitySSM is not null;
--SELECT 1028573, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsBHC <> 'N';
--SELECT 1028574, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsProductionPackaging <> 'N';
--SELECT 1028575, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND IsHazardous <> 'N';
--SELECT 1028576, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1001154 AND LinkOrderLine_ID is not null;
--SELECT 1028708, IsEDIExported FROM C_Invoice WHERE AD_Client_ID = 1001154 AND IsEDIExported <> 'N';
--SELECT 1028709, ExportToEDI FROM C_Invoice WHERE AD_Client_ID = 1001154 AND ExportToEDI <> 'N';


--SELECT 1030141, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002406 AND AttributeName1 is not null;
--SELECT 1030142, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002406 AND AttributeName2 is not null;
--SELECT 1030234, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002406 AND AttributeName1 is not null;
--SELECT 1030235, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002406 AND AttributeName2 is not null;

--SELECT 1033473, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1002459 AND TrelloCardID is not null;
--SELECT 1033474, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1002459 AND Trello_Card_ID is not null;
--SELECT 1033488, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName1 is not null;
--SELECT 1033490, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName2 is not null;
--SELECT 1033521, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1002459 AND Trello_Card_Comment_ID is not null;
--SELECT 1033602, TrelloMemberID FROM R_Request_Member WHERE AD_Client_ID = 1002459 AND TrelloMemberID is not null;
--SELECT 1034528, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName2 is not null;
--SELECT 1034587, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1002459 AND TrelloCardID is not null;
--SELECT 1034588, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1002459 AND Trello_Card_ID is not null;
--SELECT 1034602, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName1 is not null;
--SELECT 1034651, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1002459 AND Trello_Card_Comment_ID is not null;
--SELECT 1034732, TrelloMemberID FROM R_Request_Member WHERE AD_Client_ID = 1002459 AND TrelloMemberID is not null;
--SELECT 1034734, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName2 is not null;
--SELECT 1034793, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1002459 AND TrelloCardID is not null;
--SELECT 1034794, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1002459 AND Trello_Card_ID is not null;
--SELECT 1034808, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName1 is not null;
--SELECT 1034857, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1002459 AND Trello_Card_Comment_ID is not null;
--SELECT 1034938, TrelloMemberID FROM R_Request_Member WHERE AD_Client_ID = 1002459 AND TrelloMemberID is not null;
--SELECT 1042740, Vendor_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND Vendor_ID is not null;
--SELECT 1042742, M_AttributeValue2_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue2_ID is not null;
--SELECT 1042743, ProductAttributes FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND ProductAttributes is not null;
--SELECT 1042744, M_AttributeValue1_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue1_ID is not null;
--SELECT 1042746, M_AttributeValue3_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue3_ID is not null;
--SELECT 1042791, BOMPriceList FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND BOMPriceList is not null;
--SELECT 1042828, UpdateQuotationPrices FROM C_ProjectPhase WHERE AD_Client_ID = 1002459 AND UpdateQuotationPrices is not null;
--SELECT 1042839, M_AttributeValue1_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue1_ID is not null;
--SELECT 1042844, Vendor_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND Vendor_ID is not null;
--SELECT 1042846, M_AttributeValue2_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue2_ID is not null;
--SELECT 1042847, M_AttributeValue3_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue3_ID is not null;
--SELECT 1042848, ProductAttributes FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND ProductAttributes is not null;
--SELECT 1042914, Vendor_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND Vendor_ID is not null;
--SELECT 1042921, ProductAttributes FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND ProductAttributes is not null;
--SELECT 1042922, M_AttributeValue3_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue3_ID is not null;
--SELECT 1042923, M_AttributeValue2_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue2_ID is not null;
--SELECT 1042924, M_AttributeValue1_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_AttributeValue1_ID is not null;
--SELECT 1042987, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName1 is not null;
--SELECT 1042988, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName2 is not null;
--SELECT 1043080, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName1 is not null;
--SELECT 1043081, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName2 is not null;
--SELECT 1043385, ProcessingSo FROM C_Project WHERE AD_Client_ID = 1002459 AND ProcessingSo is not null;
--SELECT 1043399, M_Product_Subcategory_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND M_Product_Subcategory_ID is not null;
--SELECT 1043402, SRPD_DiscountLevel_ID FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1043403, IsApplyQtyLevels FROM C_ProjectLine WHERE AD_Client_ID = 1002459 AND IsApplyQtyLevels <> 'N';
--SELECT 1044066, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName1 is not null;
--SELECT 1044068, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002459 AND AttributeName2 is not null;

--SELECT 1035678, UpdateQuotationPrices FROM C_ProjectPhase WHERE AD_Client_ID = 1002561 AND UpdateQuotationPrices is not null;
--SELECT 1036381, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName1 is not null;
--SELECT 1036382, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName2 is not null;
--SELECT 1036732, ExciseAmtInBaseCurr FROM M_Inventory WHERE AD_Client_ID = 1002561 AND ExciseAmtInBaseCurr is not null;
--SELECT 1036811, ExciseAmtInBaseCurr FROM M_InventoryLine WHERE AD_Client_ID = 1002561 AND ExciseAmtInBaseCurr is not null;
--SELECT 1036885, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1002561 AND C_IndustrySubcode_ID is not null;
--SELECT 1036909, TrelloCardID FROM C_Lead WHERE AD_Client_ID = 1002561 AND TrelloCardID is not null;
--SELECT 1036910, Trello_Card_ID FROM C_Lead WHERE AD_Client_ID = 1002561 AND Trello_Card_ID is not null;
--SELECT 1037025, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName1 is not null;
--SELECT 1037026, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName2 is not null;
--SELECT 1037076, QtyToDeliver FROM R_Request WHERE AD_Client_ID = 1002561 AND QtyToDeliver is not null;
--SELECT 1037115, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1002561 AND Trello_Card_ID is not null;
--SELECT 1037116, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1002561 AND TrelloCardID is not null;
--SELECT 1037336, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1002561 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1037407, C_EcoTax_ID FROM M_Product WHERE AD_Client_ID = 1002561 AND C_EcoTax_ID is not null;
--SELECT 1037532, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1002561 AND DiscontinuedStatus is not null;
--SELECT 1037676, UnitContent FROM M_Product WHERE AD_Client_ID = 1002561 AND UnitContent is not null;
--SELECT 1037678, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1002561 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1037679, IsHazardous FROM M_Product WHERE AD_Client_ID = 1002561 AND IsHazardous <> 'N';
--SELECT 1037680, IsCalibrated FROM M_Product WHERE AD_Client_ID = 1002561 AND IsCalibrated <> 'N';
--SELECT 1037681, IsBHC FROM M_Product WHERE AD_Client_ID = 1002561 AND IsBHC <> 'N';
--SELECT 1037682, IsProductionPackaging FROM M_Product WHERE AD_Client_ID = 1002561 AND IsProductionPackaging <> 'N';
--SELECT 1037683, IsExtended FROM M_Product WHERE AD_Client_ID = 1002561 AND IsExtended <> 'N';
--SELECT 1037684, IsNew FROM M_Product WHERE AD_Client_ID = 1002561 AND IsNew <> 'N';
--SELECT 1037685, IsExciseReference FROM M_Product WHERE AD_Client_ID = 1002561 AND IsExciseReference <> 'N';
--SELECT 1037690, SO_ExciseProductKey_ID FROM M_Product WHERE AD_Client_ID = 1002561 AND SO_ExciseProductKey_ID is not null;
--SELECT 1037691, C_UOM_Excise_ID FROM M_Product WHERE AD_Client_ID = 1002561 AND C_UOM_Excise_ID is not null;
--SELECT 1037692, DegreeAlcohol FROM M_Product WHERE AD_Client_ID = 1002561 AND DegreeAlcohol is not null;
--SELECT 1037742, IsMultiLevelMarketing FROM C_BPartner WHERE AD_Client_ID = 1002561 AND IsMultiLevelMarketing is not null;
--SELECT 1037774, IsTaxDelayed FROM C_BPartner WHERE AD_Client_ID = 1002561 AND IsTaxDelayed <> 'N';
--SELECT 1037790, IsValidateTaxID FROM C_BPartner WHERE AD_Client_ID = 1002561 AND IsValidateTaxID <> 'N';
--SELECT 1037791, TaxIDValidationDate FROM C_BPartner WHERE AD_Client_ID = 1002561 AND TaxIDValidationDate is not null;
--SELECT 1037792, IsTaxIDValid FROM C_BPartner WHERE AD_Client_ID = 1002561 AND IsTaxIDValid <> 'N';
--SELECT 1039949, UpdateQuotationPrices FROM C_ProjectPhase WHERE AD_Client_ID = 1002561 AND UpdateQuotationPrices is not null;
--SELECT 1040108, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName1 is not null;
--SELECT 1040109, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName2 is not null;
--SELECT 1040201, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName1 is not null;
--SELECT 1040202, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName2 is not null;
--SELECT 1040459, TrelloCardID FROM R_Request WHERE AD_Client_ID = 1002561 AND TrelloCardID is not null;
--SELECT 1040460, Trello_Card_ID FROM R_Request WHERE AD_Client_ID = 1002561 AND Trello_Card_ID is not null;
--SELECT 1040474, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName1 is not null;
--SELECT 1040476, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName2 is not null;
--SELECT 1040507, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1002561 AND Trello_Card_Comment_ID is not null;
--SELECT 1040588, TrelloMemberID FROM R_Request_Member WHERE AD_Client_ID = 1002561 AND TrelloMemberID is not null;
--SELECT 1040827, ExciseAmtInBaseCurr FROM M_Inventory WHERE AD_Client_ID = 1002561 AND ExciseAmtInBaseCurr is not null;
--SELECT 1040876, ExciseAmtInBaseCurr FROM M_InventoryLine WHERE AD_Client_ID = 1002561 AND ExciseAmtInBaseCurr is not null;
--SELECT 1040905, AttributeName1 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName1 is not null;
--SELECT 1040906, AttributeName2 FROM R_Request WHERE AD_Client_ID = 1002561 AND AttributeName2 is not null;
--SELECT 1041230, ExciseAmtInBaseCurr FROM M_Inventory WHERE AD_Client_ID = 1002561 AND ExciseAmtInBaseCurr is not null;
--SELECT 1041279, ExciseAmtInBaseCurr FROM M_InventoryLine WHERE AD_Client_ID = 1002561 AND ExciseAmtInBaseCurr is not null;

--SELECT 1032641, C_IndustrySubcode_ID FROM C_Lead WHERE AD_Client_ID = 1002756 AND C_IndustrySubcode_ID is not null;
--SELECT 1032665, TrelloCardID FROM C_Lead WHERE AD_Client_ID = 1002756 AND TrelloCardID is not null;
--SELECT 1032666, Trello_Card_ID FROM C_Lead WHERE AD_Client_ID = 1002756 AND Trello_Card_ID is not null;
--SELECT 1032674, ProcessingSo FROM C_Lead WHERE AD_Client_ID = 1002756 AND ProcessingSo is not null;
--SELECT 1032808, Trello_Card_Comment_ID FROM R_RequestUpdate WHERE AD_Client_ID = 1002756 AND Trello_Card_Comment_ID is not null;
--SELECT 1032809, TrelloCardCommentID FROM R_RequestUpdate WHERE AD_Client_ID = 1002756 AND TrelloCardCommentID is not null;

--SELECT 1041917, BillSendLocation_ID FROM C_Order WHERE AD_Client_ID = 1003311 AND BillSendLocation_ID is not null;
--SELECT 1041931, DeliveryOption FROM C_Order WHERE AD_Client_ID = 1003311 AND DeliveryOption <> 'STD';
--SELECT 1041935, FreightAmtCalculated FROM C_Order WHERE AD_Client_ID = 1003311 AND FreightAmtCalculated is not null;
--SELECT 1041936, IsAddFreightAmtToOrder FROM C_Order WHERE AD_Client_ID = 1003311 AND IsAddFreightAmtToOrder <> 'N';
--SELECT 1041957, IsProForma FROM C_Order WHERE AD_Client_ID = 1003311 AND IsProForma <> 'N';
--SELECT 1041970, CompletedBy FROM C_Order WHERE AD_Client_ID = 1003311 AND CompletedBy is not null;
--SELECT 1041971, DateCompleted FROM C_Order WHERE AD_Client_ID = 1003311 AND DateCompleted is not null;
--SELECT 1042038, SupplierStockQty FROM C_OrderLine WHERE AD_Client_ID = 1003311 AND SupplierStockQty is not null;
--SELECT 1042039, PackQuantitySSM FROM C_OrderLine WHERE AD_Client_ID = 1003311 AND PackQuantitySSM is not null;
--SELECT 1042040, IsBHC FROM C_OrderLine WHERE AD_Client_ID = 1003311 AND IsBHC <> 'N';
--SELECT 1042041, IsProductionPackaging FROM C_OrderLine WHERE AD_Client_ID = 1003311 AND IsProductionPackaging <> 'N';
--SELECT 1042042, IsHazardous FROM C_OrderLine WHERE AD_Client_ID = 1003311 AND IsHazardous <> 'N';
--SELECT 1042043, LinkOrderLine_ID FROM C_OrderLine WHERE AD_Client_ID = 1003311 AND LinkOrderLine_ID is not null;
--SELECT 1042113, ExportToEDI FROM C_Invoice WHERE AD_Client_ID = 1003311 AND ExportToEDI <> 'N';
--SELECT 1042114, TrackingNo FROM C_Invoice WHERE AD_Client_ID = 1003311 AND TrackingNo is not null;
--SELECT 1042139, IsEDIExported FROM C_Invoice WHERE AD_Client_ID = 1003311 AND IsEDIExported <> 'N';
--SELECT 1042301, CourierService FROM C_Payment WHERE AD_Client_ID = 1003311 AND CourierService is not null;
--SELECT 1042302, TrackingNo FROM C_Payment WHERE AD_Client_ID = 1003311 AND TrackingNo is not null;
--SELECT 1043452, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1003311 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1043484, IsUseHH FROM M_Product WHERE AD_Client_ID = 1003311 AND IsUseHH <> 'N';
--SELECT 1043616, DiscontinuedStatus FROM M_Product_PO WHERE AD_Client_ID = 1003311 AND DiscontinuedStatus is not null;
--SELECT 1043669, C_UOM_Offer_ID FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND C_UOM_Offer_ID is not null;
--SELECT 1043671, PriceListUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND PriceListUOMOffer is not null;
--SELECT 1043673, PriceStdUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND PriceStdUOMOffer is not null;
--SELECT 1043675, PriceLimitUOMOffer FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND PriceLimitUOMOffer is not null;
--SELECT 1043676, Vendor_ID FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND Vendor_ID is not null;
--SELECT 1043677, M_AttributeValue1_ID FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND M_AttributeValue1_ID is not null;
--SELECT 1043678, M_AttributeValue2_ID FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND M_AttributeValue2_ID is not null;
--SELECT 1043679, M_AttributeValue3_ID FROM M_ProductPrice WHERE AD_Client_ID = 1003311 AND M_AttributeValue3_ID is not null;
--SELECT 1043845, UnitContent FROM M_Product WHERE AD_Client_ID = 1003311 AND UnitContent is not null;
--SELECT 1043847, SRPD_DiscountLevel_ID FROM M_Product WHERE AD_Client_ID = 1003311 AND SRPD_DiscountLevel_ID is not null;
--SELECT 1043848, IsHazardous FROM M_Product WHERE AD_Client_ID = 1003311 AND IsHazardous <> 'N';
--SELECT 1043849, IsCalibrated FROM M_Product WHERE AD_Client_ID = 1003311 AND IsCalibrated <> 'N';
--SELECT 1043850, IsBHC FROM M_Product WHERE AD_Client_ID = 1003311 AND IsBHC <> 'N';
--SELECT 1043851, IsProductionPackaging FROM M_Product WHERE AD_Client_ID = 1003311 AND IsProductionPackaging <> 'N';
--SELECT 1043852, IsExtended FROM M_Product WHERE AD_Client_ID = 1003311 AND IsExtended <> 'N';
--SELECT 1043853, IsNew FROM M_Product WHERE AD_Client_ID = 1003311 AND IsNew <> 'N';