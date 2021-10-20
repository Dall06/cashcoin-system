package queries

const SPInsertAccount string = "CALL `cashcoin`.`sp_insert_account`(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
const SPUpdateStatus string = "CALL `cashcoin`.`sp_update_astatus`(?, ?, ?);"
const SPUpdateAccount string = "CALL `cashcoin`.`sp_update_account`(?, ?, ?, ?, ?);"
const SPUpdateAddress string = "CALL `cashcoin`.`sp_update_address`(?, ?, ?, ?, ?, ?, ?, ?);"
const SPUpdatePassword string = "CALL `cashcoin`.`sp_update_password`(?, ?, ?, ?);"
const SPUpdateClient string = "CALL `cashcoin`.`sp_update_client`(?, ?, ?, ?, ?);"
const SPSelectAccount string = "CALL `cashcoin`.`sp_select_account`(?, ?);"
