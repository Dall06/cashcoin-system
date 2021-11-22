package delivery

type POSTTxn struct {
	WUUID     string  `json:"p_w_txnuuid"`
	DUUID     string  `json:"p_d_txnuuid"`
	AUUID     string  `json:"auuid"`
	LUUID     string  `json:"luuid"`
	Reference string  `json:"reference"`
	Email     string  `json:"email" validate:"email"`
	Phone     string  `json:"phone"`
	ToAUUID   string  `json:"toAUUID"`
	Amount    float64 `json:"amount"`
	Concept   string  `json:"concept"`
	Country   string  `json:"country"`
	City      string  `json:"city"`
	Estate    string  `json:"estate"`
	Latitude  float64 `json:"lat"`
	Longitude float64 `json:"lon"`
}
