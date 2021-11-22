package usecase

import (
	"database/sql"

	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account"
)

// A AccountInteractor belong to the usecases layer.
type AccountInteractor struct {
	accountRepository AccountRepository
}

func NewAccountInteractor(ar AccountRepository) *AccountInteractor {
	return &AccountInteractor{
		accountRepository: ar,
	}
}

func (ai *AccountInteractor) Save(a *account.Account) (result *sql.Result, err error) {
	result, err = ai.accountRepository.Insert(a)
	return
}

func (ai *AccountInteractor) ChangeStatus(a *account.Account) (result *sql.Result, err error) {
	result, err = ai.accountRepository.UpdateStatus(a)
	return
}

func (ai *AccountInteractor) Change(a *account.Account, e string, p string) (result *sql.Result, err error) {
	result, err = ai.accountRepository.Update(a, e, p)
	return
}

func (ai *AccountInteractor) ChangeAddress(a *account.Account) (result *sql.Result, err error) {
	result, err = ai.accountRepository.UpdateAddress(a)
	return
}

func (ai *AccountInteractor) ChangePassword(a *account.Account, np string) (result *sql.Result, err error) {
	result, err = ai.accountRepository.UpdatePassword(a, np)
	return
}

func (ai *AccountInteractor) ChangeClient(a *account.Account) (result *sql.Result, err error) {
	result, err = ai.accountRepository.UpdateClient(a)
	return
}

func (ai *AccountInteractor) Index(uuid string) (acc *account.Account, err error) {
	acc, err = ai.accountRepository.Select(uuid)
	return
}
