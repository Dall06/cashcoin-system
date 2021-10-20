call cashcoin.sp_insert_account('5f2b9fb0-2720-4b13-b879-441db4577a06', 'aa3a2202-b141-432a-8779-75da8cc146a7', '44e07ff1-a9a0-4c20-a039-9858cfb06f9f', '123456789ASDFGHJKL', 'test@test.com', '47788888888', 'Test123', 'Leon', 'Gto', 'Av Universidad', 289, '48000', 'Mex', 'Test', 'Test', 'Tester');
call cashcoin.sp_auth('test@test.com', '', 'Test123');
call cashcoin.sp_auth('', '47788888888', 'Test123');
call cashcoin.sp_select_user('test@test.com', '');
call cashcoin.sp_select_user('', '47788888888');
call cashcoin.sp_update_account('', 'test1@test.com', '47788888888', '', 'Test123');
call cashcoin.sp_update_account('test1@test.com', '', '', '47788888887', 'Test123');
call cashcoin.sp_update_account('test1@test.com', 'test@test.com', '47788888887', '47788888888', 'Test123');
call cashcoin.sp_update_account('test@test.com', 'test1@test.com', '47788888888', '', 'Test123');
call cashcoin.sp_update_account('test1@test.com', '', '47788888888', '47788888887', 'Test123');
call cashcoin.sp_update_address('test1@test.com', '', 'City1', 'State1', 'Street1', 11, 'US', '36001');
call cashcoin.sp_update_address('test1@test.com', '47788888887', 'City', 'State', 'Street', 1, 'MEX', '36000');
call cashcoin.sp_update_address('', '47788888887', 'City1', 'State1', 'Street1', 11, 'US', '36000');
call cashcoin.sp_update_client('test1@test.com', '', 'fname', 'lname', 'occupation');
call cashcoin.sp_update_client('test1@test.com', '47788888887', 'F', 'L', 'O');
call cashcoin.sp_update_client('', '47788888887', 'fname', 'lname', 'occupation');
call cashcoin.sp_update_password('test1@test.com', '', 'Test123', 'Test1234');
call cashcoin.sp_update_password('test1@test.com', '47788888887', 'Test1234', '1223213ewewA');
call cashcoin.sp_update_password('', '47788888887', '1223213ewewA', 'Test123');
call cashcoin.sp_update_astatus('test1@test.com', '', 'DISABLED');
call cashcoin.sp_update_astatus('test1@test.com', '47788888887', 'ACTIVE');
call cashcoin.sp_update_astatus('', '47788888887', 'DISABLED');
call cashcoin.sp_update_astatus('test1@test.com', '', 'ACTIVE');
call cashcoin.sp_insert_account('4df86514-79c2-41c7-812c-57687c7d4593', '8e694b7a-b05d-45d1-8c8e-c2034f3dee3b', 'ccee21c4-48a4-49bc-9abd-4aa4ed5c0a00', '987654321ASDFGHJKL', 'test2@test.com', '477999999999', 'Test123', 'Leon', 'Gto', 'Av Universidad', 289, '48000', 'Mex', 'Test', 'Test', 'Tester');

UPDATE `cashcoin`.`accounts` SET `balance` = '1000' WHERE (`auuid` = '4df86514-79c2-41c7-812c-57687c7d4593');
UPDATE `cashcoin`.`accounts` SET `balance` = '1000' WHERE (`auuid` = '5f2b9fb0-2720-4b13-b879-441db4577a06');

CALL `cashcoin`.`sp_make_txn`(
'd9b4d17c-a698-4c86-bf59-37584268b3c7', 
'5e3c405c-67b2-44a7-85f4-9f66e20185b9', 
'cfdcd54d-8165-49af-ac38-c38c4d66c643',
'reftest',
'test1@test.com', 
'', 
'4df86514-79c2-41c7-812c-57687c7d4593', 
10,
'Concept', 
'Mex', 
'Gto', 
'Gto', 
100.2, 
-23.094);

CALL `cashcoin`.`sp_make_txn`(
'92e29404-753c-4b14-aa55-b180f6df7462', 
'1f399a44-2df4-4eba-9bbc-fec2485d3d7c', 
'de61bb2c-ce92-4523-a545-70c09ab25f5f',
'reftest2',
'', 
'477999999999', 
'5f2b9fb0-2720-4b13-b879-441db4577a06', 
10,
'Concept', 
'Mex', 
'Gto', 
'Gto', 
100.2, 
-23.094);

call cashcoin.sp_select_txns('test1@test.com', '');
call cashcoin.sp_select_txns('', '477999999999');
call cashcoin.sp_select_txns('test2@test.com', '477999999999');