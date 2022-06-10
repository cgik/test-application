FROM golang:1.18.2-alpine3.16 AS builder

WORKDIR /app

COPY app/go.mod ./
COPY app/go.sum ./

RUN go mod download && go mod verify
RUN go test

COPY app/*.go .
RUN go build -o . 

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/http-reverse ./

EXPOSE 9999
CMD ["/app/http-reverse"]