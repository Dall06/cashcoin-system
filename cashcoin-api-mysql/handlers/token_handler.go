package handlers

import (
	"net/http"
	"time"

	"github.com/Dall06/cashcoin-api-mysql/middleware"
	"github.com/Dall06/cashcoin-api-mysql/models"
	"github.com/dgrijalva/jwt-go"
)

func SetTokenCookie(user models.UserAccount, w http.ResponseWriter) {
	expirationTime := time.Now().Add(time.Minute * 5)
	// Setting up token
	claims := &middleware.Clamis{
		Email: user.Email,
		// ID: user.ID,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString(middleware.JwtKey)
	// if error when creating token retunr Internal Server Error
	if err != nil {
		RespondWithInternalServerError(err, w)
		return
	}
	// Set cookie
	http.SetCookie(w, &http.Cookie{
		Name:    "token",
		Value:   tokenString,
		Expires: expirationTime,
	})
	return
}

func RefreshTokenCookie(w http.ResponseWriter, r *http.Request) {
	expirationTime := time.Now().Add(time.Minute * 5)
	//  get token cookie value
	cookie, err := r.Cookie("token")
	if err == http.ErrNoCookie {
		RespondWithNonAuthorized(r, w)
		return
	}
	if err != nil {
		RespondWithBadRequest(r, w)
		return
	}
	tokenStr := cookie.Value
	// setting claims up and generate token
	claims := &middleware.Clamis{
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}
	token, err := jwt.ParseWithClaims(tokenStr, claims,
		func(t *jwt.Token) (interface{}, error) {
			return middleware.JwtKey, nil
		},
	)
	// if error is equals to the error signature from jwt braks
	if err == jwt.ErrSignatureInvalid {
		RespondWithNonAuthorized(r, w)
		return
	}
	// if error exists it breaks then
	if err != nil {
		RespondWithBadRequest(r, w)
		return
	}
	// if token is not valid respond authorization and then re flow continues
	if !token.Valid {
		RespondWithNonAuthorized(r, w)
		// return
	}
	// Generate new token
	newToken := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := newToken.SignedString(middleware.JwtKey)
	// if error exists when creating new token send error
	if err != nil {
		RespondWithInternalServerError(r, w)
		return
	}
	// Set new Cookie, then finishes
	http.SetCookie(w,
		&http.Cookie{
			Name:    "token",
			Value:   tokenString,
			Expires: expirationTime,
		},
	)
}

func CleanTokenCookie(w http.ResponseWriter) {
	// Cleans your t=cookie in the 'token' field
	http.SetCookie(w, &http.Cookie{
		Name:    "token",
		Value:   "",
		Expires: time.Now().Add(-time.Hour),
	})
}

func ValidateTokenCookie(w http.ResponseWriter, r *http.Request) bool {
	// Get token from cookies
	cookie, err := r.Cookie("token")
	if err == http.ErrNoCookie {
		w.WriteHeader(http.StatusUnauthorized)
		return false
	} 
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return false
	}
	tokenStr := cookie.Value
	// Generate empty claims and parse token with them
	claims := &middleware.Clamis{}
	tkn, err := jwt.ParseWithClaims(tokenStr, claims,
		func(t *jwt.Token) (interface{}, error) {
			return middleware.JwtKey, nil
		},
	)
	// if error is equals to invalid signature breaks
	if err == jwt.ErrSignatureInvalid {
		RespondWithNonAuthorized(err, w)
		return false
	}
	// if error exists breaks
	if err != nil {
		RespondWithBadRequest(err, w)
		return false
	}
	// if token is not valid breaks not authorized
	if !tkn.Valid {
		RespondWithNonAuthorized("Bad token", w)
		return false
	}
	RespondWithSuccess(true, w)
	return true
	// No response added, if error happens it just gopnna break
	// Response with success
}
