
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

## Swagger

The generated helloworld/helloworld.swagger.json can be pasted into https://editor.swagger.io/ and code can be generated for
various languages for client and server side.

# TLS

## Install smallstep

### install step CLI

wget https://dl.step.sm/gh-release/cli/docs-ca-install/v0.18.2/step-cli_0.18.2_amd64.deb

sudo dpkg -i step-cli_0.18.2_amd64.deb

or 

wget -O step.tar.gz https://dl.step.sm/gh-release/cli/docs-ca-install/v0.18.2/step_linux_0.18.2_amd64.tar.gz

tar -xf step.tar.gz

sudo cp step_0.18.2/bin/step /usr/bin

### install step CA


wget https://dl.step.sm/gh-release/certificates/docs-ca-install/v0.18.2/step-ca_0.18.2_amd64.deb

sudo dpkg -i step-ca_0.18.2_amd64.deb

Or

wget -O step-ca.tar.gz https://dl.step.sm/gh-release/certificates/docs-ca-install/v0.18.2/step-ca_linux_0.18.2_amd64.tar.gz

tar -xf step-ca.tar.gz

sudo cp step-ca_0.18.2/bin/step-ca /usr/bin



##  Create X.509 certificates

https://smallstep.com/docs/step-cli/basic-crypto-operations/#create-and-work-with-x509-certificates


### Create root CA

step certificate create --profile root-ca "Example Root CA" root_ca.crt root_ca.key

### Create intermediate CA signed by root CA

step certificate create "Example Intermediate CA 1"     intermediate_ca.crt intermediate_ca.key     --profile intermediate-ca --ca ./root_ca.crt --ca-key ./root_ca.key

### Create a leaf certificate bundle

step certificate create example.com example.com.crt example.com.key --profile leaf --not-after=8760h  --ca ./intermediate_ca.crt --ca-key ./intermediate_ca.key --bundle

### Verify the leaf certificate

step certificate verify example.com.crt --roots root_ca.crt

### install the certificate into the system trust store

step certificate install root_ca.crt

### inspect the leaf certificate

step certificate inspect example.com.crt --short

step certificate inspect example.com.crt --format json | jq -r .validity.end

### inspect any certificate

step certificate inspect https://smallstep.com --format json | jq -r .validity.end

### Get a TLS Certificate From Let's Encrypt using ACME via step CA

step ca certificate example.com example.com.crt example.com.key  --acme https://acme-v02.api.letsencrypt.org/directory


## Initialize and bootstrap step CA

https://smallstep.com/docs/step-ca/getting-started


```
$ step ca init
✔ Deployment Type: Standalone
What would you like to name your new PKI?
✔ (e.g. Smallstep): Example Inc.█
What DNS names or IP addresses would you like to add to your new CA?
✔ (e.g. ca.smallstep.com[,1.1.1.1,etc.]): localhost
What IP and port will your new CA bind to?
✔ (e.g. :443 or 127.0.0.1:443): 127.0.0.1:8443
What would you like to name the CA's first provisioner?
✔ (e.g. you@smallstep.com): bob@example.com
Choose a password for your CA keys and first provisioner.
✔ [leave empty and we'll generate one]:

Generating root certificate... done!
Generating intermediate certificate... done!

✔ Root certificate: /home/bob/.step/certs/root_ca.crt
✔ Root private key: /home/bob/.step/secrets/root_ca_key
✔ Root fingerprint: 36b696fb9832c4fefa934f8ad92dfebd250390bb116a3dfa56dd37b244e42351
✔ Intermediate certificate: /home/bob/.step/certs/intermediate_ca.crt
✔ Intermediate private key: /home/bob/.step/secrets/intermediate_ca_key
✔ Database folder: /home/bob/.step/db
✔ Default configuration: /home/bob/.step/config/defaults.json
✔ Certificate Authority configuration: /home/bob/.step/config/ca.json

Your PKI is ready to go. To generate certificates for individual services see 'step help ca'.

FEEDBACK 😍 🍻
  The step utility is not instrumented for usage statistics. It does not phone
  home. But your feedback is extremely valuable. Any information you can provide
  regarding how you’re using `step` helps. Please send us a sentence or two,
  good or bad at feedback@smallstep.com or join GitHub Discussions
  https://github.com/smallstep/certificates/discussions and our Discord
  https://u.step.sm/discord.



bob@us-1 ~/grpc-hello-gateway$ step-ca $(step path)/config/ca.json
badger 2022/03/18 22:13:24 INFO: All 0 tables opened in 0s
Please enter the password to decrypt /home/bob/.step/secrets/intermediate_ca_key:
2022/03/18 22:13:34 Serving HTTPS on 127.0.0.1:8443 ...



```

### accessing CA and bootstrap

```
$ step certificate fingerprint $(step path)/certs/root_ca.crt
36b696fb9832c4fefa934f8ad92dfebd250390bb116a3dfa56dd37b244e42351


$ step ca bootstrap --ca-url localhost:8443 --fingerprint 36b696fb9832c4fefa934f8ad92dfebd250390bb116a3dfa56dd37b244e42351
⚠️  It looks like step is already configured to connect to an authority.
You can use 'contexts' to easily switch between teams and authorities.
Learn more at https://smallstep.com/docs/step-cli/the-step-command#contexts.

✔ Would you like to overwrite /home/bob/.step/certs/root_ca.crt [y/n]: y
The root certificate has been saved in /home/bob/.step/certs/root_ca.crt.
✔ Would you like to overwrite /home/bob/.step/config/defaults.json [y/n]: y
The authority configuration has been saved in /home/bob/.step/config/defaults.json.

```

The step command will now trust your CA.


### establish system-wide trust of your CA

So your certificates will be trusted by curl and other programs.

step certificate install $(step path)/certs/root_ca.crt


### ask the CA for a certificate  and private key 

```
$ step ca certificate localhost srv.crt srv.key
✔ Provisioner: bob@example.com (JWK) [kid: JhF08PmY4z3QWCVvtMiAIN_CJvmdMpIkpTcVQOzDJe0]
Please enter the password to decrypt the provisioner key:
✔ CA: https://localhost:8443
✔ Certificate: srv.crt
✔ Private Key: srv.key
```


### Run a test server with the certificate

go run testcert/main.go &

### Access the test server

```
$ curl https://localhost:9443/hi
Hello, world!
```

Because the root_ca.crt is installed as system-wide trust of CA already.

If this was not the case, you have to get root certificate and pass to the client.


```
$ step ca root root.crt
$ curl --cacert root.crt https://localhost:9443/hi
Hello, world!
```



