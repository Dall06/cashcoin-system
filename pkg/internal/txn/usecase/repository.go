package usecase

import (
	"database/sql"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn"
)

type TxnRepository interface {
	Make(*txn.Transaction, map[string]string) (*sql.Result, error)
	Select(string) (*txn.Transactions, error)
}
