package usecase

import (
	"fmt"
	"kamata/pkg/empath"
	"mime/multipart"
)

type (
	Result struct {
		Message string
	}
)

func Analyze(file multipart.File) (*Result, error) {
	// call Empath api
	audioResult, err := empath.Analyze(file)
	if err != nil {
		return nil, err
	}

	fmt.Println(audioResult)

	// call AWS api
	// imgResult := aws.Analyze(file)

	// call hiroyuki

	return &Result{"嘘つくのやめてもらっていいですか？"}, nil
}
