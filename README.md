
# grpc-hello-gateway


https://grpc-ecosystem.github.io/grpc-gateway/docs/tutorials/introduction/

## Installing protoc


https://grpc.io/docs/protoc-installation/

apt install -y protobuf-compiler

## Installing protoc-gen-go and protoc-gen-go-grpc


go get google.golang.org/protobuf/cmd/protoc-gen-go@v1.27
go get google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger


export PATH="$PATH:$(go env GOPATH)/bin"


## Basic grpc information


https://grpc.io/docs/languages/go/quickstart/

https://grpc.io/docs/languages/go/basics/

## Grpc gateway information


https://github.com/grpc-ecosystem/grpc-gateway

https://grpc-ecosystem.github.io/grpc-gateway/docs/tutorials/introduction/


## Installing grpc-gatewaystuff

$ go install \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
    google.golang.org/protobuf/cmd/protoc-gen-go \
    google.golang.org/grpc/cmd/protoc-gen-go-grpc

## Locally installing google/api/annotations stuff


mkdir -p google/api
curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto > google/api/annotations.proto
curl https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto > google/api/http.proto

## Makefile targets

### genproto

Strictly grpc code generation

### genprotogateway

Generate grpc stubs as well as HTTP API stubs

## Needed code changes for HTTP API

The added code is marked with `ADD` comments in helloworld/helloworld.proto and server/main.go


