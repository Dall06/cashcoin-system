package repositories

import (
	"database/sql"
	"fmt"

	"github.com/Dall06/cashcoin-api-mysql/database"
	"github.com/Dall06/cashcoin-api-mysql/models"
)

func GetUserTransactions(codeUser string) ([]models.TransactionUser, error) {
	var transactions []models.TransactionUser
	// open dbConnection
	dbConnection, err := database.OpenConnection()
	// if error when connection created
	if err != nil {
		fmt.Println("Connection err db")
		return nil, err
	}
	// defern func taht waits until dbConnectionQuery finishes
	defer func() {
		fmt.Println("Closed")
		dbConnection.Close()
	}()
	// Query and assigning values to object that is toraged into an array
	rows, err := dbConnection.Query("CALL `db_cashcoin`.`sp_select_transactionuser_by_code`(?);", codeUser)
	// if error when query exectued
	if err != nil {
		fmt.Println(err)
		return nil, err
	}
	// While rows contain unreaded value, it gives the value to transaction object and append to a list
	for rows.Next() {
		var transaction models.TransactionUser
		err := rows.Scan(
			&transaction.TransactionUserType,
			&transaction.TransactionDetail.Destination.Code,
			&transaction.TransactionDetail.Origin.Code,
			&transaction.TransactionDetail.Concept,
			&transaction.TransactionDetail.Order.Quantity,
			&transaction.TransactionDetail.Order.Date,
			&transaction.TransactionDetail.Order.TransactionType.TypeDescription,
		)
		// if error while scan, breaks
		if err != nil {
			fmt.Println(err)
			return transactions, err
		}
		transactions = append(transactions, transaction)
	}
	return transactions, nil
}

func MakeTransaction(transaction models.TransactionDetail) (sql.Result, error) {
	// open db connection, if error exists breaks
	fmt.Println("Hello make transaction!")
	dbConnection, err := database.OpenConnection()
	if err != nil {
		return nil, err
	}
	// defer function taht waits until query finish executing
	defer func() {
		dbConnection.Close()
	}()
	fmt.Println(transaction)
	// query
	result, err := dbConnection.Exec("CALL `db_cashcoin`.`sp_make_transaction`(?, ?, ?, ?, ?);",
		transaction.Order.Quantity,
		transaction.Order.TransactionType.ID,
		transaction.Concept,
		transaction.Destination.Code,
		transaction.Origin.Code)
	// if error exist in query, breaks
	if err != nil {
		return nil, err
	}
	return result, nil
}
