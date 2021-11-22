package delivery

import (
	"encoding/json"
	"net/http"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn"
	"github.com/Dall06/cashcoin-api-mysql/pkg/utils"
	"gopkg.in/go-playground/validator.v9"
)

type HandlerHelper struct {
	Validator *validator.Validate
}

func NewHandlerHelper() *HandlerHelper {
	return &HandlerHelper{
		Validator: validator.New(),
	}
}

func (th *HandlerHelper) ValidatePOSTRequest(r *http.Request) (*txn.Transaction, map[string]string, error) {
	var post POSTTxn
	var t txn.Transaction

	err := json.NewDecoder(r.Body).Decode(&post)
	if err != nil {
		return &t, nil, err
	}

	err = th.Validator.Struct(post)
	if err != nil {
		return &t, nil, err
	}

	t = txn.Transaction {
		UUID: utils.CheckAndReturn(post.WUUID),
		Location: txn.Location{
			UUID: utils.CheckAndReturn(post.LUUID),
			Country: post.Country,
			City: post.City,
			Estate: post.Estate,
			Latitude: post.Latitude,
			Longitude: post.Longitude,
		},
		Reference: post.Reference,
		Account: txn.Account{
			UUID: post.AUUID,
		},
		Amount: post.Amount,
		Concept: post.Concept,
	}

	m := make(map[string]string)
	m["d_txnuuid"] = utils.CheckAndReturn(post.DUUID)
	m["toAUUID"] = post.ToAUUID

	return &t, m, nil
}

