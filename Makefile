GOPATH := $(shell pwd)/vendor:$(shell pwd):$(shell echo $$GOPATH)
PATH := $(PATH):$(shell echo $$GOPATH/bin)
GOBIN := $(shell pwd)/bin
GOFILES := $(shell go list ./... | grep -v /vendor/ | grep -v _extra)
GOFLAGS="-mod=mod"

.PHONY: all
all: test

.PHONY: test
test: clean generate
	@mkdir -p ./.bin/
	@export GOFLAGS=$(GOFLAGS); go test -v ./... -cover -coverprofile=./.bin/coverage.out
	@sudo rm -rf vendor/

.PHONY: test-coverage-view
test-coverage-view: test generate
	@export GOFLAGS=$(GOFLAGS); go tool cover -html=./.bin/coverage.out

.PHONY: clean
clean:
	@rm -rf ./.bin/
	@sudo rm -rf graph/generated
	@sudo rm -rf graph/model
	@sudo rm -rf vendor/

.PHONY: run
run: clean generate
	@mkdir -p ./.bin/
	@export GOFLAGS=$(GOFLAGS); go run server.go
	@sudo rm -rf vendor/

.PHONY: build
build: clean generate
	@mkdir -p ./.bin/
	@export GOFLAGS=$(GOFLAGS); go build -o .bin/server server.go
	@sudo rm -rf vendor/

.PHONY: image
image: clean
	@mkdir -p ./.bin/
	docker build -t graphql-golang .
	@sudo rm -rf vendor/


.PHONY: reset
reset: clean
	@export GOFLAGS=$(GOFLAGS); go get .

.PHONY: deps
deps:
	@go install github.com/99designs/gqlgen@latest

.PHONY: upgrade
upgrade:
	go get -u
	go mod tidy
	@sudo rm -rf vendor/
	# go get -u ./...


.PHONY: generate
generate:
	@sudo rm -rf vendor/
	@sudo rm -rf graph/generated
	@sudo rm -rf graph/model
	@export GOFLAGS=$(GOFLAGS); go run github.com/99designs/gqlgen generate
	@sudo rm -rf vendor/