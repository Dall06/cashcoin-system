package delivery

type ReqCreate struct {
	AUUID         string `json:"auuid"`
	CUUID         string `json:"cuuid"`
	ADDUUID       string `json:"adduuid"`
	Email         string `json:"email" validate:"required,email"`
	Phone         string `json:"phone"`
	Password      string `json:"password" validate:"required"`
	Clabe         string `json:"clabe"`
	City          string `json:"city" validate:"required"`
	Estate        string `json:"estate" validate:"required"`
	Street        string `json:"street" validate:"required"`
	BuldingNumber int    `json:"bnum" validate:"required"`
	Country       string `json:"country" validate:"required"`
	PostalCode    string `json:"pc" validate:"required"`
	Name          string `json:"name" validate:"required"`
	LastName      string `json:"lname" validate:"required"`
	Occupation    string `json:"occupation" validate:"required"`
}

type ReqStatus struct {
	AUUID  string `json:"auuid" validate:"required"`
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
	AUUID         string `json:"auuid" validate:"required"`
	City          string `json:"city" validate:"required"`
	Estate        string `json:"estate" validate:"required"`
	Street        string `json:"street" validate:"required"`
	BuldingNumber int    `json:"bnum" validate:"required"`
	Country       string `json:"country" validate:"required"`
	PostalCode    string `json:"pc" validate:"required"`
}

type ReqPersonal struct {
	AUUID      string `json:"auuid" validate:"required"`
	Name       string `json:"name" validate:"required"`
	LastName   string `json:"lname" validate:"required"`
	Occupation string `json:"occupation" validate:"required"`
}

type ReqIndex struct {
	AUUID string `json:"auuid" validate:"required"`
}
