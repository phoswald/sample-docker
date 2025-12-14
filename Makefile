TAG=latest

all: build test

build: build-minimal

build-minimal:
	docker build -t philip/minimal:$(TAG) minimal/

test:
	docker run --rm philip/minimal:$(TAG) cat /etc/os-release
	docker run --rm philip/minimal:$(TAG)

push:
	docker login "$(DOCKER_REGISTRY)" -u "$(DOCKER_USER)" -p "$(DOCKER_TOKEN)"
	docker tag philip/minimal "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	docker logout "$(DOCKER_REGISTRY)"

clean:
	docker rmi -f philip/minimal:$(TAG) 2> /dev/null || true
