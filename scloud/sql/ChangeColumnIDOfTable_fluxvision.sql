ALTER TABLE AD_Column Disable Constraint FK101_2608;
ALTER TABLE AD_Element_Trl Disable Constraint FK277_2637;
ALTER TABLE AD_Column_Trl Disable Constraint FK752_12955;
ALTER TABLE AD_Field Disable Constraint FK107_174;


Update AD_Element SET AD_Element_ID=2140905764 where AD_Element_ID=900092;
Update AD_Element_Trl SET AD_Element_ID=2140905764 where AD_Element_ID=900092;
Update AD_Column SET AD_Element_ID=2140905764 WHERE AD_Element_ID=900092;


Update AD_Column SET AD_Column_ID=2140937445 WHERE AD_Column_ID=900220;
Update AD_Column_Trl SET AD_Column_ID=2140937445 WHERE AD_Column_ID=900220;
Update AD_Field Set AD_Column_ID=2140937445 Where AD_Column_ID=900220;

--change column ID in AD_Column audit
update AD_ChangeLog SET Record_ID=2140937445 where AD_Table_ID=101 and Record_Id=900220;


  
ALTER TABLE AD_Column Enable Constraint FK101_2608;
ALTER TABLE AD_Element_Trl Enable Constraint FK277_2637;
ALTER TABLE AD_Column_Trl Enable Constraint FK752_12955;
ALTER TABLE AD_Field Enable Constraint FK107_174;

