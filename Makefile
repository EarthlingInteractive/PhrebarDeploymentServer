default: build

.PHONY: default build

build:
	docker build -t togos/phrebar-deployment-server .

publish: build
	docker push togos/phrebar-deployment-server

run=docker run -p 80:80 -it togos/phrebar-deployment-server

run: build
	${run}

run-shell: build
	${run} /bin/bash
