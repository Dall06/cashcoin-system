package delivery

import (
	"encoding/json"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
	"github.com/Dall06/cashcoin-api-mysql/pkg/utils"
	"gopkg.in/go-playground/validator.v9"
)

type HandlerHelper struct {
	Validator *validator.Validate
}

func NewHandlerHelper() *HandlerHelper {
	return &HandlerHelper{
		Validator: validator.New(),
	}
}

func (hh *HandlerHelper) ValidatePOSTNewAccountRequest(r *http.Request) (*account.Account, error) {
	var post POSTNewAccount
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&post)
	if err != nil {
		return &a, err
	}

	err = hh.Validator.Struct(post)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		UUID:     utils.CheckAndReturn(post.UUID),
		Email:    post.Email,
		Phone:    post.Phone,
		Password: post.Password,
		Clabe: utils.GenerateClabe(post.Clabe),
		Client: account.Client{
			UUID:     utils.CheckAndReturn(post.CUUID),
			Name:     post.Name,
			LastName: post.LastName,
			Occupation: post.Occupation,
		},
		Address: account.Address{
			UUID: utils.CheckAndReturn(post.ADDUUID),
			City: post.City,
			State: post.State,
			Street: post.Street,
			BuldingNumber: post.BuldingNumber,
			Country: post.Country,
			PostalCode: post.PostalCode,
		},
	}

	return &a, nil
}

func (hh *HandlerHelper) ValidatePUTStatusRequest(r *http.Request) (*account.Account, error) {
	var put PUTStatus
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, err
	}

	err = hh.Validator.Struct(&a)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		Email: put.Email,
		Phone: put.Phone,
		Status: put.Status,
	}

	return &a, err
}

func (hh *HandlerHelper) ValidatePUTAccountRequest(r *http.Request) (*account.Account, string, string, error) {
	var put PUTAccount
	var a account.Account
	var e string
	var p string

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, e, p, err
	}

	err = hh.Validator.Struct(&put)
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

func (hh *HandlerHelper) ValidatePUTPasswordRequest(r *http.Request) (*account.Account, string, error) {
	var put PUTPassword
	var a account.Account
	var p string

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, p, err
	}

	err = hh.Validator.Struct(&put)
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

func (hh *HandlerHelper) ValidatePUTAddressRequest(r *http.Request) (*account.Account, error) {
	var put PUTAddress
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, err
	}

	err = hh.Validator.Struct(&put)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		Email:    put.Email,
		Phone:    put.Phone,
		Address: account.Address{
			City: put.City,
			State: put.State,
			Street: put.Street,
			BuldingNumber: put.BuldingNumber,
			Country: put.Country,
			PostalCode: put.PostalCode,
		},
	}

	return &a, err
}

func (hh *HandlerHelper) ValidatePUTClientRequest(r *http.Request) (*account.Account, error) {
	var put PUTClient
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&put)
	if err != nil {
		return &a, err
	}

	err = hh.Validator.Struct(&put)
	if err != nil {
		return &a, err
	}

	a = account.Account{
		Email: put.Email,
		Phone: put.Phone,
		Client: account.Client{
			Name:     put.Name,
			LastName: put.LastName,
			Occupation: put.Occupation,
		},
	}
	return &a, err
}

func (hh *HandlerHelper) ValidateGETAccountRequest(r *http.Request) (*account.Account, error) {
	var get GETAccount
	var a account.Account

	err := json.NewDecoder(r.Body).Decode(&get)
	if err != nil {
		return &a, nil
	}

	a = account.Account{
		Email: get.Email,
		Phone: get.Phone,
	}

	return &a, nil
}
