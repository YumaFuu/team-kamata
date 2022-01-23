package empath

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"os"

	"github.com/joho/godotenv"
)

type (
	Result struct {
		Message  string
		Response Response
	}

	Response struct {
		Error  int64 `json:"error"`
		Calm   int64 `json:"calm"`
		Anger  int64 `json:"anger"`
		Joy    int64 `json:"joy"`
		Sorrow int64 `json:"sorrow"`
		Energy int64 `json:"energy"`
	}

	Request struct {
		APIKey string         `json:"apikey"`
		Wav    multipart.File `json:"wav"`
	}
)

const (
	URI string = "https://api.webempath.net/v2/analyzeWav"
)

func Analyze(file multipart.File) (*Result, error) {
	err := godotenv.Load(".env")
	if err != nil {
		fmt.Printf("could not read env file: %v", err)
	}
	apiKey := os.Getenv("EMPATH_API_KEY")

	r, err := empath_api(file, apiKey)
	if err != nil {
		return nil, err
	}
	fmt.Println(r)

	return &Result{Message: "empath", Response: *r}, nil
}

func empath_api(file multipart.File, apiKey string) (response *Response, err error) {
	req := Request{APIKey: apiKey, Wav: file}
	j, err := json.Marshal(req)
	if err != nil {
		fmt.Println("here1")
		return nil, err
	}

	res, err := http.Post(URI, "application/json", bytes.NewBuffer(j))
	if err != nil {
		fmt.Println("here2")
		return nil, err
	}

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		fmt.Println("here3")
		return nil, err
	}

	var r Response
	if err := json.Unmarshal(body, &r); err != nil {
		fmt.Println("here3")
		return nil, err
	}

	return &r, nil
}
