package empath

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"net/url"
	"os"
	"strings"

	"github.com/joho/godotenv"
)

type (
	Result struct {
		Message string
	}

	Response struct {
		Error  string `json:"error"`
		Calm   string `json:"calm"`
		Anger  string `json:"anger"`
		Joy    string `json:"joy"`
		Sorrow string `json:"sorrow"`
		Energy string `json:"energy"`
	}
)

const (
	URI string = "'https://api.webempath.net/v2/analyzeWav'"
)

func Analyze(file multipart.File) (*Result, error) {
	err := godotenv.Load(".env")
	if err != nil {
		fmt.Printf("could not read env file: %v", err)
	}
	apiKey := os.Getenv("EMPATH_API_KEY")

	f, err := ioutil.ReadAll(file)
	if err != nil {
		return nil, err
	}

	r, err := empath_api(f, apiKey)
	if err != nil {
		return nil, err
	}
	fmt.Println(r)

	return &Result{Message: "empath"}, nil
}

func empath_api(file []byte, apiKey string) (response *Response, err error) {
	values := url.Values{}
	values.Set("apikey", apiKey)
	values.Set("wav", string(file))

	req, err := http.NewRequest("POST", URI, strings.NewReader(values.Encode()))
	if err != nil {
		return nil, err
	}

	client := new(http.Client)
	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var r Response
	if err := json.Unmarshal(body, &r); err != nil {
		return nil, err
	}

	return &r, nil
}
