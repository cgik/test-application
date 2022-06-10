FROM golang:1.18.2-alpine3.16 AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download && go mod verify

COPY app/*.go ./
RUN go build -o .

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/http-reverse ./

EXPOSE 9999
CMD ["/app/http-reverse"]