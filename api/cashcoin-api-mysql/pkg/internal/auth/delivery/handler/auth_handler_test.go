package handler_test

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/Dall06/cashcoin-api-mysql/config"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database"
	"github.com/Dall06/cashcoin-api-mysql/pkg/database/mocks"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/delivery"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/delivery/handler"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/auth/usecase"
)

func TestGETAuth(t *testing.T) {
	var get = delivery.GETAAuth{
		Email:    "test@email.com",
		Phone:    "47712345678",
		Password: "Test1234",
	}
	mdb := database.NewMock()
	db := mocks.NewAuthMocks(mdb).LogInMock()

	b := new(bytes.Buffer)
	json.NewEncoder(b).Encode(get)

	req, err := http.NewRequest("GET", config.RouterBasePath_V1+"/auth/", b)
	if err != nil {
		t.Fatal(err)
	}

	ar := mysqldb.NewAuthRepository(db)
	ai := usecase.NewAuthInteractor(ar)
	ah := handler.NewAuthHandler(ai)
	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(ah.GETAuth)

	// Our handlers satisfy http.Handler, so we can call their ServeHTTP method
	// directly and pass in our Request and ResponseRecorder.
	handler.ServeHTTP(rr, req)

	// Check the status code is what we expect.
	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}
	fmt.Println(rr.Result().Cookies())
	fmt.Println(rr.Result().Body)
	fmt.Println(rr.Body)
}
