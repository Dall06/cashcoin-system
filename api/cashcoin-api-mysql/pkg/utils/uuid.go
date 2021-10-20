package utils

import (
	"fmt"

	"github.com/google/uuid"
)

func generateUUID() string { 
	return uuid.New().String()
}

func CheckAndReturn(str interface{}) string {
	uid := str.(string)

	if uid != "" || len(uid) > 0 {
		fmt.Println("REQUEST WITH UUID INCLUDED!!!", uid)
		return uid
	}
	return generateUUID()
}