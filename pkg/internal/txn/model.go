package txn

import "time"

type Location struct {
	UUID      string
	Country   string
	City      string
	Estate     string
	Latitude  float64
	Longitude float64
}

type Account struct {
	Email string
	Phone string
}

type Transaction struct {
	UUID      string
	Location  Location
	Type      string
	Account   Account
	Reference string
	Amount    float64
	Fee       float64
	Done      bool
	Concept   string
	CreatedAt time.Time
}

type Transactions []Transaction