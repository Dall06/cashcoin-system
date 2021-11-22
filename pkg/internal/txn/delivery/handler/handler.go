package handler

import (
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/middleware"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/delivery"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/usecase"
	"github.com/gorilla/mux"
)

type TxnHandler struct {
	TxnInteractor *usecase.TxnInteractor
	ResponseHandler   *services.ResponseHandler
	JWTHandler        *middleware.JWTHandler
	LoggerHandler     *services.LoggerHandler
	HandlerHelper     *delivery.HandlerHelper
}

func NewTxnHandler(ti *usecase.TxnInteractor) *TxnHandler {
	return &TxnHandler{
		TxnInteractor: ti,
		ResponseHandler:   services.NewResponseHandler(),
		JWTHandler:        middleware.NewJWTHandler(),
		LoggerHandler:     services.NewLoggerHandler(),
		HandlerHelper:     delivery.NewHandlerHelper(),
	}
}

func (th *TxnHandler) Make(w http.ResponseWriter, r *http.Request) {
	v, err := th.JWTHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		th.ResponseHandler.RespondWithInternalServerError(err, w)
		th.LoggerHandler.LogError("%s", err)
		return
	}
	if !v {
		th.ResponseHandler.RespondWithUnauthorized(err, w)
		th.LoggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	t, m, err := th.HandlerHelper.ValidatePOSTRequest(r)
	if err != nil {
		th.LoggerHandler.LogError("%s", err)
		th.ResponseHandler.RespondWithInternalServerError(err, w)
		return
	}

	res, err := th.TxnInteractor.Do(t, m)
	if err != nil {
		th.LoggerHandler.LogError("%s", err)
		th.ResponseHandler.RespondWithInternalServerError(err, w)
		return
	}

	th.LoggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	th.ResponseHandler.RespondWithSuccess(res, w)
}

func (th *TxnHandler) IndexTxns(w http.ResponseWriter, r *http.Request) {
	v, err := th.JWTHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		th.ResponseHandler.RespondWithInternalServerError(err, w)
		th.LoggerHandler.LogError("%s", err)
		return
	}
	if !v {
		th.ResponseHandler.RespondWithUnauthorized(err, w)
		th.LoggerHandler.LogError("%s NO VALIDATED", err)
		return
	}

	var params = mux.Vars(r)
	var uuid = params["uuid"]
	if uuid == "" {
		th.LoggerHandler.LogError("%s", "empty uuid: " + uuid)
		th.ResponseHandler.RespondWithInternalServerError("empty uuid: " + uuid, w)
		return
	}

	res, err := th.TxnInteractor.Index(uuid)

	if err != nil {
		th.LoggerHandler.LogError("%s", err)
		th.ResponseHandler.RespondWithInternalServerError(err, w)
		return
	}

	th.LoggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	th.ResponseHandler.RespondWithSuccess(res, w)
}