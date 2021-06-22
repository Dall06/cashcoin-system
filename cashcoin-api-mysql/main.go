package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/Dall06/cashcoin-api-mysql/database"
	"github.com/Dall06/cashcoin-api-mysql/routes"
	"github.com/gorilla/mux"
)

func main() {
	var port string = ":8080"

	fmt.Println("Hello human!... Welcome to cashcoin API console :)")

	dbConnection, err := database.OpenConnection()
	if err != nil {
		log.Println("Error with database" + err.Error())
		return
	}
	err = dbConnection.Ping()
	if err != nil {
		log.Println("Error making connection to DB. Please check credentials :C...\n" + err.Error())
		return
	}

	router := mux.NewRouter()
	routes.SetUserRoutes(router)
	routes.SetTransactionRoutes(router)
	routes.SetAuthRoutes(router)
	server := &http.Server{
		Handler: router,
		Addr:    port,
		// timeouts so the server never waits forever...
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}
	log.Println("Server has started at port", port)
	log.Fatal(server.ListenAndServe())
}
