package usecase

import "github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth"

type AuthInteractor struct {
	AuthRepository AuthRepository
}

func NewAuthInteractor(ar AuthRepository) *AuthInteractor {
	return &AuthInteractor{
		AuthRepository: ar,
	}
}

func (authInteractor *AuthInteractor) Authenticate(a *auth.Account) (account *auth.Account, err error) {
	account, err = authInteractor.AuthRepository.LogIn(a)
	return
}
