package middleware

import "github.com/dgrijalva/jwt-go"

// SECRET PASSWORD FOR THE TOKENS
var JwtKey = []byte("secret_password")

type Clamis struct {
	Email string `json:"email"`
	// ID int64 `json:"id"`
	jwt.StandardClaims
}
