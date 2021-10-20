package routes

import (
	"database/sql"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/config"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/delivery/handler"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/usecase"
	"github.com/gorilla/mux"
)

type accountRoutes struct {
	router *mux.Router
	db     *sql.DB
}

func NewAccountRoutes(r *mux.Router, db *sql.DB) *accountRoutes {
	return &accountRoutes{
		router: r,
		db:     db,
	}
}

func (aroutes *accountRoutes) setAccountRoutes(ah *handler.AccountHandler) {
	var pathPrefix_v1 string = config.RouterBasePath_V1 + "/account"

	subRoute := aroutes.router.PathPrefix(pathPrefix_v1).Subrouter()

	subRoute.HandleFunc("/welcome", func(rw http.ResponseWriter, r *http.Request) {
		services.NewResponseHandler().RespondWithSuccess("welcome to account routes", rw)
	}).Methods(http.MethodGet)
	subRoute.HandleFunc("/", ah.POSTNewAccount).Methods(http.MethodPost)
	subRoute.HandleFunc("/status", ah.PUTStatus).Methods(http.MethodPut)
	subRoute.HandleFunc("/", ah.PUTAccount).Methods(http.MethodPut)
	subRoute.HandleFunc("/pass", ah.PUTPass).Methods(http.MethodPut)
	subRoute.HandleFunc("/address", ah.PUTAddress).Methods(http.MethodPut)
	subRoute.HandleFunc("/client", ah.PUTClient).Methods(http.MethodPut)
	subRoute.HandleFunc("/", ah.GETAccount).Methods(http.MethodGet)
}

func (aroutes *accountRoutes) Set() {
	ar := mysqldb.NewAccountRepository(aroutes.db)
	ai := usecase.NewAccountInteractor(ar)
	ah := handler.NewAccountHandler(ai)

	aroutes.setAccountRoutes(ah)
}
