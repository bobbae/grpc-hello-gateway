installprotoc:
	apt install -y protobuf-compiler

installprotogen:
	go get google.golang.org/protobuf/cmd/protoc-gen-go@v1.27
	go get google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
	go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

installgrpcgateway:
	go install  github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
	    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
	    google.golang.org/protobuf/cmd/protoc-gen-go \
	    google.golang.org/grpc/cmd/protoc-gen-go-grpc

installgoogleapianno:
	mkdir -p google/api
	curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto > google/api/annotations.proto
	curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto > google/api/http.proto


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

runcurlclient:
	sh -x ./curlclient.sh

installgrpcurl:
	go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
	# brew install grpcurl

installgrpc:
	# for grpc cli
	brew install grpc

rungrpcurlclient:
	sh -x ./grpcurl.sh

httpannotations:
	mkdir -p google/api
	curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto > google/api/annotations.proto
	curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto > google/api/http.proto
