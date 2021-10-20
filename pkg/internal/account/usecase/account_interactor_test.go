package usecase_test

import (
	"fmt"
	"testing"

	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database/mocks"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/usecase"
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
		State: "GTO",
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

func TestIndex(t *testing.T) {
	mdb := database.NewMock()
	db := mocks.NewAccountMock(mdb).SelectMock()

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)

	res, err := ai.Index(a)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}

func TestSave(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).InsertMock()

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)

	res, err := ai.Save(a)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}

func TestChange(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateAccountMock()

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)

	res, err := ai.Change(a, "test1@email.com", "47799999999")

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}

func TestChangeStatus(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateStatusMock()

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)

	res, err := ai.ChangeStatus(a)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}

func TestChangePassword(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdatePasswordMock()

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)

	res, err := ai.ChangePassword(a, "Test1234")

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}

func TestChangeAddress(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateAddressMock()

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)

	res, err := ai.ChangeAddress(a)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}

func TestChangeClient(t *testing.T) {
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateClientMock()

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)

	res, err := ai.ChangeClient(a)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(res)
}
