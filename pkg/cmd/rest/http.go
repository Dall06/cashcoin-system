package rest

import (
	"database/sql"
	"log"
	"net/http"
	"time"

	"github.com/Dall06/cashcoin-api-mysql/config"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/middleware"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/routes"
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/services"
	"github.com/gorilla/mux"
)

type httpServer struct {
	Router *mux.Router
	Conn   *sql.DB
}

func NewHTTPServer(router *mux.Router, conn *sql.DB) *httpServer {
	return &httpServer{
		Router: router,
		Conn:   conn,
	}
}

func (s *httpServer) setRouter() {
	amw := middleware.NewAuthenticationMiddleWre()
	amw.Populate()

	cors := middleware.NewCORSMiddleware("GET, POST, PUT, DELETE", "localhost")

	routes.NewAccountRoutes(s.Router, s.Conn).Set()
	routes.NewAuthRoutes(s.Router, s.Conn).Set()
	routes.NewTxnRoutes(s.Router, s.Conn).Set()

	s.Router.Use(amw.Middleware)
	s.Router.Use(cors.EnableCORS)
}

func (s *httpServer) StartHTTPServer() {
	server := &http.Server{
		Handler: s.Router,
		Addr:    config.Port,
		// timeouts so the server never waits forever...
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	s.setRouter()

	log.Println("Server has started at port", config.Port)
	services.NewGracefullyShutDown(s.Router, config.Port).RunGracefully()
	log.Fatal(server.ListenAndServe())
}
