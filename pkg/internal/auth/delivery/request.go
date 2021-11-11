package delivery

// Request
type Request struct {
	Email    string `json:"email"`
	Phone    string `json:"phone"`
	Password string `json:"password" validate:"required"`
}


