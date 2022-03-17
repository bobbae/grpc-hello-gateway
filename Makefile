genproto:
	protoc -I . --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative helloworld/helloworld.proto

genprotogateway:
	protoc -I . --go-grpc_out=. --go-grpc_opt=paths=source_relative --grpc-gateway_out=.  --grpc-gateway_opt=paths=source_relative  helloworld/helloworld.proto

genswagger:
	protoc -I . --swagger_out=.  helloworld/helloworld.proto

modtidy:
	go mod tidy

runserver:
	go run server/main.go

runclient:
	sh -x ./curlclient.sh

httpannotations:
	mkdir -p google/api
	curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto > google/api/annotations.proto
	curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto > google/api/http.proto
