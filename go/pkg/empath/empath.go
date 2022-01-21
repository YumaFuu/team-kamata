package main

import (
	"fmt"
	"os"

	"github.com/joho/godotenv"
)

func main() {
	loadEnv()
}

func loadEnv() {
	err := godotenv.Load(".env")
	if err != nil {
		fmt.Printf("読み込み出来ませんでした: %v", err)
	}

	message := os.Getenv("EMPATH_API_KEY")
	fmt.Println(message)
}
