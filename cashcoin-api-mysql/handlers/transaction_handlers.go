package handlers

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/models"
	"github.com/Dall06/cashcoin-api-mysql/repositories"
	"github.com/gorilla/mux"
)


func MakeTransactionHandler(w http.ResponseWriter, r *http.Request) {
	// Validate your token
	var validationStatus bool = ValidateTokenCookie(w, r)
	if validationStatus == false {
		fmt.Println("err token")
		RespondWithInternalServerError(validationStatus, w)
		return
	}
	// transaction from transactionDetail is created
	var transaction models.TransactionDetail
	// if error when decode
	err := json.NewDecoder(r.Body).Decode(&transaction)
	if err != nil {
		fmt.Println("err decode")
		fmt.Println(err)
		RespondWithInternalServerError(err, w)
		return
	}
	// Make transaction mysql consult
	_, err = repositories.MakeTransaction(transaction)
	// if err different from nil response error
	if err != nil {
		fmt.Println("err consult handler")
		RespondWithInternalServerError(err, w)
		return
	}
	RespondWithSuccess(true, w)
}

func FindUserTransactionsHandler(w http.ResponseWriter, r *http.Request) {
	codeString := mux.Vars(r)["code"]
	if codeString == "" {
		RespondWithBadRequest("Empty user code", w)
		return
	}
	// Get transactions of the specific user
	transaction, err := repositories.GetUserTransactions(codeString)
	if err != nil {
		RespondWithInternalServerError(err, w)
		return
	}
	RespondWithSuccess(transaction, w)
}