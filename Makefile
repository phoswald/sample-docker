TAG=latest

all: build test

build: build-minimal build-jre-25 build-builder

build-minimal:
	docker build -t minimal:$(TAG) minimal/

build-jre-25:
	docker build -t jre-25:$(TAG) jre-25/

build-builder:
	docker build -t builder:$(TAG) builder/

test:
	@echo "Testing ..."
	@docker run --rm minimal:$(TAG) cat /etc/os-release
	@docker run --rm minimal:$(TAG)
	@docker run --rm jre-25:$(TAG) java -version
	@docker run --rm builder:$(TAG) node --version 
	@docker run --rm builder:$(TAG) java -version
	@docker run --rm builder:$(TAG) javac -version
	@docker run --rm builder:$(TAG) mvn -version
	@docker run --rm builder:$(TAG) docker --version

push:
	@echo "Login to $(DOCKER_REGISTRY) as $(DOCKER_USER) ..."
	@docker login "$(DOCKER_REGISTRY)" -u "$(DOCKER_USER)" -p "$(DOCKER_TOKEN)"
	@echo "Tagging ..."
	@docker tag minimal "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	@docker tag jre-25  "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	@docker tag builder "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	@echo "Pushing to $(DOCKER_REGISTRY) ..."
	@docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	@docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	@docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	@echo "Cleanup ..."
	@docker logout "$(DOCKER_REGISTRY)"
	@docker rmi "$(DOCKER_REGISTRY)/$(DOCKER_USER)/minimal"
	@docker rmi "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	@docker rmi "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	@echo "Done."

clean:
	@docker rmi -f minimal:$(TAG) 2> /dev/null || true
	@docker rmi -f jre-25:$(TAG)  2> /dev/null || true
	@docker rmi -f builder:$(TAG) 2> /dev/null || true
