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
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/delivery"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/delivery/handler"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/repository/mysqldb"
	"github.com/Dall06/cashcoin-api-mysql/pkg/internal/account/usecase"
)

// func TestGETAccount(t *testing.T) {
// 	mdb := database.NewMock()
// 	db := mocks.NewAccountMock(mdb).SelectMock()

// 	req, err := http.NewRequest("GET", config.RouterBasePath_V1+"/account/5f2b9fb0-2720-4b13-b879-441db4577a06", nil)
// 	if err != nil {
// 		t.Fatal(err)
// 	}

// 	jwt := middleware.NewJWTHandler()
// 	tokenString, _, err := jwt.GenerateToken("test@email.com", "47712345678")
// 	if err != nil {
// 		t.Fatal(err)
// 	}

// 	var cookie string = "auth_token=" + tokenString
// 	req.Header.Set("Cookie", cookie)

// 	ar := mysqldb.NewAccountRepository(db)
// 	ai := usecase.NewAccountInteractor(ar)
// 	ah := handler.NewAccountHandler(ai)
// 	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
// 	rr := httptest.NewRecorder()
// 	handler := http.HandlerFunc(ah.Index)

// 	// Our handlers satisfy http.Handler, so we can call their ServeHTTP method
// 	// directly and pass in our Request and ResponseRecorder.
// 	handler.ServeHTTP(rr, req)

// 	// Check the status code is what we expect.
// 	if status := rr.Code; status != http.StatusOK {
// 		t.Errorf("handler returned wrong status code: got %v want %v",
// 			status, http.StatusOK)
// 	}

// 	fmt.Println(rr.Result().Body)
// 	fmt.Println(rr.Body)
// }

func TestPOSTAccount(t *testing.T) {
	var toSave = delivery.ReqCreate{
		AUUID:          "5f2b9fb0-2720-4b13-b879-441db4577a06",
		ADDUUID:       "44e07ff1-a9a0-4c20-a039-9858cfb06f9f",
		CUUID:         "aa3a2202-b141-432a-8779-75da8cc146a7",
		Email:         "test@email.com",
		Phone:         "47712345678",
		Password:      "Test1234",
		Country:       "MEX",
		City:          "LEON",
		Estate:         "GTO",
		Street:        "AV. U",
		BuldingNumber: 1,
		PostalCode:    "36000",
		Name:          "Test",
		LastName:      "Tested",
		Occupation:    "Tester",
		Clabe:         "1234567890123456",
	}
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).InsertMock()

	b := new(bytes.Buffer)
	json.NewEncoder(b).Encode(toSave)

	req, err := http.NewRequest("POST", config.RouterBasePath_V1+"/account/", b)
	if err != nil {
		t.Fatal(err)
	}

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)
	ah := handler.NewAccountHandler(ai)
	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(ah.Create)

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

func TestPUTAccount(t *testing.T) {
	var put = delivery.ReqAccount{
		Email:    "test@email.com",
		Phone:    "47712345678",
		NewEmail: "test1@email.com",
		NewPhone: "47799999999",
		Password: "Test1234",
	}
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateAccountMock()

	e, err := json.Marshal(put)
	if err != nil {
		t.Fatal(err)
		return
	}
	b := bytes.NewBuffer(e)

	req, err := http.NewRequest("PUT", config.RouterBasePath_V1+"/account/", b)
	if err != nil {
		t.Fatal(err)
	}

	jwt := middleware.NewJWTHandler()
	tokenString, _, err := jwt.GenerateToken(put.Email, put.Phone)
	if err != nil {
		t.Fatal(err)
	}

	var cookie string = "auth_token=" + tokenString
	req.Header.Set("Cookie", cookie)

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)
	ah := handler.NewAccountHandler(ai)

	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(ah.ChangeAccount)

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

func TestPUTStatus(t *testing.T) {
	var put = delivery.ReqStatus{
		AUUID:  "5f2b9fb0-2720-4b13-b879-441db4577a06",
		Status: "ACTIVE",
	}
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateStatusMock()

	e, err := json.Marshal(put)
	if err != nil {
		fmt.Println(err)
		return
	}
	b := bytes.NewBuffer(e)

	req, err := http.NewRequest("PUT", config.RouterBasePath_V1+"/account/status", b)
	if err != nil {
		t.Fatal(err)
	}

	jwt := middleware.NewJWTHandler()
	tokenString, _, err := jwt.GenerateToken("test@email.com", "47712345678")
	if err != nil {
		t.Fatal(err)
	}

	var cookie string = "auth_token=" + tokenString
	req.Header.Set("Cookie", cookie)

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)
	ah := handler.NewAccountHandler(ai)

	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(ah.ChangeStatus)

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

func TestChangePassword(t *testing.T) {
	var put = delivery.ReqPassword{
		Email:       "test@email.com",
		Phone:       "47712345678",
		Password:    "Test1234",
		NewPassword: "Test1234",
	}
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdatePasswordMock()

	e, err := json.Marshal(put)
	if err != nil {
		fmt.Println(err)
		return
	}
	b := bytes.NewBuffer(e)

	req, err := http.NewRequest("PUT", config.RouterBasePath_V1+"/change/P", b)
	if err != nil {
		t.Fatal(err)
	}

	jwt := middleware.NewJWTHandler()
	tokenString, _, err := jwt.GenerateToken(put.Email, put.Phone)
	if err != nil {
		t.Fatal(err)
	}

	var cookie string = "auth_token=" + tokenString
	req.Header.Set("Cookie", cookie)

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)
	ah := handler.NewAccountHandler(ai)

	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(ah.ChangePassword)

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

func TestPUTClient(t *testing.T) {
	var put = delivery.ReqPersonal{
		AUUID: "5f2b9fb0-2720-4b13-b879-441db4577a06",
		Name:       "Test",
		LastName:   "Tested",
		Occupation: "Tester",
	}
	mdb := database.NewMock()
	db, _ := mocks.NewAccountMock(mdb).UpdateClientMock()

	e, err := json.Marshal(put)
	if err != nil {
		fmt.Println(err)
		return
	}
	b := bytes.NewBuffer(e)

	req, err := http.NewRequest("PUT", config.RouterBasePath_V1+"/account/client", b)
	if err != nil {
		t.Fatal(err)
	}

	jwt := middleware.NewJWTHandler()
	tokenString, _, err := jwt.GenerateToken("test@email.com", "47712345678")
	if err != nil {
		t.Fatal(err)
	}

	var cookie string = "auth_token=" + tokenString
	req.Header.Set("Cookie", cookie)

	ar := mysqldb.NewAccountRepository(db)
	ai := usecase.NewAccountInteractor(ar)
	ah := handler.NewAccountHandler(ai)

	// We create a ResponseRecorder (which satisfies http.ResponseWriter) to record the response.
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(ah.ChangePersonal)

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
