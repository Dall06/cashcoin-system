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
	"github.com/gorilla/mux"
	"github.com/patrickmn/go-cache"
)

const defaultExpirationCache time.Duration = 2
const cleanupInterval time.Duration = 3

type AccountHandler struct {
	accountInteractor *usecase.AccountInteractor
	responseHandler   *services.ResponseHandler
	jwtHandler        *middleware.JWTHandler
	loggerHandler     *services.LoggerHandler
	helper            *delivery.AccountHelper
	cache           *cache.Cache
}

func NewAccountHandler(ai *usecase.AccountInteractor) *AccountHandler {
	return &AccountHandler{
		accountInteractor: ai,
		responseHandler:   services.NewResponseHandler(),
		jwtHandler:        middleware.NewJWTHandler(),
		loggerHandler:     services.NewLoggerHandler(),
		helper:            delivery.NewHandlerHelper(),
		cache: cache.New(defaultExpirationCache, cleanupInterval),
	}
}

func (ah *AccountHandler) Create(w http.ResponseWriter, r *http.Request) {
	toSave, err := ah.helper.ValidatePOSTNewAccountRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.accountInteractor.Save(toSave)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.responseHandler.RespondWithSuccess(res, w)
	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
}

func (ah *AccountHandler) ChangeStatus(w http.ResponseWriter, r *http.Request) {
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

	response, err := ah.accountInteractor.ChangeStatus(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(response, w)
}

func (ah *AccountHandler) ChangeAccount(w http.ResponseWriter, r *http.Request) {
	v, err := ah.jwtHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		print("nvt")
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}
	if !v {
		print("nv")
		ah.responseHandler.RespondWithUnauthorized(err, w)
		ah.loggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	a, ne, np, err := ah.helper.ValidatePUTAccountRequest(r)
	if err != nil {
		print("br")
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.accountInteractor.Change(a, ne, np)
	if err != nil {
		print("esql")
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}

func (ah *AccountHandler) ChangeAddress(w http.ResponseWriter, r *http.Request) {
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

	res, err := ah.accountInteractor.ChangeAddress(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}

func (ah *AccountHandler) ChangePassword(w http.ResponseWriter, r *http.Request) {
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

	response, err := ah.accountInteractor.ChangePassword(a, pass)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(response, w)
}

func (ah *AccountHandler) ChangePersonal(w http.ResponseWriter, r *http.Request) {
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

	res, err := ah.accountInteractor.ChangeClient(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}

func (ah *AccountHandler) Index(w http.ResponseWriter, r *http.Request) {
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

	var params = mux.Vars(r)
	var uuid = params["uuid"]
	if uuid == "" {
		ah.loggerHandler.LogError("%s", "empty uuid: " + uuid)
		ah.responseHandler.RespondWithInternalServerError("empty uuid: " + uuid, w)
		return
	}

	key := fmt.Sprintf("acc=auuid%s", uuid)
	if item, found := ah.cache.Get(key); found {
		res := item.(account.Account)
		ah.loggerHandler.LogAccess("%s %s %s \n", r.RemoteAddr, r.Method, r.URL)
		ah.responseHandler.RespondWithSuccess(res, w)
		return
	}

	a, err := ah.accountInteractor.Index(uuid)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.helper.ValidateSelectResponse(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	ah.responseHandler.RespondWithSuccess(res, w)
}
