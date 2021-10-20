package config

import (
	"crypto/sha256"
	"fmt"
	"os"

	"github.com/joho/godotenv"
)

var _ = godotenv.Load(".env") // Cargar del archivo llamado ".env"

var (
	ConnectionString = fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true", //"<user>:<password>@tcp(127.0.0.1:3306)/<dbname>"
		os.Getenv("USER_DB"),
		os.Getenv("PASSWORD_DB"),
		os.Getenv("HOST_DB"),
		os.Getenv("PORT_DB"),
		os.Getenv("NAME_DB"))
	SecretPassword = fmt.Sprint(os.Getenv("SECRET_JWT"))
	envSToken = fmt.Sprintf(os.Getenv("SESSION_TOKEN"))
	SessionToken = fmt.Sprintf("%x", sha256.Sum256([]byte(envSToken)))
)
