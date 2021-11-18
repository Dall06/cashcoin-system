package account

type Client struct {
	UUID       string
	Name       string
	LastName   string
	Occupation string
}

type Address struct {
	UUID          string
	Country       string
	City          string
	Estate         string
	Street        string
	BuldingNumber int
	PostalCode    string
}

type Account struct {
	UUID     string
	Client   Client
	Address  Address
	Email    string
	Phone    string
	Password string
	Balance  float64
	Status string
	Clabe string
}
