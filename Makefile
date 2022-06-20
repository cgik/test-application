all: test build

test:
	go test ./...

up:
	docker-compose -f docker-compose.yaml build
	docker-compose -f docker-compose.yaml up

build:
	cd pkg/; \
	go build -o server . 

dev: build
	pkg/server

e2e:
	tests/e2e-test.sh DIR=$(shell pwd)