package usecase

import (
	"database/sql"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn"
)

type TxnInteractor struct {
	TxnRepository TxnRepository // parameter_name DataType
}

func NewTxnInteractor(tr TxnRepository) *TxnInteractor {
	return &TxnInteractor{
		TxnRepository: tr,
	}
}

func (ti *TxnInteractor) Do(txn *txn.Transaction, m map[string]string) (res *sql.Result, err error) {
	res, err = ti.TxnRepository.Make(txn, m)
	return
}

func (ti *TxnInteractor) Index(a *txn.Account) (res *txn.Transactions, err error) {
	res, err = ti.TxnRepository.Select(a)
	return
}
