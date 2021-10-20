package auth

type Client struct {
	Name     string
	LastName string
}

type Address struct {
	City    string
	State   string
	Country string
}

type Account struct {
	UUID     string
	Email    string
	Phone    string
	Clabe    string
	Password string
	Balance  float64
	Status   string
	Client   Client
	Address  Address
}
