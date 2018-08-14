all: help

RUN_CMD=docker run -dt --name functions-emulator -p 8010:8010 gcloud-functions-emulator /bin/bash -c
EXEC_CMD=docker exec functions-emulator /bin/bash -c
CONF_FOLDER=.docker
CONF_FILE=$(CONF_FOLDER)/config.json

build-src:
	npm run build

build-image:
	-rm $(CONF_FILE)
	mkdir -p $(CONF_FOLDER)
	@echo '{"bindHost": "0.0.0.0", "logFile": "/dev/null", "projectId": "$(GCLOUD_PROJECT)"}' > $(CONF_FILE)
	docker build -t gcloud-functions-emulator .

build: build-src build-image

clean:
	-docker stop functions-emulator
	-docker rm functions-emulator

help: build
	$(RUN_CMD) functions --help

deploy: clean build
	$(RUN_CMD) "functions start --tail"
	sleep 2
	$(EXEC_CMD) "functions deploy helloWorld --trigger-http"
