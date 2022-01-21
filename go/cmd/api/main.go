package main

import (
	"fmt"
	"log"
	"net/http"
)

const port = "9000"

func main() {
	fmt.Printf("🚀 Server Started %s port\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
