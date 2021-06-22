package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/models"
	"github.com/Dall06/cashcoin-api-mysql/repositories"
)


func LoginHandler(w http.ResponseWriter, r *http.Request) {
	var user models.UserAccount
	err := json.NewDecoder(r.Body).Decode(&user)
	if err != nil {
		RespondWithInternalServerError(err, w)
		return
	}
	result, err := repositories.AuthenticateCredentials(user)
	if err != nil || result == false {
		RespondWithNonAuthorized(err, w)
		return
	}
	SetTokenCookie(user, w)
	RespondWithSuccess(true, w)
}

func LogoutHandler(w http.ResponseWriter, r *http.Request) {
	// var user models.UserAccount
	//err := json.NewDecoder(r.Body).Decode(&user)
	// if err != nil {
	// 	RespondWithInternalServerError(err, w)
	// 	return
	// }
	// result, err := repositories.AuthenticateCredentials(user)
	// if err != nil {
	// 	RespondWithNonAuthorized(err, w)
	// 	return
	// }
	CleanTokenCookie(w)
	RespondWithSuccess(true, w)
}