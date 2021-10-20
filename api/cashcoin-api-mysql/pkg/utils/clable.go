package utils

import "fmt"

func GenerateClabe(str interface{}) string {
	c := str.(string)

	if c != "" || len(c) > 0 {
		fmt.Println("REQUEST WITH UUID INCLUDED!!!", c)
		return c
	}

	id := "31198315914"
	rs := generateRandWithLen(6)
	s := id + rs
	return s
}