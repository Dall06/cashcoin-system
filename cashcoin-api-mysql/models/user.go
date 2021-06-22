package models

type UserAccount struct {
	ID int64 `json:"accountId"`
	Email string `json:"email"`
	Password string `json:"password"`
	Phone string `'json:"phone"`
}

type UserData struct {
	ID int64 `json:"id"`
	Name string `json:"name"`
	LastName string `json:"lastName"`
	Code string `'json:"code"`
	Balance float64 `'json:"balance"`
	UserAccount UserAccount `json:"account"`
}

type UserPassUpdate struct {
	UserAccount UserAccount `json:"currentAccount"`
	NewPassword string `json:"newPassword"`
}