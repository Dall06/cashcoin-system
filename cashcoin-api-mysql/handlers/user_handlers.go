package handlers

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/models"
	"github.com/Dall06/cashcoin-api-mysql/repositories"

	// "github.com/Dall06/cashcoin-api-mysql/utils"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)


func FindUserByEmailHandler(w http.ResponseWriter, r *http.Request) {
	email := mux.Vars(r)["email"]
	user, err := repositories.GetUserByEmail(email)
	if err != nil {
		RespondWithInternalServerError(err, w)
		return
	}
	RespondWithSuccess(user, w)
}

func SaveUserHandler(w http.ResponseWriter, r *http.Request) {
	var user models.UserData
	// decode json
	err := json.NewDecoder(r.Body).Decode(&user)
	if err != nil {
		RespondWithInternalServerError(err, w)
		return
	}
	// Generating code and hash password
	uuidCode := uuid.New().String()
	if uuidCode == "" {
		RespondWithInternalServerError("uuid error", w)
	}
	if err != nil {
		RespondWithInternalServerError("Error whn hashing password", w)
	}
	user.Code = uuidCode
	// consult
	result, err := repositories.CreateUser(user)
	if err != nil {
		fmt.Println("Error consult")
		RespondWithInternalServerError(err, w)
		return
	}
	RespondWithSuccess(result, w)
}

func EditUserHandler(w http.ResponseWriter, r *http.Request) {
	email := mux.Vars(r)["email"]
	var validationStatus bool = ValidateTokenCookie(w, r)
	if validationStatus == false {
		RespondWithInternalServerError(validationStatus, w)
		return
	}
	var user models.UserData

	err := json.NewDecoder(r.Body).Decode(&user)
	if err != nil {
		RespondWithInternalServerError(err, w)
		return
	}
	if user.UserAccount.Email == "" {
		RespondWithBadRequest("Email", w)
	}

	result, err := repositories.UpdateUser(email, user)
	if err != nil {
		RespondWithInternalServerError(err, w)
		return
	}
	RespondWithSuccess(result, w)
}

func EditUserPassHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Update pass")
	var validationStatus bool = ValidateTokenCookie(w, r)
	if validationStatus == false {
		fmt.Println("Err Token")
		RespondWithInternalServerError(validationStatus, w)
		return
	}
	var user models.UserPassUpdate

	err := json.NewDecoder(r.Body).Decode(&user)
	if err != nil {
		fmt.Println(err)
		RespondWithInternalServerError(err, w)
		return
	}

	result, err := repositories.UpdateUserPassword(user)
	if err != nil {
		fmt.Println("Err Consult")
		RespondWithInternalServerError(err, w)
		return
	}
	RespondWithSuccess(result, w)
}
