# COMMANDS
.PHONY: help
help:						## Displays the help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build
build:						## Builds the dockerised app without cache.
	@docker-compose build --no-cache

.PHONY: start
start:						## Starts the dockerised app.
	make kafka-certs
	make kafka-config
	@docker-compose up -d

.PHONY: stop
stop:						## Stops the dockerised app.
	@docker-compose down

.PHONY: status
status:						## Status of the dockerised app.
	docker ps 

.PHONY: kafka-certs
kafka-certs: KAFKA_PASSWORD			## Creates certificates
	sh ./scripts/create-certs.sh

.PHONY: service-certs
service-certs: KAFKA_PASSWORD SERVICE_NAME		## Creates service certificates
	sh ./scripts/create-service-certs.sh ${SERVICE_NAME}

.PHONY: kafka-config
kafka-config: KAFKA_PASSWORD			## Creates Kafka config
	sh ./scripts/create-config.sh


# VALIDATION
KAFKA_PASSWORD:
ifndef KAFKA_PASSWORD
	$(error KAFKA_PASSWORD is undefined)
endif

SERVICE_NAME:
ifndef SERVICE_NAME
	$(error SERVICE_NAME is undefined)
endif