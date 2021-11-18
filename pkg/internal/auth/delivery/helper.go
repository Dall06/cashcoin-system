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

func (ah *AuthHelper) ValidateAuthRequest(r *http.Request) (*auth.Account, error) {
	var get Request
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

func (ah *AuthHelper) ValidateAuthResponse(a *auth.Account) (*Account, error) {
	res := &Account{
		UUID:    a.UUID,
		Email:   a.Email,
		Phone:   a.Phone,
		Balance: a.Balance,
		Status:  a.Status,
		Clabe:   a.Clabe,
		Address:  address {
			City:    a.Address.City,
			Estate:   a.Address.Estate,
			Country: a.Address.Country,
		},
		Client: client {
			Name:     a.Client.Name,
			LastName: a.Client.LastName,
		},
	}

	err := ah.Validator.Struct(res)
	if err != nil {
		return nil, err
	}

	return res, err
}
