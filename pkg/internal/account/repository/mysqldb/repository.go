package mysqldb

import (
	"database/sql"
	"fmt"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/repository/queries"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/usecase"
)

// A UserRepository belong to the inteface layer
type mysqlAccountRepository struct {
	DB *sql.DB
}

func NewAccountRepository(db *sql.DB) usecase.AccountRepository {
	return &mysqlAccountRepository{DB: db}
}

func (ur *mysqlAccountRepository) Insert(a *account.Account) (*sql.Result, error) {
	res, err := ur.DB.Exec(queries.SPInsertAccount,
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
		&a.Client.Occupation)

	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	return &res, nil
}

func (ur *mysqlAccountRepository) UpdateStatus(a *account.Account) (*sql.Result, error) {
	res, err := ur.DB.Exec(queries.SPUpdateStatus,
		&a.Status,
		&a.UUID,)

	if err != nil {
		
		fmt.Println(err)
		return nil, err
	}

	return &res, nil
}

func (ur *mysqlAccountRepository) Update(a *account.Account, ne string, np string) (*sql.Result, error) {
	res, err := ur.DB.Exec(queries.SPUpdateAccount,
		&a.Email,
		&ne,
		&a.Phone,
		&np,
		&a.Password)

	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	return &res, nil
}

func (ur *mysqlAccountRepository) UpdateAddress(a *account.Account) (*sql.Result, error) {
	res, err := ur.DB.Exec(queries.SPUpdateAddress,
		&a.UUID,
		&a.Address.City,
		&a.Address.Estate,
		&a.Address.Street,
		&a.Address.BuldingNumber,
		&a.Address.Country,
		&a.Address.PostalCode)

	if err != nil {
		return &res, err
	}

	return &res, nil
}

func (ur *mysqlAccountRepository) UpdatePassword(a *account.Account, np string) (*sql.Result, error) {
	res, err := ur.DB.Exec(queries.SPUpdatePassword,
		&a.Email,
		&a.Phone,
		&a.Password,
		&np)

	if err != nil {
		return &res, err
	}

	return &res, nil
}

func (ur *mysqlAccountRepository) UpdateClient(a *account.Account) (*sql.Result, error) {
	res, err := ur.DB.Exec(queries.SPUpdateClient,
		&a.Client.Name,
		&a.Client.LastName,
		&a.Client.Occupation,
		&a.UUID,)

	if err != nil {
		return nil, err
	}

	return &res, nil
}

func (ur *mysqlAccountRepository) Select(auuid string) (*account.Account, error) {
	var res account.Account

	err := ur.DB.QueryRow(queries.SPSelectAccount, auuid).Scan(
		&res.UUID,
		&res.Email,
		&res.Phone,
		&res.Balance,
		&res.Status,
		&res.Clabe,
		&res.LastLogdAt,
		&res.Client.Name,
		&res.Client.LastName,
		&res.Address.City,
		&res.Address.Estate,
		&res.Address.Country)

	if err != nil {
		return &res, err
	}
	return &res, nil
}
