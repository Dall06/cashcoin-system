package delivery

type POSTTxn struct {
	WUUID     string  `json:"p_w_txnuuid"`
	DUUID     string  `json:"p_d_txnuuid"`
	LUUID     string  `json:"luuid"`
	AUUID     string  `json:"auuid"`
	Reference string  `json:"reference"`
	ToAUUID   string  `json:"toAUUID"`
	Amount    float64 `json:"amount"`
	Concept   string  `json:"concept"`
	Country   string  `json:"country"`
	City      string  `json:"city"`
	Estate    string  `json:"estate"`
	Latitude  float64 `json:"lat"`
	Longitude float64 `json:"lon"`
}
