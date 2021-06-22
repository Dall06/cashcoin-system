package database

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB
var err error

func OpenConnection() (*sql.DB, error) {
	db, err = sql.Open("mysql", ConnectionString)
	if err != nil {
		panic(err.Error())
	}
	return db, err
}
