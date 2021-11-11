package usecase

import (
	"database/sql"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
)

// A UserRepository belong to the usecases layer.
type AccountRepository interface {
	Insert(*account.Account) (*sql.Result, error)
	UpdateStatus(*account.Account) (*sql.Result, error)
	Update(*account.Account, string, string) (*sql.Result, error)
	UpdateAddress(*account.Account) (*sql.Result, error)
	UpdatePassword(*account.Account, string) (*sql.Result, error)
	UpdateClient(*account.Account) (*sql.Result, error)
	Select(*account.Account) (*account.Account, error)
}
