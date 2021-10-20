package cmd

import (
	"log"

	"github.com/Dall06/cashcoin-api-mysql/pkg/cmd/rest"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/gorilla/mux"
)

func RunApp() {
	router := mux.NewRouter()

	mysqlConn := database.NewMySQLConn()
	conn, err := mysqlConn.OpenConnection()
	if err != nil {
		log.Fatalf("ERROR %v", err)
	}

	httpServer := rest.NewHTTPServer(router, conn)
	httpServer.StartHTTPServer()
}
