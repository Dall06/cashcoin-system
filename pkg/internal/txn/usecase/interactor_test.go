package usecase_test

import (
	"fmt"
	"testing"
	"time"

	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database/mocks"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/usecase"
)

var tx = &txn.Transaction{
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
		Email: "test@email.com",
		Phone: "47712345678",
	},
	Reference: "9D03C95643B187537840568E",
	Amount:    100.00,
	Fee:       0.03,
	Done:      true,
	Concept:   "CONCEPT",
	CreatedAt: time.Now(),
}

var ta = &txn.Account{
	UUID: "5f2b9fb0-2720-4b13-b879-441db4577a06",
	Email: "test@email.com",
	Phone: "47712345678",
}

var m = map[string]string{}

func TestDo(t *testing.T) {
	m["d_txnuuid"] = "5e3c405c-67b2-44a7-85f4-9f66e20185b9"
	m["toAUUID"] = "4df86514-79c2-41c7-812c-57687c7d4593"

	mdb := database.NewMock()
	db, _ := mocks.NewTxnMock(mdb).InsertMock()

	pr := mysqldb.NewTxnRepository(db)
	pi := usecase.NewTxnInteractor(pr)

	res, err := pi.Do(tx, m)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}

func TestIndex(t *testing.T) {
	mdb := database.NewMock()
	db := mocks.NewTxnMock(mdb).SelectMock()

	pr := mysqldb.NewTxnRepository(db)
	pi := usecase.NewTxnInteractor(pr)

	res, err := pi.Index(ta.UUID)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}
