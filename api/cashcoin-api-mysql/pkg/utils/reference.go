package utils

func CheckReference(str interface{}) string {
	r := str.(string)

	if r != "" || len(r) > 0 {
		return r
	}
	return generateRandWithLen(24)
}