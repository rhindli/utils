/*
select * from AD_Window where  created>=trunc(sysdate);

select * from AD_Window_TRL where  created>=trunc(sysdate);

select * from AD_TAB where  created>=trunc(sysdate);

select * from AD_TAB_TRL where  created>=trunc(sysdate);

select * from AD_TAB where  AD_Tab_ID=2140901206;

select * from AD_TAB_TRL where  AD_Tab_ID=2140901206;

select * from AD_Field where AD_Tab_ID=2140900139 and created>=trunc(sysdate);

select * from AD_Field_TRL where AD_FIELD_ID in (select AD_Field_ID from AD_Field where AD_Tab_ID=2140900139 and created>=trunc(sysdate));

select * from AD_Field where AD_Tab_ID IN (2140900831);

select * from AD_Field_TRL where AD_FIELD_ID in (select AD_Field_ID from AD_Field where AD_Tab_ID IN (2140900831)) AND AD_Language='ro_RO';

select * from AD_Window where  AD_Window_ID=2140900455;
select * from AD_Window_TRL where  AD_Window_ID=2140900455;

select * from AD_TAB where  AD_Window_ID=2140900359;

select * from AD_TAB_TRL where  AD_TAB_ID in (select AD_Tab_ID from AD_TAB where  AD_Window_ID=2140900359);

select * from AD_Field where AD_Tab_ID IN (2140900935) and created>=trunc(sysdate);

select * from AD_Field_TRL where AD_FIELD_ID in (select AD_Field_ID from AD_Field where AD_Tab_ID IN (2140900935) and created>=trunc(sysdate));


select * from AD_Field where AD_Field_ID IN (2140930303,2140930304);
select * from AD_Field_TRL where AD_Field_ID IN (2140930303,2140930304);

select * from AD_Field where created>=trunc(sysdate);

select * from AD_Field_TRL where created>=trunc(sysdate);

*/

/*
select * from AD_ELEMENT where created>=trunc(sysdate) ORDER BY AD_ELEMENT_ID;

select * from AD_ELEMENT_TRL where created>=trunc(sysdate) AND AD_Language='ro_RO' ORDER BY AD_ELEMENT_ID;

select * from AD_ELEMENT where AD_Element_ID IN (2140901940);

select * from AD_ELEMENT_TRL where AD_Element_ID IN (2140901940);

select * from AD_Table where created>=trunc(sysdate);

select * from AD_Table_TRL where created>=trunc(sysdate);

select * from AD_Table where AD_TABLE_ID IN(2140901323);

select * from AD_Table_TRL where AD_TABLE_ID IN(2140901323);

select * from AD_Column where AD_Table_ID=2140901074 and created>=trunc(sysdate-1) order by AD_Column_ID;

select * from AD_Column_TRL where AD_Column_ID in (select AD_Column_ID from AD_Column where AD_Table_ID=2140901074 and AD_Language='ro_RO' and created>=trunc(sysdate-1))

select * from AD_Column where AD_Table_ID IN (2140901323);

select * from AD_Column_TRL where AD_Column_ID in (select AD_Column_ID from AD_Column where AD_Table_ID IN (2140901323)) and AD_Language='ro_RO';

select * from AD_Column where AD_Column_ID IN (9144);
select * from AD_Column_TRL where AD_Column_ID IN (9144);

select * from AD_Column where created>=trunc(sysdate);
select * from AD_Column_TRL where created>=trunc(sysdate);

select * from AD_Column where created>=trunc(sysdate-1) and created<trunc(sysdate);
select * from AD_Column_TRL where created>=trunc(sysdate-1) and created<trunc(sysdate);

select * from AD_TABLE where AD_Table_ID in (2140901787)

*/
/*
select * from AD_REFERENCE where created>=trunc(sysdate);

select * from AD_REFERENCE_TRL where created>=trunc(sysdate);

select * from AD_REFERENCE where AD_REFERENCE_ID=2140900326;

select * from AD_REFERENCE_TRL where AD_REFERENCE_ID=2140900326;

select * from AD_REF_LIST where AD_REFERENCE_ID IN (2140900326);

select * from AD_REF_LIST_TRL where AD_REF_LIST_ID IN (select AD_REF_LIST_ID from AD_REF_LIST where AD_REFERENCE_ID IN (2140900326)) and AD_Language='ro_RO';

select * from AD_REF_LIST where created>=trunc(sysdate);

select * from AD_REF_LIST_TRL where created>=trunc(sysdate);

select * from AD_REF_LIST where AD_REF_LIST_ID IN (2140900557);

select * from AD_REF_LIST_TRL where AD_REF_LIST_ID IN (2140900557);

select * from AD_REF_TABLE where created>=trunc(sysdate);

select * from AD_REF_TABLE where AD_Reference_ID=2140900204;

select * from AD_TableIndex where created>=trunc(sysdate);

select * from AD_IndexColumn where created>=trunc(sysdate);

select * from AD_TableIndex where AD_TableIndex_ID=2140900060;

select * from AD_IndexColumn where AD_TableIndex_ID IN (2140900082,2140900083,2140900085,2140900084);

*/

select * from AD_Process where created>=trunc(sysdate);

select * from AD_Process_TRL where created>=trunc(sysdate);

select * from AD_Process_Para where created>=trunc(sysdate);

select * from AD_Process_Para_TRL where created>=trunc(sysdate);

select * from AD_Process_Access where created>=trunc(sysdate);

/*
select * from AD_Process where AD_Process_ID IN (2140900843);

select * from AD_Process_TRL where AD_Process_ID IN (2140900843);

select * from AD_Process_Para where AD_Process_ID  IN (2140900843);

select * from AD_Process_Para_TRL where AD_PROCESS_PARA_ID in (select AD_PROCESS_PARA_ID from AD_Process_Para where AD_Process_ID  IN (2140900843)) and AD_LANGUAGE='ro_RO';

select * from AD_Process_Para where AD_Process_ID=2140900665 AND created>=trunc(sysdate);

select * from AD_Process_Para_TRL where AD_PROCESS_PARA_ID in (select AD_PROCESS_PARA_ID from AD_Process_Para where AD_Process_ID=2140900665 and created>=trunc(sysdate));

SELECT * FROM AD_Process_Para WHERE AD_PROCESS_PARA_ID IN (2140903975);

SELECT * FROM AD_Process_Para_TRL WHERE AD_PROCESS_PARA_ID IN (2140903975);

*/

select * from AD_Val_Rule where created>=trunc(sysdate); --AD_Val_Rule_ID=2140900190

select * from AD_Val_Rule where AD_Val_Rule_ID IN (2140900450);

select * FROM AD_Message where created>=trunc(sysdate); --updated>=trunc(sysdate);

select * FROM AD_Message_TRL where created>=trunc(sysdate); --updated>=trunc(sysdate);

select * FROM AD_Message where updated>=trunc(sysdate);

select * FROM AD_Message where AD_Message_ID in (2140901416,2140901415);

select * FROM AD_Message_TRL where AD_Message_ID in (2140901416,2140901415);

select * FROM AD_Message where updated>=trunc(sysdate);

select * FROM AD_Message_TRL where updated>=trunc(sysdate);

select * FROM AD_TREE where created>=trunc(sysdate);

select * FROM AD_MENU where created>=trunc(sysdate);

select * FROM AD_MENU_TRL where created>=trunc(sysdate);

select * FROM AD_TREENODEMM where created>=trunc(sysdate);

select * FROM AD_MENU where AD_MENU_ID=2140901151;

select * FROM AD_MENU_TRL where AD_MENU_ID=2140901151;

select * FROM AD_TREENODEMM where NODE_ID=2140901151;

select * from AD_PrintFormat where created>=trunc(sysdate);

select * from AD_PrintFormat_TRL where created>=trunc(sysdate);

select * from AD_PrintFormat where AD_PrintFormat_ID IN (2140900671);

select * from AD_PrintFormat_Trl where AD_PrintFormat_ID IN (2140900671);

select * from AD_PrintFormatItem where created>=trunc(sysdate);

select * from AD_PrintFormatItem_TRL where created>=trunc(sysdate);

select * from AD_PrintFormatItem where AD_PRINTFORMAT_ID =2140900577 AND created>=trunc(sysdate);

select * from AD_PrintFormatItem_TRL where AD_PrintFormatItem_ID IN (SELECT AD_PrintFormatItem_ID from AD_PrintFormatItem where AD_PRINTFORMAT_ID =2140900577 AND created>=trunc(sysdate));

select * from AD_PrintFormatItem where AD_PRINTFORMAT_ID IN (2140900671);

select * from AD_PrintFormatItem_TRL where AD_PrintFormatItem_ID IN (SELECT AD_PrintFormatItem_ID from AD_PrintFormatItem where AD_PRINTFORMAT_ID IN (2140900671)) AND AD_Language='ro_RO';

select * from AD_PrintFormatItem where AD_PrintFormatItem_ID =2140919852;

select * from AD_PrintFormatItem_TRL where AD_PrintFormatItem_ID =2140919852 AND AD_Language='ro_RO';

select * from AD_ReportView where created>=trunc(sysdate);

select * from AD_ReportView where AD_ReportView_ID=2140900230;


/* Import format */
select * from AD_ImpFormat where created>=trunc(sysdate);

select * from AD_ImpFormat_Row where AD_ImpFormat_ID in (Select AD_ImpFormat_ID FROM AD_ImpFormat where created>=trunc(sysdate));

select * from AD_ImpFormat_Row where AD_ImpFormat_ID = 2140900025;

/* Info Window */
select * from AD_InfoWindow where updated>=trunc(sysdate)

select * from AD_InfoWindow where AD_InfoWindow_ID=2140000024; --created>=trunc(sysdate);

select * from AD_InfoWindow_TRL where AD_InfoWindow_ID=2140000026; --created>=trunc(sysdate);

select * from AD_InfoColumn where AD_InfoWindow_ID=2140000026;

select * from AD_InfoColumn_TRL where AD_InfoColumn_ID IN (SELECT AD_InfoColumn_ID FROM AD_InfoColumn WHERE AD_InfoWindow_ID=2140000026);

select * from AD_InfoColumn where created>=trunc(sysdate);

select * from AD_InfoColumn_TRL where AD_InfoColumn_ID IN (SELECT AD_InfoColumn_ID FROM AD_InfoColumn WHERE created>=trunc(sysdate));

select * from AD_InfoColumn where AD_InfoWindow_ID=2140000699;

select * from AD_InfoColumn_TRL where AD_InfoColumn_ID IN (SELECT AD_InfoColumn_ID FROM AD_InfoColumn WHERE AD_InfoWindow_ID=2140000699);

select SELECTCLAUSE from AD_InfoColumn where AD_InfoColumn_ID IN (2140000699);
select * from AD_InfoColumn_TRL where AD_InfoColumn_ID IN (2140000699);


/* Form */
select * from AD_Form where created>=trunc(sysdate);

select * from AD_Form_TRL where created>=trunc(sysdate);

select * from AD_Form where AD_Form_ID=2140900029;

select * from AD_Form_TRL where AD_Form_ID=2140900029;


select * from CAPI_Method WHERE created>=trunc(sysdate);

select * from CAPI_Method WHERE CAPI_Method_ID IN ();

select * from CAPI_Method WHERE lower(name) like '%expense_report%';


/*
Changes

select * from AD_InfoColumn where updated>=trunc(sysdate)
select * from AD_InfoColumn_Trl where updated>=trunc(sysdate)
*/

select * FROM AD_Message where Value like 'MSTR%'; 

select * FROM AD_Message_TRL where AD_Message_ID IN (select AD_Message_ID FROM AD_Message where Value like 'MSTR%');

select * from AD_FieldGroup where created>=trunc(sysdate);
select * from AD_FieldGroup_TRL where created>=trunc(sysdate);

select * from AD_Workflow where AD_Workflow_ID = 2140900019;
select * from AD_Workflow_TRL where AD_Workflow_ID = 2140900019;

select * from AD_WF_Node where AD_Workflow_ID = 2140900017;
select * from AD_WF_Node_trl where AD_WF_Node_ID IN (SELECT AD_WF_Node_ID FROM AD_WF_Node WHERE AD_Workflow_ID=2140900017);

select * from AD_WF_NodeNext where AD_WF_Node_ID in (2140900069,2140900070);

select * from AD_Window_Access where AD_Role_ID=1000002 AND AD_Window_ID=2140900280;



/*
--shift all fields below "Period" field so that it will be room for new FamilyType, ProductFamily, Category, Subcategory fields
UPDATE AD_Field SET SeqNo = SeqNo + 40 
WHERE AD_Tab_ID=654
  AND IsDisplayed = 'Y'
  AND SeqNo > (SELECT SeqNo FROM AD_Field WHERE AD_FIELD_ID=10303)
  
--shift all params of process with p_AD_Process_ID starting with the one having p_FromSeqNo using p_SeqIncrement
DECLARE p_AD_Process_ID int := 2140900451;
  p_FromSeqNo int := 10;
  p_SeqIncrement int := 20;
BEGIN
  DECLARE cursor c is
  SELECT AD_Process_Para_ID
  FROM AD_Process_Para
  WHERE AD_Process_ID=p_AD_Process_ID
    AND SeqNo >= p_FromSeqNo
  ORDER BY SeqNo Desc;
  BEGIN
    FOR c_rec in c
    LOOP
      Update AD_Process_Para 
      Set SeqNo = SeqNo + p_SeqIncrement
      Where
        AD_Process_Para_ID = c_rec.AD_Process_Para_ID;

    END LOOP;
  END;
END;

--Field order
SELECT SeqNo, AD_Field_ID FROM AD_Field where IsDisplayed='Y' AND AD_Tab_ID=2140901155;
*/
