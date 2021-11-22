// Added methos of Auth repo because they are related to user account entity
package mysqldb_test

import (
	"fmt"
	"testing"

	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database/mocks"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/repository/mysqldb"
)

var a *account.Account = &account.Account{
	UUID:     "5f2b9fb0-2720-4b13-b879-441db4577a06",
	Client:   account.Client{
		UUID: "aa3a2202-b141-432a-8779-75da8cc146a7",
		Name: "Test",
		LastName: "Tested",
		Occupation: "Tester",
	},
	Address:  account.Address{
		UUID: "44e07ff1-a9a0-4c20-a039-9858cfb06f9f",
		Country: "MEX",
		City: "LEON",
		Estate: "GTO",
		Street: "AV. U",
		BuldingNumber: 1,
		PostalCode: "36000",
	},
	Email:    "test@email.com",
	Phone:    "47712345678",
	Password: "Test1234",
	Balance:  1000.00,
	Status: "ACTIVE",
	Clabe: "1234567890123456",
}

func TestSelect(t *testing.T) {
	mdb := database.NewMock()
	db := mocks.NewAccountMock(mdb).SelectMock()

	ar := mysqldb.NewAccountRepository(db)
	res, err := ar.Select(a.UUID)

	fmt.Println("ERROR ", err)
	fmt.Println("USER ", res)

	if err != nil {
		t.Fatal(err)
	}
}

func TestInsert(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).InsertMock()

	ar := mysqldb.NewAccountRepository(db)
	res, err := ar.Insert(a)

	fmt.Println("ERROR ", err)
	fmt.Println("USER ", res)

	if err != nil {
		t.Fatal(err)
	}
}

func TestUpdate(t *testing.T) {
	var ne string = "test1@email.com"
	var nph string = "47799999999"

	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateAccountMock()

	ar := mysqldb.NewAccountRepository(db)
	res, err := ar.Update(a, ne, nph)

	fmt.Println("ERROR ", err)
	fmt.Println("USER ", res)

	if err != nil {
		t.Fatal(err)
	}
}

func TestUpdateClient(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateClientMock()

	ar := mysqldb.NewAccountRepository(db)
	res, err := ar.UpdateClient(a)

	fmt.Println("ERROR ", err)
	fmt.Println("USER ", res)

	if err != nil {
		t.Fatal(err)
	}
}

func TestUpdateStatus(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateStatusMock()

	ar := mysqldb.NewAccountRepository(db)
	res, err := ar.UpdateStatus(a)

	fmt.Println("ERROR ", err)
	fmt.Println("USER ", res)

	if err != nil {
		t.Fatal(err)
	}
}

func TestUpdateAddress(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateAddressMock()

	ar := mysqldb.NewAccountRepository(db)
	res, err := ar.UpdateAddress(a)

	fmt.Println("ERROR ", err)
	fmt.Println("USER ", res)

	if err != nil {
		t.Fatal(err)
	}
}

func TestUpdatePassword(t *testing.T) {
	pass := "Test1234"
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdatePasswordMock()

	ar := mysqldb.NewAccountRepository(db)
	res, err := ar.UpdatePassword(a, pass)

	fmt.Println("ERROR ", err)
	fmt.Println("USER ", res)

	if err != nil {
		t.Fatal(err)
	}
}
