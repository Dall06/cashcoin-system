package repositories

import (
	"database/sql"
	"fmt"

	"github.com/Dall06/cashcoin-api-mysql/database"
	"github.com/Dall06/cashcoin-api-mysql/models"
)

func GetUserByEmail(email string) (models.UserData, error) {
	var user models.UserData

	dbConnection, err := database.OpenConnection()
	if err != nil {
		return user, err
	}
	defer func() {
		dbConnection.Close()
	}()
	row := dbConnection.QueryRow("CALL `db_cashcoin`.`sp_select_user`(?);", email)
	err = row.Scan(
		&user.ID,
		&user.Name,
		&user.LastName,
		&user.Code,
		&user.Balance,
		&user.UserAccount.ID,
		&user.UserAccount.Email,
		&user.UserAccount.Phone)
	if err != nil {
		return user, err
	}

	return user, nil
}

func CreateUser(user models.UserData) (sql.Result, error) {
	fmt.Println("hi create")
	dbConnection, err := database.OpenConnection()
	if err != nil {
		return nil, err
	}
	defer func() {
		dbConnection.Close()
	}()
	result, err := dbConnection.Exec("CALL `db_cashcoin`.`sp_insert_user`(?, ?, ?,?, ?, ?);",
		user.UserAccount.Email,
		user.UserAccount.Password,
		user.UserAccount.Phone,
		user.Name,
		user.LastName,
		user.Code)
	return result, err
}

func UpdateUser(currentEmail string, user models.UserData) (sql.Result, error) {
	dbConnection, err := database.OpenConnection()
	if err != nil {
		return nil, err
	}
	defer func() {
		dbConnection.Close()
	}()
	result, err := dbConnection.Exec("CALL `db_cashcoin`.`sp_update_user`(?, ?, ?, ?, ?);",
		currentEmail,
		user.UserAccount.Email,
		user.UserAccount.Phone,
		user.Name,
		user.LastName)
	return result, err
}

func UpdateUserPassword(user models.UserPassUpdate) (sql.Result, error) {
	dbConnection, err := database.OpenConnection()
	if err != nil {
		return nil, err
	}
	defer func() {
		dbConnection.Close()
	}()
	result, err := dbConnection.Exec("CALL `db_cashcoin`.`sp_update_user_pass`(?, ?, ?);",
		user.UserAccount.Email,
		user.UserAccount.Password,
		user.NewPassword,)

	fmt.Println("Update pass finished")
	fmt.Println(result)
	fmt.Println(err)

	return result, err
}
