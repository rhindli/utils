select * from AD_Column where ReadOnlyLogic like '%AND%';
select * from AD_Tab where ReadOnlyLogic like '%AND%';
select * from AD_UserDef_Tab where ReadOnlyLogic like '%AND%';
select * from AD_Process_Para where ReadOnlyLogic like '%AND%';
select * from SWEB_NewRecordField where ReadOnlyLogic like '%AND%';

select * from AD_Column where MandatoryLogic like '%AND%';
select * from AD_Process_Para where MandatoryLogic like '%AND%';

select * from AD_Tab where DisplayLogic like '%AND%';
select * from AD_UserDef_Tab where DisplayLogic like '%AND%';
select * from AD_Field where DisplayLogic like '%AND%';
select * from AD_UserDef_Field where DisplayLogic like '%AND%';
select * from AD_Process_Para where DisplayLogic like '%AND%';
select * from AD_Attribute where DisplayLogic like '%AND%';
select * from SWEB_NewRecordField where DisplayLogic like '%AND%';

select * from AD_Column where ColumnSql like '%@Created@=@Updated@%';

select * from AD_ReportView where WHERECLAUSE like '%@Created@=@Updated@%';

select * from AD_Workflow where DocValueLogic like '%AND%';

select * from AD_Val_Rule where CODE like '%@Created@=@Updated@%';

select * from AD_Tab where WHERECLAUSE like '%@Created@=@Updated@%';

select * from AD_Ref_Table where WHERECLAUSE like '%@Created@=@Updated@%';

