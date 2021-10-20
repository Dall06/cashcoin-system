package routes

import (
	"database/sql"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/config"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/delivery/handler"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/usecase"
	"github.com/gorilla/mux"
)

type authRoutes struct {
	router *mux.Router
	db     *sql.DB
}

func NewAuthRoutes(r *mux.Router, db *sql.DB) *authRoutes {
	return &authRoutes{
		router: r,
		db:     db,
	}
}

func (aroutes *authRoutes) setAuthRoutes(ah *handler.AuthHandler) {
	var pathPrefix_v1 string = config.RouterBasePath_V1 + "/auth"

	subRoute := aroutes.router.PathPrefix(pathPrefix_v1).Subrouter()

	subRoute.HandleFunc("/welcome", func(rw http.ResponseWriter, r *http.Request) {
		services.NewResponseHandler().RespondWithSuccess("welcome to auth routes", rw)
	}).Methods(http.MethodGet)
	subRoute.HandleFunc("/", ah.GETAuth).Methods(http.MethodGet)
}

func (aroutes *authRoutes) Set() {
	ar := mysqldb.NewAuthRepository(aroutes.db)
	ai := usecase.NewAuthInteractor(ar)
	ah := handler.NewAuthHandler(ai)

	aroutes.setAuthRoutes(ah)
}
