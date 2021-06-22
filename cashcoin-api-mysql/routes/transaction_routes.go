package routes

import (
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/handlers"
	"github.com/Dall06/cashcoin-api-mysql/middleware"
	"github.com/gorilla/mux"
)

func SetTransactionRoutes(router *mux.Router) {
	middleware.EnableCORS(router)
	subRoute := router.PathPrefix("/api/transaction").Subrouter()
	subRoute.HandleFunc("/find_user_t/{code}", handlers.FindUserTransactionsHandler).Methods(http.MethodGet)
	subRoute.HandleFunc("/make_t", handlers.MakeTransactionHandler).Methods(http.MethodPost)
}