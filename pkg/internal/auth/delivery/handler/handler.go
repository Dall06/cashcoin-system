package handler

import (
	"fmt"
	"net/http"
	"time"

	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/middleware"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/delivery"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/usecase"
	"github.com/patrickmn/go-cache"
)

const defaultExpirationCache time.Duration = 2
const cleanupInterval time.Duration = 3

type AuthHandler struct {
	AuthInteractor  *usecase.AuthInteractor
	responseHandler *services.ResponseHandler
	loggerHandler   *services.LoggerHandler
	jwtHandler      *middleware.JWTHandler
	authHelper      *delivery.AuthHelper
	cache           *cache.Cache
}

func NewAuthHandler(ai *usecase.AuthInteractor) *AuthHandler {
	return &AuthHandler{
		AuthInteractor:  ai,
		responseHandler: services.NewResponseHandler(),
		loggerHandler:   services.NewLoggerHandler(),
		authHelper:      delivery.NewAuthHelper(),
		cache: cache.New(defaultExpirationCache, cleanupInterval),
	}
}

func (ah *AuthHandler) Authenticate(w http.ResponseWriter, r *http.Request) {
	a, err := ah.authHelper.ValidateAuthRequest(r)
	if err != nil {
		ah.responseHandler.RespondWithBadRequest(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	ra, err := ah.AuthInteractor.Authenticate(a)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	res, err := ah.authHelper.ValidateAuthResponse(ra)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}

	key := fmt.Sprintf("acc=auuid%s", res.UUID)
	err = ah.cache.Add(key, res, defaultExpirationCache)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s", err)
		return
	}


	err = ah.jwtHandler.SetAuthTokenCookie(w, res.Email, res.Phone, res.UUID)
	if err != nil {
		ah.responseHandler.RespondWithInternalServerError(err, w)
		ah.loggerHandler.LogError("%s Cannot create token", err)
		return
	}

	ah.responseHandler.RespondWithSuccess(res, w)
	ah.loggerHandler.LogAccess("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
}
