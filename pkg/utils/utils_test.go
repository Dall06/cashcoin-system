package utils_test

import (
	"fmt"
	"testing"

	"github.com/Dall06/cashcoin-api-mysql/pkg/utils"
)

func TestHashRequestSToken(t *testing.T) {
	tkn := utils.HashRequestSToken("SECRET")
	if len(tkn) < 36 {
		t.Fatal("err lenght")
	}
}

func TestCheckReference(t *testing.T) {
	ref := utils.CheckReference("9D03C95643B187537840568E")
	if len(ref) < 24 {
		fmt.Println("lenght", len(ref))
		t.Fatal("err lenght")
	}
}

func TestCheckAndReturn(t *testing.T) {
	uid := utils.CheckAndReturn("")
	if len(uid) < 36 {
		t.Fatal("err lenght")
	}
}

func TestCheckAndReturnNotEmpty(t *testing.T) {
	var aux = "7bea678c-2f09-4e69-ad09-8ec87820f30e"
	uid := utils.CheckAndReturn(aux)
	if uid != aux {
		t.Fatal("err lenght")
	}
}