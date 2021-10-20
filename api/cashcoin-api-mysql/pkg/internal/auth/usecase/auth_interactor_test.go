package usecase_test

import (
	"fmt"
	"testing"

	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database/mocks"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/usecase"
)

var al = auth.Account{
	Email:    "test@email.com",
	Password: "Test1234",
	Phone:    "47712345678",
}

func TestLogin(t *testing.T) {
	mdb := database.NewMock()
	db := mocks.NewAuthMocks(mdb).LogInMock()

	ar := mysqldb.NewAuthRepository(db)
	ai := usecase.NewAuthInteractor(ar)

	user, err := ai.Authenticate(&al)

	if err != nil {
		t.Fatal(err)
	}

	fmt.Println(user)
}
