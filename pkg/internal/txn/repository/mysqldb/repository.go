package mysqldb

import (
	"database/sql"
	"fmt"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/repository/queries"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/usecase"
)

type txnRepository struct {
	DB *sql.DB
}

func NewTxnRepository(db *sql.DB) usecase.TxnRepository {
	return &txnRepository{DB: db}
}

func (tr *txnRepository) Make(t *txn.Transaction, m map[string]string) (*sql.Result, error) {
	res, err := tr.DB.Exec(queries.SPMakeTxn, // queri of cashcoin AddPsword
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
		&t.Location.Longitude,)
	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	return &res, nil
}

func (tr *txnRepository) Select(uuid string) (*txn.Transactions, error) {
	var ts txn.Transactions

	rows, err := tr.DB.Query(queries.SPSelectTxns, uuid)
	if err != nil {
		return nil, err
	}

	for rows.Next() {
		var t txn.Transaction
		err := rows.Scan(
			&t.UUID,
			&t.Type,
			&t.Reference,
			&t.Amount,
			&t.CreatedAt,
			&t.Concept,
			&t.Location.City,
			&t.Location.Estate,
		)
		if err != nil {
			return nil, err
		}
		ts = append(ts, t)
	}

	return &ts, nil
}