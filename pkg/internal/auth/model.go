package auth

import "time"

type Client struct {
	Name     string
	LastName string
}

type Address struct {
	City    string
	Estate  string
	Country string
}

type Account struct {
	UUID       string
	Email      string
	Phone      string
	Clabe      string
	Password   string
	Balance    float64
	Status     string
	LastLogdAt time.Time
	Client     Client
	Address    Address
}
