package models

type TransactionDetail struct {
	ID int64 `json:"id"`
	Destination UserData `json:"destination"`
	Origin UserData `json:"origin"`
	Concept string `json:"concept"`
	Order TransactionOrder `json:"transactionOrder"`
}

type TransactionOrder struct {
	ID int64 `json:"id"`
	Quantity float64 `json:"quantity"`
	Date string `json:"date"`
	TransactionType TransactionType `json:"transactionType"`
}

type TransactionType struct {
	ID int64 `json:"id"`
	TypeDescription string `json:"typeDescription"`
}

type TransactionUser struct {
	ID int64 `json:"id"`
	UserData UserData `json:"userData"`
	TransactionDetail TransactionDetail `json:"transactionDetail"`
	TransactionUserType string `json:"transactionUType"`
	TranscationUserStatus int64 `json:"transactionUStatus"`
}