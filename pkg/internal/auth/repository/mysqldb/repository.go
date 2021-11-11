package mysqldb

import (
	"database/sql"
	"fmt"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/repository/queries"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/usecase"
)

type mysqlAuthRepository struct {
	DB *sql.DB
}

func NewAuthRepository(db *sql.DB) usecase.AuthRepository {
	return &mysqlAuthRepository{DB: db}
}

func (ar *mysqlAuthRepository) LogIn(a *auth.Account) (*auth.Account, error) {
	var aa auth.Account

	err := ar.DB.QueryRow(queries.SPAuthAccount, a.Email, a.Phone, a.Password).Scan(
		&aa.UUID,
		&aa.Email,
		&aa.Phone,
		&aa.Balance,
		&aa.Status,
		&aa.Clabe,
		&aa.Client.Name,
		&aa.Client.LastName,
		&aa.Address.City,
		&aa.Address.State,
		&aa.Address.Country)

	if err != nil {
		fmt.Print(a)
		return &aa, err
	}

	return &aa, nil
}
