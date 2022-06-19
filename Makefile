all: test build

test:
	go test ./...

up:
	docker-compose -f docker-compose.yaml build
	docker-compose -f docker-compose.yaml up

build:
	cd pkg/; \
	go build -o server . 