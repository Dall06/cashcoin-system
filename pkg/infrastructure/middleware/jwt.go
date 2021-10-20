package middleware

import (
	"net/http"
	"time"

	"github.com/Dall06/cashcoin-api-mysql/config"
	"github.com/golang-jwt/jwt"
)

var jwtKey = []byte(config.SecretPassword)

type claims struct {
	Email string
	Phone string
	SToken string
	jwt.StandardClaims
}

type JWTHandler struct{}

func NewJWTHandler() *JWTHandler {
	return &JWTHandler{}
}

func (j *JWTHandler) GenerateToken(email string, phone string) (string, time.Time, error) {
	expirationTime := time.Now().Add(time.Hour * 8)
	st := config.SessionToken
	// Setting up token
	claims := &claims{
		Email: email,
		Phone: phone,
		SToken: st,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString(jwtKey)
	// if error when creating token retunr Internal Server Error
	if err != nil {
		return "", expirationTime, err
	}

	return tokenString, expirationTime, nil
}

func (j *JWTHandler) GenerateSToken(email string, phone string) (string, time.Time, error) {
	expirationTime := time.Now().Add(time.Hour * 8)
	// Setting up token
	claims := &claims{
		Email: email,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString(jwtKey)
	// if error when creating token retunr Internal Server Error
	if err != nil {
		return "", expirationTime, err
	}

	return tokenString, expirationTime, nil
}

func (j *JWTHandler) SetAuthTokenCookie(w http.ResponseWriter, e string, p string) error {
	tokenString, expirationTime, err := j.GenerateToken(e, p)
	// if error when creating token retunr Internal Server Error
	if err != nil {
		return err
	}

	http.SetCookie(w, &http.Cookie{
		Name:    "auth_token",
		Value:   tokenString,
		Expires: expirationTime,
	})

	return nil
}

/*
func (*JWTHandler) RefreshAuthTokenCookie(r *http.Request, email string) (string, time.Time, error) {
	expirationTime := time.Now().Add(time.Minute * 5)
	//  get token cookie value
	cookie, err := r.Cookie("auth_token")
	if err != nil {
		return "", time.Time{}, err
	}
	tokenStr := cookie.Value
	// setting claims up and generate token
	claims := &claims{
		Email: email,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}
	token, err := jwt.ParseWithClaims(tokenStr, claims,
		func(t *jwt.Token) (interface{}, error) {
			return jwtKey, nil
		},
	)

	if err != nil {
		return "", time.Time{}, err
	}
	// if token is not valid respond authorization and then re flow continues
	if !token.Valid {
		return "", time.Time{}, http.ErrAbortHandler
		// return
	}
	// Generate new token
	newToken := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := newToken.SignedString(jwtKey)
	// if error exists when creating new token send error
	if err != nil {
		return "", time.Time{}, err
	}
	// Set new Cookie, then finishes
	return tokenString, expirationTime, nil
}

func (*JWTHandler) CleanAuthTokenCookie(w http.ResponseWriter) {
	// Cleans your t=cookie in the 'token' field
	http.SetCookie(w, &http.Cookie{
		Name:    "auth_token",
		Value:   "",
		Expires: time.Now().Add(-time.Hour),
	})
}
*/

func (*JWTHandler) ValidateAuthTokenCookie(r *http.Request) (bool, error) {
	// Get token from cookies
	cookie, err := r.Cookie("auth_token")
	if err == http.ErrNoCookie || err != nil {
		return false, err
	}
	tokenStr := cookie.Value
	// Generate empty claims and parse token with them
	claims := &claims{}
	tkn, err := jwt.ParseWithClaims(tokenStr, claims,
		func(t *jwt.Token) (interface{}, error) {
			return jwtKey, nil
		},
	)
	// if error exists breaks
	if err != nil {
		return false, err
	}
	// if token is not valid breaks not authorized
	if !tkn.Valid {
		return false, nil
	}
	return true, nil
}
