package routes

import (
	"database/sql"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/config"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/delivery/handler"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/usecase"
	"github.com/gorilla/mux"
)

type txnRoutes struct {
	router *mux.Router
	db     *sql.DB
}

func NewTxnRoutes(r *mux.Router, db *sql.DB) *txnRoutes {
	return &txnRoutes{
		router: r,
		db:     db,
	}
}

func (pr *txnRoutes) setTxnRoutes(ph *handler.TxnHandler) {
	var pathPrefix_v1 string = config.RouterBasePath_V1 + "/txn"

	subRoute := pr.router.PathPrefix(pathPrefix_v1).Subrouter()

	subRoute.HandleFunc("/welcome", func(rw http.ResponseWriter, r *http.Request) {
		services.NewResponseHandler().RespondWithSuccess("welcome to cashcoin routes", rw)
	}).Methods(http.MethodGet)
	subRoute.HandleFunc("/{uuid}", ph.IndexTxns).Methods(http.MethodGet)
	subRoute.HandleFunc("/", ph.Make).Methods(http.MethodPost)
}

func (proutes *txnRoutes) Set() {
	tr := mysqldb.NewTxnRepository(proutes.db)
	ti := usecase.NewTxnInteractor(tr)
	th := handler.NewTxnHandler(ti)

	proutes.setTxnRoutes(th)
}
