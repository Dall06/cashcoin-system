package utils

import (
	"crypto/sha256"
	"fmt"
)

func HashRequestSToken(t string) string {
	return fmt.Sprintf("%x", sha256.Sum256([]byte(t)))
}