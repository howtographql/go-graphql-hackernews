GOFLAGS="-mod=mod"

clean:
	@rm -rf ./.bin/
	@sudo rm -rf vendor/
	@mkdir ./.bin/

generate: clean
	@sudo rm -rf graph/generated
	@sudo rm -rf graph/model
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go run github.com/99designs/gqlgen generate

test: generate
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go test -v ./...

run: test
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go run server.go
	
build: generate
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go build -o ./.bin/server server.go

image: generate
	docker build -t graphql-golang .

get: clean
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go get .

deps:
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go install github.com/99designs/gqlgen@latest

update: clean
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go get -u; go mod tidy