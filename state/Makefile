.PHONY: dev
dev: build/image build/postgres
	docker run -it --rm --net fern-state-dev -v `pwd`:/app fern-state:dev pipenv shell

build/postgres: build build/network
	-docker stop pg
	docker run --rm --name pg -d --net fern-state-dev postgres
	sleep 5
	touch build/postgres

build/network: build
	-docker network create fern-state-dev
	touch build/network

build/image: build Dockerfile Pipfile Pipfile.lock
	docker build -t fern-state:dev .
	touch build/image

build:
	mkdir build

.PHONY: clean
clean:
	rm -rf build
