package handler

import (
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/middleware"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/delivery"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/usecase"
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
	}
	if !v {
		th.ResponseHandler.RespondWithUnauthorized(err, w)
		th.LoggerHandler.LogError("%s NO VALIDATED", err)
	}

	t, m, err := th.HandlerHelper.ValidatePOSTRequest(r)
	if err != nil {
		th.LoggerHandler.LogError("%s", err)
		th.ResponseHandler.RespondWithInternalServerError(err, w)
	}

	res, err := th.TxnInteractor.Do(t, m)
	if err != nil {
		th.LoggerHandler.LogError("%s", err)
		th.ResponseHandler.RespondWithInternalServerError(err, w)
	}

	th.LoggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	th.ResponseHandler.RespondWithSuccess(res, w)
}

func (th *TxnHandler) IndexTxns(w http.ResponseWriter, r *http.Request) {
	v, err := th.JWTHandler.ValidateAuthTokenCookie(r)
	if err != nil {
		th.ResponseHandler.RespondWithInternalServerError(err, w)
		th.LoggerHandler.LogError("%s", err)
	}
	if !v {
		th.ResponseHandler.RespondWithUnauthorized(err, w)
		th.LoggerHandler.LogError("%s NO VALIDATED", err)
	}

	a, err := th.HandlerHelper.ValidateGETRequest(r)
	if err != nil {
		th.LoggerHandler.LogError("%s", err)
		th.ResponseHandler.RespondWithInternalServerError(err, w)
	}

	res, err := th.TxnInteractor.Index(a)

	if err != nil {
		th.LoggerHandler.LogError("%s", err)
		th.ResponseHandler.RespondWithInternalServerError(err, w)
	}

	th.LoggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	th.ResponseHandler.RespondWithSuccess(res, w)
}