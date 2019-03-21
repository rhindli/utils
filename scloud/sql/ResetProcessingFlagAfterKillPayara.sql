select * from C_AcctProcessor where Processing='Y' order by DateLastRun desc;

select * from C_AcctProcessorLog where C_AcctProcessor_ID=1008412 order by created desc;

Update C_AcctProcessor set Processing='N' where C_AcctProcessor_ID=1008412 and Processing='Y';



select * from AD_AlertProcessor where Processing='Y' order by DateLastRun desc;



select * from R_RequestProcessor where Processing='Y' order by DateLastRun desc;



select * from AD_WorkflowProcessor where Processing='Y' order by DateLastRun desc;



select * from AD_Scheduler where Processing='Y' order by DateLastRun desc;



select * from AD_PInstance where IsProcessing='Y' order by Created desc;

select * from AD_Process where AD_Process_ID=2140900863;

update AD_PInstance set IsProcessing='N' where AD_PInstance_ID=15374799 and IsProcessing='Y';



select * from AD_Client where AD_Client_ID=1004662;