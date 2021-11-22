package mocks

import (
	"database/sql"
	"regexp"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/repository/queries"
)

type txnMock struct {
	mock *database.Mock
}

func NewTxnMock(m *database.Mock) *txnMock {
	return &txnMock{
		mock: m,
	}
}

func (tm *txnMock) InsertMock() (*sql.DB, sqlmock.Sqlmock) {
	var m = map[string]string{}

	m["d_txnuuid"] = "5e3c405c-67b2-44a7-85f4-9f66e20185b9"
	m["toAUUID"] = "4df86514-79c2-41c7-812c-57687c7d4593"

	tm.mock.Sqlmock.ExpectExec(regexp.QuoteMeta(queries.SPMakeTxn)).WithArgs(
		&t.UUID,
		m["d_txnuuid"],
		&t.Account.UUID,
		&t.Location.UUID,
		&t.Reference,
		m["toAUUID"],
		&t.Amount,
		&t.Concept,
		&t.Location.Country,
		&t.Location.City,
		&t.Location.Estate,
		&t.Location.Latitude,
		&t.Location.Longitude,
	).WillReturnResult(sqlmock.NewResult(0, 0))

	return tm.mock.DB, tm.mock.Sqlmock
}

func (tm *txnMock) SelectMock() *sql.DB {
	var list txn.Transactions
	var rows *sqlmock.Rows
	list = append(list, *t)
	list = append(list, *t)
	list = append(list, *t)

	for _, e  := range list {
		rows = sqlmock.NewRows([]string{
			"uuid",
			"type",
			"ref",
			"amount",
			"createdAt",
			"concept",
			"city",
			"state",
		}).AddRow(
			&e.UUID,
			&e.Type,
			&e.Reference,
			&e.Amount,
			&e.CreatedAt,
			&e.Concept,
			&e.Location.City,
			&e.Location.Estate,
		)
	}

	tm.mock.Sqlmock.ExpectQuery(regexp.QuoteMeta(queries.SPSelectTxns)).
		WithArgs(a.UUID).
		WillReturnRows(rows)

	return tm.mock.DB
}