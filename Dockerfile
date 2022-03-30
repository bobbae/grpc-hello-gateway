FROM golang:alpine as build

WORKDIR /app
COPY . .

RUN go build -o /app/hello-server server/main.go

FROM alpine

WORKDIR /app
COPY --from=build /app/hello-server /app/hello-server

EXPOSE 8080 8090

CMD ["/app/hello-server"]