package routes

import (
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/handlers"
	"github.com/Dall06/cashcoin-api-mysql/middleware"
	"github.com/gorilla/mux"
)

func SetAuthRoutes(router *mux.Router) {
	middleware.EnableCORS(router)
	subRoute := router.PathPrefix("/api/auth").Subrouter()
	subRoute.HandleFunc("/login", handlers.LoginHandler).Methods(http.MethodPost)
	subRoute.HandleFunc("/logout", handlers.LogoutHandler).Methods(http.MethodPost)
	// subRoute.HandleFunc("/refresh_session", handlers.RefreshTokenCookie).Methods(http.MethodPost)
}