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

installgrpcweb:
	wget https://github.com/grpc/grpc-web/releases/download/1.3.1/protoc-gen-grpc-web-1.3.1-darwin-x86_64
	sudo cp protoc-gen-grpc-web-1.3.1-darwin-x86_64 /usr/local/bin/protoc-gen-grpc-web
	sudo chmod +x /usr/local/bin/protoc-gen-grpc-web
	# wget https://github.com/grpc/grpc-web/releases/download/1.3.1/protoc-gen-grpc-web-1.3.1-linux-x86_64
	# sudo cp protoc-gen-grpc-web-1.3.1-linux-x86_64 /usr/local/bin/protoc-gen-grpc-web

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


genprotoweb:
	protoc -I . --js_out=import_style=commonjs:. helloworld/helloworld.proto
	protoc -I . --grpc-web_out=import_style=commonjs,mode=grpcwebtext:. helloworld/helloworld.proto
	#protoc -I . --js_out=import_style=commonjs:. google/api/annotations.proto
	#protoc -I . --js_out=import_style=commonjs:. google/api/http.proto

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

dockerbuild:
	docker build -t hello-gateway .

dockerrun:
	docker run -p 8080:8080 -p 8090:8090 hello-gateway 


