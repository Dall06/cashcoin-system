package delivery

type GETAAuth struct {
	Email    string `json:"email"`
	Phone    string `json:"phone"`
	Password string `json:"password" validate:"required"`
}
