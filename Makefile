TAG=latest

all: build test

build: build-minimal

build-minimal:
	docker build -t minimal:$(TAG) minimal/

test:
	docker run --rm minimal:$(TAG) cat /etc/os-release
	docker run --rm minimal:$(TAG)

push:
	docker login "$(DOCKER_REGISTRY)" -u "$(DOCKER_USER)" -p "$(DOCKER_TOKEN)"
	docker tag minimal "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	docker logout "$(DOCKER_REGISTRY)"
	docker rmi "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"

clean:
	docker rmi -f minimal:$(TAG) 2> /dev/null || true
