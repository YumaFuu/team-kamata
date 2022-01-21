package usecase

import "mime/multipart"

type (
	Result struct {
		Message string
	}
)

func Analyze(file multipart.File) Result {
	// call Empath api
	// audioResult := empath.Analyze(file)

	// call AWS api
	// imgResult := aws.Analyze(file)

	// call hiroyuki

	return Result{"嘘つくのやめてもらっていいですか？"}
}
