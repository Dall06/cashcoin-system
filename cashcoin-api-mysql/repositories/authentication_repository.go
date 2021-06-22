package repositories

import (
	"github.com/Dall06/cashcoin-api-mysql/database"
	"github.com/Dall06/cashcoin-api-mysql/models"
)


func AuthenticateCredentials(user models.UserAccount) (bool, error) {
	var returnedValue bool
	dbConnection, err := database.OpenConnection()
	if err != nil {
		return false, err
	}
	defer func() {
		dbConnection.Close()
	}()
	row := dbConnection.QueryRow("SELECT db_cashcoin.fn_athenticate_credentials(?, ?);", user.Email, user.Password)
	err = row.Scan(&returnedValue)
	
	if err != nil {
		return returnedValue, err
	}
	return returnedValue, nil
}