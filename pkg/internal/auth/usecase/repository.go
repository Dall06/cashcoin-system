package usecase

import "github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth"

type AuthRepository interface {
	LogIn(u *auth.Account) (userAccount *auth.Account, err error)
}
