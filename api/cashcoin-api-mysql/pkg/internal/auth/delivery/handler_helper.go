package delivery

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth"
	"gopkg.in/go-playground/validator.v9"
)

type AuthHelper struct {
	Validator *validator.Validate
}

func NewAuthHelper() *AuthHelper {
	return &AuthHelper{
		Validator: validator.New(),
	}
}

func (ah *AuthHelper) ValidateGETAAuthRequest(r *http.Request) (*auth.Account, error) {
	var get GETAAuth
	var a auth.Account

	err := json.NewDecoder(r.Body).Decode(&get)
	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	err = ah.Validator.Struct(get)
	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	a = auth.Account{
		Email:    get.Email,
		Phone:    get.Phone,
		Password: get.Password,
	}

	return &a, nil
}
