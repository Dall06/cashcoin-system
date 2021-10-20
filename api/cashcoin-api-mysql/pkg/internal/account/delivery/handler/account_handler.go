package handler

import (
	"fmt"
	"net/http"
	"time"

	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/middleware"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/delivery"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/usecase"
	"github.com/patrickmn/go-cache"
)

const defaultExpirationCache time.Duration = 2
const cleanupInterval time.Duration = 3

type AccountHandler struct {
	AccountInteractor *usecase.AccountInteractor
	responseHandler   *services.ResponseHandler
	jwtHandler        *middleware.JWTHandler
	loggerHandler     *services.LoggerHandler
	helper            *delivery.HandlerHelper
	cache           *cache.Cache
}

func NewAccountHandler(ai *usecase.AccountInteractor) *AccountHandler {
	return &AccountHandler{
		AccountInteractor: ai,
		responseHandler:   services.NewResponseHandler(),
		jwtHandler:        middleware.NewJWTHandler(),
		loggerHandler:     services.NewLoggerHandler(),
		helper:            delivery.NewHandlerHelper(),
		cache: cache.New(defaultExpirationCache, cleanupInterval),
	}
}

func (ah *AccountHandler) POSTNewAccount(w http.ResponseWriter, r *http.Request) {
	toSave, err := ah.helper.ValidatePOSTNewAccountRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.AccountInteractor.Save(toSave)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.responseHandler.RespondWithSuccess(res, w)
	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
}

func (ah *AccountHandler) PUTStatus(w http.ResponseWriter, r *http.Request) {
	v, err := ah.jwtHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}
	if !v {
		ah.responseHandler.RespondWithUnauthorized(err, w)
		ah.loggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	a, err := ah.helper.ValidatePUTStatusRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	response, err := ah.AccountInteractor.ChangeStatus(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(response, w)
}

func (ah *AccountHandler) PUTAccount(w http.ResponseWriter, r *http.Request) {
	v, err := ah.jwtHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}
	if !v {
		ah.responseHandler.RespondWithUnauthorized(err, w)
		ah.loggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	a, ne, np, err := ah.helper.ValidatePUTAccountRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.AccountInteractor.Change(a, ne, np)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}

func (ah *AccountHandler) PUTAddress(w http.ResponseWriter, r *http.Request) {
	v, err := ah.jwtHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}
	if !v {
		ah.responseHandler.RespondWithUnauthorized(err, w)
		ah.loggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	a, err := ah.helper.ValidatePUTAddressRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.AccountInteractor.ChangeAddress(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}

func (ah *AccountHandler) PUTPass(w http.ResponseWriter, r *http.Request) {
	validated, err := ah.jwtHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}
	if !validated {
		ah.responseHandler.RespondWithUnauthorized(err, w)
		ah.loggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	a, pass, err := ah.helper.ValidatePUTPasswordRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	response, err := ah.AccountInteractor.ChangePassword(a, pass)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(response, w)
}

func (ah *AccountHandler) PUTClient(w http.ResponseWriter, r *http.Request) {
	v, err := ah.jwtHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}
	if !v {
		ah.responseHandler.RespondWithUnauthorized(err, w)
		ah.loggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	a, err := ah.helper.ValidatePUTClientRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.AccountInteractor.ChangeClient(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}

func (ah *AccountHandler) GETAccount(w http.ResponseWriter, r *http.Request) {
	v, err := ah.jwtHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}
	if !v {
		ah.responseHandler.RespondWithUnauthorized(err, w)
		ah.loggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	rreq, err := ah.helper.ValidateGETAccountRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	key := fmt.Sprintf("acc=email:auuid%s,%s", rreq.Email, rreq.UUID)
	if item, found := ah.cache.Get(key); found {
		res := item.(account.Account)
		ah.loggerHandler.LogAccess("%s %s %s \n", r.RemoteAddr, r.Method, r.URL)
		ah.responseHandler.RespondWithSuccess(res, w)
		return
	}

	res, err := ah.AccountInteractor.Index(rreq)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}
