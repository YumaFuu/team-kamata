# 嘘つくのやめてもらっていいですか？

## reactサーバー起動
```bash
$ cd frontend
$ npm start

```
## goサーバー起動
```bash
$ cd go
$ go run cmd/server/main.go
$ curl -XPOST -F file=@./static/sample.mp4 http://localhost:9000/analyze
```
