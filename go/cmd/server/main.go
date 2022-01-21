package main

import (
	"encoding/json"
	"fmt"
	"kamata/pkg/usecase"
	"log"
	"net/http"
)

const port = "9000"

type (
	HiroyukiResponse struct {
		Hello string `json:"hello"`
	}
)

func main() {
	http.HandleFunc("/analyze", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			w.WriteHeader(http.StatusMethodNotAllowed)
			w.Write([]byte("Invalid Request Method"))
			return
		}

		file, _, err := r.FormFile("file")
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			w.Write([]byte(fmt.Sprintf("FormFile Error: %s", err.Error())))
			return
		}
		defer file.Close()

		result, err := usecase.Analyze(file)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			w.Write([]byte(fmt.Sprintf("Internal Error: %s", err.Error())))
			return
		}
		res, err := json.Marshal(result)

		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			w.Write([]byte(fmt.Sprintf("Internal Error: %s", err.Error())))
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(res)
	})

	fmt.Printf("🚀 Server Started %s port\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
