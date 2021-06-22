package handlers

import (
	"encoding/json"
	"net/http"
)

func RespondWithSuccess(data interface{}, w http.ResponseWriter) {
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(data)
}

func RespondWithAuthorized(data interface{}, w http.ResponseWriter) {
	w.WriteHeader(http.StatusAccepted)
	json.NewEncoder(w).Encode(data)
}

func RespondWithNonAuthorized(data interface{}, w http.ResponseWriter) {
	w.WriteHeader(http.StatusUnauthorized)
	json.NewEncoder(w).Encode(data)
}

func RespondWithInternalServerError(data interface{}, w http.ResponseWriter) {
	w.WriteHeader(http.StatusInternalServerError)
	json.NewEncoder(w).Encode(data)
}

func RespondWithBadRequest(data interface{}, w http.ResponseWriter) {
	w.WriteHeader(http.StatusBadRequest)
	json.NewEncoder(w).Encode(data)
}