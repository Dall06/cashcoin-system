package delivery

import (
	"encoding/json"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
	"github.com/Dall06/cashcoin-api-mysql/pkg/utils"
	"gopkg.in/go-playground/validator.v9"
)

type AccountHelper struct {
	Validator *validator.Validate
}

func NewHandlerHelper() *AccountHelper {
	return &AccountHelper{
		Validator: validator.New(),
	}
}

func (ah *AccountHelper) ValidatePOSTNewAccountRequest(r *http.Request) (*account.Account, error) {
	var post ReqCreate
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&post)
	if err != nil {
		return &a, err
	}

	err = ah.Validator.Struct(post)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		UUID:     utils.CheckAndReturn(post.AUUID),
		Email:    post.Email,
		Phone:    post.Phone,
		Password: post.Password,
		Clabe:    utils.GenerateClabe(post.Clabe),
		Client: account.Client{
			UUID:       utils.CheckAndReturn(post.CUUID),
			Name:       post.Name,
			LastName:   post.LastName,
			Occupation: post.Occupation,
		},
		Address: account.Address{
			UUID:          utils.CheckAndReturn(post.ADDUUID),
			City:          post.City,
			Estate:        post.Estate,
			Street:        post.Street,
			BuldingNumber: post.BuldingNumber,
			Country:       post.Country,
			PostalCode:    post.PostalCode,
		},
	}

	return &a, nil
}

func (ah *AccountHelper) ValidatePUTStatusRequest(r *http.Request) (*account.Account, error) {
	var put ReqStatus
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, err
	}

	err = ah.Validator.Struct(&put)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		UUID:   put.AUUID,
		Status: put.Status,
	}

	return &a, err
}

func (ah *AccountHelper) ValidatePUTAccountRequest(r *http.Request) (*account.Account, string, string, error) {
	var put ReqAccount
	var a account.Account
	var e string
	var p string

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, e, p, err
	}

	err = ah.Validator.Struct(&put)
	if err != nil {
		return &a, e, p, err
	}

	a = account.Account{
		Email:    put.Email,
		Phone:    put.Phone,
		Password: put.Password,
	}
	e = put.NewEmail
	p = put.NewPhone

	return &a, e, p, err
}

func (ah *AccountHelper) ValidatePUTPasswordRequest(r *http.Request) (*account.Account, string, error) {
	var put ReqPassword
	var a account.Account
	var p string

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, p, err
	}

	err = ah.Validator.Struct(&put)
	if err != nil {
		return &a, p, err
	}

	a = account.Account{
		Email:    put.Email,
		Phone:    put.Phone,
		Password: put.Password,
	}
	p = put.NewPassword

	return &a, p, err
}

func (ah *AccountHelper) ValidatePUTAddressRequest(r *http.Request) (*account.Account, error) {
	var put ReqAddress
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, err
	}

	err = ah.Validator.Struct(&put)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		UUID: put.AUUID,
		Address: account.Address{
			City:          put.City,
			Estate:        put.Estate,
			Street:        put.Street,
			BuldingNumber: put.BuldingNumber,
			Country:       put.Country,
			PostalCode:    put.PostalCode,
		},
	}

	return &a, err
}

func (ah *AccountHelper) ValidatePUTClientRequest(r *http.Request) (*account.Account, error) {
	var put ReqPersonal
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, err
	}

	err = ah.Validator.Struct(&put)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		UUID: put.AUUID,
		Client: account.Client{
			Name:       put.Name,
			LastName:   put.LastName,
			Occupation: put.Occupation,
		},
	}
	return &a, err
}

func (ah *AccountHelper) ValidateSelectResponse(a *account.Account) (*Account, error) {
	res := &Account{
		UUID:      a.UUID,
		Email:     a.Email,
		Phone:     a.Phone,
		Balance:   a.Balance,
		Status:    a.Status,
		Clabe:     a.Clabe,
		LastLogAt: a.LastLogdAt,
		Address: address{
			City:    a.Address.City,
			Estate:  a.Address.Estate,
			Country: a.Address.Country,
		},
		Client: client{
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
