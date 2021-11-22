package mocks

import (
	"time"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn"
)

var npass string = "Test1234"
var np string = "47799999999"
var ne string = "test1@email.com"

var a *account.Account = &account.Account{
	UUID: "5f2b9fb0-2720-4b13-b879-441db4577a06",
	Client: account.Client{
		UUID:       "aa3a2202-b141-432a-8779-75da8cc146a7",
		Name:       "Test",
		LastName:   "Tested",
		Occupation: "Tester",
	},
	Address: account.Address{
		UUID:          "44e07ff1-a9a0-4c20-a039-9858cfb06f9f",
		Country:       "MEX",
		City:          "LEON",
		Estate:         "GTO",
		Street:        "AV. U",
		BuldingNumber: 1,
		PostalCode:    "36000",
	},
	Email:    "test@email.com",
	Phone:    "47712345678",
	Password: "Test1234",
	Balance:  1000.00,
	Status:   "ACTIVE",
	Clabe: "1234567890123456",
}

var au = &auth.Account{
	UUID:     "5f2b9fb0-2720-4b13-b879-441db4577a06",
	Email:    "test@email.com",
	Phone:    "47712345678",
	Password: "Test123",
	Balance:  1000.00,
	Status:   "ACTIVE",
	Client: auth.Client{
		Name:     "Test",
		LastName: "Tested",
	},
	Address: auth.Address{
		Country: "MEX",
		City:    "LEON",
		Estate:   "GTO",
	},
	Clabe: "1234567890123456",
}

var t = &txn.Transaction{
	UUID: "92e29404-753c-4b14-aa55-b180f6df7462",
	Location: txn.Location{
		UUID:      "de61bb2c-ce92-4523-a545-70c09ab25f5f",
		Country:   "MEX",
		City:      "LEON",
		Estate:     "GTO",
		Latitude:  100.1,
		Longitude: -304.2134,
	},
	Type: "WITHDRAW",
	Account: txn.Account{
		UUID: "4df86514-79c2-41c7-812c-57687c7d4593",
	},
	Reference: "9D03C95643B187537840568E",
	Amount:    100.00,
	Fee:       0.03,
	Done:      true,
	Concept:   "CONCEPT",
	CreatedAt: time.Now(),
}
