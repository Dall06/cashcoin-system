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
	"github.com/Dall06/cashcoin-api-mysql/pkg/infrastructure/middleware"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/delivery"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/delivery/handler"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/txn/usecase"
)

func TestGETtxns(t *testing.T) {
	var get = delivery.GETTxns{
		Email: "test@email.com",
		Phone: "47712345678",
	}
	mdb := database.NewMock()
	db := mocks.NewTxnMock(mdb).SelectMock()

	b := new(bytes.Buffer)
	json.NewEncoder(b).Encode(get)

	req, err := http.NewRequest("GET", config.RouterBasePath_V1+"/txn/", b)
	if err != nil {
		t.Fatal(err)
	}

	jwt := middleware.NewJWTHandler()
	tokenString, _, err := jwt.GenerateToken(get.Email, get.Phone)
	if err != nil {
		t.Fatal(err)
	}

	var cookie string = "auth_token=" + tokenString
	req.Header.Set("Cookie", cookie)

	tr := mysqldb.NewTxnRepository(db)
	ti := usecase.NewTxnInteractor(tr)
	th := handler.NewTxnHandler(ti)
	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(th.IndexTxns)

	// Our handlers satisfy http.Handler, so we can call their ServeHTTP method
	// directly and pass in our Request and ResponseRecorder.
	handler.ServeHTTP(rr, req)

	// Check the status code is what we expect.
	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

	fmt.Println(rr.Result().Body)
	fmt.Println(rr.Body)
}

func TestPOSTNewtxn(t *testing.T) {
	var post = delivery.POSTTxn{
		UUID: "92e29404-753c-4b14-aa55-b180f6df7462",
		LUUID: "de61bb2c-ce92-4523-a545-70c09ab25f5f",
		ToTxnUUID: "5e3c405c-67b2-44a7-85f4-9f66e20185b9",
		Email: "test@email.com",
		Phone: "47712345678",
		ToAUUID: "4df86514-79c2-41c7-812c-57687c7d4593",
		Amount:    100.00,
		Concept:   "CONCEPT",
		Country:   "MEX",
		City:      "LEON",
		State:     "GTO",
		Latitude:  100.1,
		Longitude: -304.2134,
		Reference: "9D03C95643B187537840568E",
	}
	mdb := database.NewMock()
	db, _ := mocks.NewTxnMock(mdb).InsertMock()

	b := new(bytes.Buffer)
	json.NewEncoder(b).Encode(post)

	req, err := http.NewRequest("POST", config.RouterBasePath_V1+"/txn/", b)
	if err != nil {
		t.Fatal(err)
	}

	jwt := middleware.NewJWTHandler()
	tokenString, _, err := jwt.GenerateToken(post.Email, post.Phone)
	if err != nil {
		t.Fatal(err)
	}

	var cookie string = "auth_token=" + tokenString
	req.Header.Set("Cookie", cookie)

	tr := mysqldb.NewTxnRepository(db)
	ti := usecase.NewTxnInteractor(tr)
	th := handler.NewTxnHandler(ti)
	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(th.Make)

	// Our handlers satisfy http.Handler, so we can call their ServeHTTP method
	// directly and pass in our Request and ResponseRecorder.
	handler.ServeHTTP(rr, req)

	// Check the status code is what we expect.
	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

	fmt.Println(rr.Result().Body)
	fmt.Println(rr.Body)
}