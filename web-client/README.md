
## HTTP POST example

index-post.html and test-post.js

## GRPC-WEB example

Install npm packages in parent directory

```
cd ..; npm install
```

Build web pack

```
browserify client.js -o bundle.js
```

Be sure server is running before
```
cd ..; go run server/main.go  
```

Install envoy and run it.
```
brew install envoy 
envoy -c envoy.yaml
```

https://www.envoyproxy.io/docs/envoy/latest/start/install


Envoy translates HHTP/1.1 calls produced by browser client into HTTP/2 used by gRPC.

And open index-client.html file from brower.
Type name into box and click send button.



