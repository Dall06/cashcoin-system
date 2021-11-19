package mocks

import (
	"database/sql"
	"fmt"
	"regexp"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/repository/queries"
)

type accountMock struct {
	mock *database.Mock
}

func NewAccountMock(m *database.Mock) *accountMock {
	return &accountMock{
		mock: m,
	}
}

func (am *accountMock) InsertMock() (*sql.DB, sqlmock.Sqlmock) {
	fmt.Println(a.UUID)
	//mock.ExpectBegin()
	am.mock.Sqlmock.ExpectExec(regexp.QuoteMeta(queries.SPInsertAccount)).WithArgs(
		&a.UUID,
		&a.Client.UUID,
		&a.Address.UUID,
		&a.Clabe,
		&a.Email,
		&a.Phone,
		&a.Password,
		&a.Address.City,
		&a.Address.Estate,
		&a.Address.Street,
		&a.Address.BuldingNumber,
		&a.Address.PostalCode,
		&a.Address.Country,
		&a.Client.Name,
		&a.Client.LastName,
		&a.Client.Occupation,
	).WillReturnResult(sqlmock.NewResult(0, 0))
	//mock.ExpectCommit()

	return am.mock.DB, am.mock.Sqlmock
}

func (am *accountMock) UpdateStatusMock() (*sql.DB, sqlmock.Sqlmock) {
	//mock.ExpectBegin()
	am.mock.Sqlmock.ExpectExec(regexp.QuoteMeta(queries.SPUpdateStatus)).WithArgs(
		&a.Email,
		&a.Phone,
		&a.Status,
	).WillReturnResult(sqlmock.NewResult(0, 0))
	//mock.ExpectCommit()

	return am.mock.DB, am.mock.Sqlmock
}

func (am *accountMock) UpdateAccountMock() (*sql.DB, sqlmock.Sqlmock) {
	//mock.ExpectBegin()
	am.mock.Sqlmock.ExpectExec(regexp.QuoteMeta(queries.SPUpdateAccount)).WithArgs(
		&a.Email,
		&ne,
		&a.Phone,
		&np,
		&a.Password,
	).WillReturnResult(sqlmock.NewResult(0, 0))
	//mock.ExpectCommit()

	return am.mock.DB, am.mock.Sqlmock
}

func (am *accountMock) UpdateAddressMock() (*sql.DB, sqlmock.Sqlmock) {
	//mock.ExpectBegin()
	am.mock.Sqlmock.ExpectExec(regexp.QuoteMeta(queries.SPUpdateAddress)).WithArgs(
		&a.Email,
		&a.Phone,
		&a.Address.City,
		&a.Address.Estate,
		&a.Address.Street,
		&a.Address.BuldingNumber,
		&a.Address.Country,
		&a.Address.PostalCode,
	).WillReturnResult(sqlmock.NewResult(0, 0))
	//mock.ExpectCommit()

	return am.mock.DB, am.mock.Sqlmock
}

func (am *accountMock) UpdatePasswordMock() (*sql.DB, sqlmock.Sqlmock) {
	//mock.ExpectBegin()
	am.mock.Sqlmock.ExpectExec(regexp.QuoteMeta(queries.SPUpdatePassword)).WithArgs(
		&a.Email,
		&a.Phone,
		&a.Password,
		&npass,
	).WillReturnResult(sqlmock.NewResult(0, 0))
	//mock.ExpectCommit()

	return am.mock.DB, am.mock.Sqlmock
}

func (am *accountMock) UpdateClientMock() (*sql.DB, sqlmock.Sqlmock) {
	am.mock.Sqlmock.ExpectExec(regexp.QuoteMeta(queries.SPUpdateClient)).WithArgs(
		&a.Email,
		&a.Phone,
		&a.Client.Name,
		&a.Client.LastName,
		&a.Client.Occupation,
	).WillReturnResult(sqlmock.NewResult(0, 0))
	//mock.ExpectCommit()

	return am.mock.DB, am.mock.Sqlmock
}

func (am *accountMock) SelectMock() *sql.DB {
	rows := sqlmock.NewRows([]string{
		"auuid",
		"email",
		"phone",
		"balance",
		"status",
		"clabe",
		"fname",
		"lname",
		"city",
		"state",
		"country",
	}).AddRow(
		"5f2b9fb0-2720-4b13-b879-441db4577a06",
		&a.Email,
		&a.Phone,
		&a.Balance,
		&a.Status,
		&a.Clabe,
		&a.Client.Name,
		&a.Client.LastName,
		&a.Address.City,
		&a.Address.Estate,
		&a.Address.Country,
	)

	am.mock.Sqlmock.ExpectQuery(regexp.QuoteMeta(queries.SPSelectAccount)).
		WithArgs(&a.Email, &a.Phone).
		WillReturnRows(rows)

	return am.mock.DB
}
