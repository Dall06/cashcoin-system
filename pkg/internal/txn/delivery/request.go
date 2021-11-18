package delivery

type POSTTxn struct {
	UUID      string  `json:"txnuuid"`
	LUUID     string  `json:"luuid"`
	ToTxnUUID string  `json:"toTxnuuid"`
	Email     string  `json:"email" validate:"email"`
	Phone     string  `json:"phone"`
	ToAUUID   string  `json:"toAUUID"`
	Amount    float64 `json:"amount"`
	Concept   string  `json:"concept"`
	Reference string  `json:"reference"`
	Country   string  `json:"country"`
	City      string  `json:"city"`
	Estate     string  `json:"estate"`
	Latitude  float64 `json:"lat"`
	Longitude float64 `json:"lon"`
}

type GETTxns struct {
	Email string `json:"email" validate:"email"`
	Phone string `json:"phone"`
}
