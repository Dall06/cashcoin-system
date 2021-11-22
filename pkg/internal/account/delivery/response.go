package delivery

type client struct {
	Name string `json:"name" validate:"required"`
	LastName string `json:"lname" validate:"required"`
}

type address struct {
	City string `json:"city" validate:"required"`
	Estate string `json:"state" validate:"required"`
	Country string `json:"country" validate:"required"`
}

type Account struct {
	UUID string `json:"auuid" validate:"required"`
	Email string `json:"email" validate:"required"`
	Phone string `json:"phone"`
	Balance float64 `json:"balance" validate:"required"`
	Status string `json:"status" validate:"required"`
	Clabe string `json:"clabe" validate:"required"`
	Address address `json:"address"`
	Client client `json:"client"`
}