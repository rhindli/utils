update sc_webmodule set hostaddress='socrate-test.socratecloud.com';
update sc_webmodule_param set isactive='N';
update R_RequestProcessor set isactive = 'N';
update AD_AlertProcessor set isactive = 'N';
update AD_Scheduler set isactive = 'N';
update ad_user set notificationtype = 'X' where notificationtype<>'X';