TAG=latest

all: build test

build: build-minimal build-minimal-java

build-minimal:
	docker build -t philip/minimal:$(TAG) minimal/

build-minimal-java:
	docker build --progress=plain -t philip/minimal-java:$(TAG) minimal-java/

test: test-minimal test-minimal-java

test-minimal:
	docker run --rm philip/minimal:$(TAG) cat /etc/os-release
	docker run --rm philip/minimal:$(TAG)

test-minimal-java:
	docker run -it --rm -e APP_ENV2=FromMakefile philip/minimal-java:$(TAG) ArgFromMakefile

push:
	docker login "$(DOCKER_REGISTRY)" -u "$(DOCKER_USER)" -p "$(DOCKER_TOKEN)"
	docker tag philip/minimal "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	docker tag philip/minimal-java "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal-java"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal-java"
	docker logout "$(DOCKER_REGISTRY)"

clean:
	docker rmi -f philip/minimal:$(TAG)      2> /dev/null || true
	docker rmi -f philip/minimal-java:$(TAG) 2> /dev/null || true

