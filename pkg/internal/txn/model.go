package txn

import "time"

type Account struct {
	UUID string
}

type Location struct {
	UUID      string `json:"luuid"`
	Country   string `json:"country"`
	City      string `json:"city"`
	Estate     string `json:"estate"`
	Latitude  float64 `json:"lat"`
	Longitude float64 `json:"lon"`
}


type Transaction struct {
	UUID      string `json:"txnuuid"`
	Location  Location `json:"location"`
	Type      string `json:"type"`
	Reference string `json:"ref"`
	Amount    float64 `json:"amount"`
	Fee       float64 `json:"fee"`
	Done      bool `json:"done"`
	Concept   string `json:"concept"`
	CreatedAt time.Time `json:"tcd"`
	Account Account
}


type Transactions []Transaction