package mocks

import (
	"database/sql"
	"regexp"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/repository/queries"
)

type authhMocks struct {
	mock *database.Mock
}

func NewAuthMocks(m *database.Mock) *authhMocks {
	return &authhMocks{
		mock: m,
	}
}

func (um *authhMocks) LogInMock() *sql.DB {
	rows := sqlmock.NewRows([]string{
		"auuid",
		"email",
		"phone",
		"balance",
		"status",
		"clabe",
		"lad",
		"fname",
		"lname",
		"city",
		"state",
		"country",
	}).AddRow(
		&au.UUID,
		&au.Email,
		&au.Phone,
		&au.Balance,
		&au.Status,
		&au.Clabe,
		&au.LastLogdAt,
		&au.Client.Name,
		&au.Client.LastName,
		&au.Address.City,
		&au.Address.Estate,
		&au.Address.Country,
	)

	um.mock.Sqlmock.ExpectQuery(regexp.QuoteMeta(queries.SPAuthAccount)).
		WithArgs(a.Email, a.Phone, a.Password).
		WillReturnRows(rows)

	return um.mock.DB
}
