default: build

.PHONY: default build

build:
	docker build -t togos/phrebar-deployment-server .

run=docker run -p 80:80 -it togos/phrebar-deployment-server

run:
	${run}

run-interactive:
	${run} /etc/run-da-servers-interactive