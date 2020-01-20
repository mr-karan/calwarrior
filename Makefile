.PHONY : deps build run

VERSION := $(shell git describe)

# Dependencies.
deps:
	yarn install

# Build steps.
build:
	yarn build

# Run server.
run:
	yarn serve

# Build Docker

build-docker: build
	docker build -t mrkaran/calwarrior:latest -t mrkaran/calwarrior:${VERSION} .

# Run docker

run-docker:
	docker run -p 8080:80 mrkaran/calwarrior:latest

push-docker:
	docker push mrkaran/calwarrior:latest
	docker push mrkaran/calwarrior:${VERSION}