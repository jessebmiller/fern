.PHONY: dev
dev:
	-docker network create fern-state-dev
	-docker stop pg
	docker run --rm --name pg -d --net fern-state-dev postgres
	sleep 5
	docker run -it --rm --net fern-state-dev postgres psql -h pg -U postgres

