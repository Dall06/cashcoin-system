package utils

import (
	"crypto/rand"
	"fmt"
)

func generateRandWithLen(slen int) string {
	n := slen / 2
	b := make([]byte, n)
	if _, err := rand.Read(b); err != nil {
		panic(err)
	}
	s := fmt.Sprintf("%X", b)
	return s
}