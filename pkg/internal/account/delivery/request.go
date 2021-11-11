package delivery

type ReqCreate struct {
	UUID		string `json:"AUUID"`
	CUUID		string `json:"CUUID"`
	ADDUUID		string `json:"ADDUUID"`
	Email         string `json:"email" validate:"required,email"`
	Phone         string `json:"phone"`
	Password      string `json:"password" validate:"required"`
	Clabe          string `json:"clabe"`
	City          string `json:"city" validate:"required"`
	State         string `json:"state" validate:"required"`
	Street        string `json:"street" validate:"required"`
	BuldingNumber int    `json:"bnum" validate:"required"`
	Country       string `json:"country" validate:"required"`
	PostalCode    string `json:"pc" validate:"required"`
	Name          string `json:"name" validate:"required"`
	LastName      string `json:"lastName" validate:"required"`
	Occupation    string `json:"occupation" validate:"required"`
}

type ReqStatus struct {
	Email  string `json:"email" validate:"email"`
	Phone  string `json:"phone"`
	Status string `json:"status" validate:"required"`
}

type ReqAccount struct {
	Email    string `json:"email" validate:"email"`
	Phone    string `json:"phone"`
	NewEmail string `json:"newEmail"`
	NewPhone string `json:"newPhone"`
	Password string `json:"password" validate:"required"`
}

type ReqPassword struct {
	Email       string `json:"email" validate:"email"`
	Phone       string `json:"phone"`
	Password    string `json:"password" validate:"required"`
	NewPassword string `json:"newPassword" validate:"required"`
}

type ReqAddress struct {
	Email         string `json:"email" validate:"email"`
	Phone         string `json:"phone"`
	City          string `json:"city" validate:"required"`
	State         string `json:"state" validate:"required"`
	Street        string `json:"street" validate:"required"`
	BuldingNumber int    `json:"bnum" validate:"required"`
	Country       string `json:"country" validate:"required"`
	PostalCode    string `json:"pc" validate:"required"`
}

type ReqPersonal struct {
	Email      string `json:"email" validate:"required,email"`
	Phone      string `json:"phone"`
	Name       string `json:"name" validate:"required"`
	LastName   string `json:"lastName" validate:"required"`
	Occupation string `json:"occupation" validate:"required"`
}

type ReqIndex struct {
	Email string `json:"email" validate:"email"`
	Phone string `json:"phone"`
}


