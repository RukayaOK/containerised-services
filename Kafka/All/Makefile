# COMMANDS
.PHONY: help
help:			## Displays the help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build
build:			## Builds the dockerised app without cache.
	@docker-compose build --no-cache

.PHONY: start
start:			## Starts the dockerised app.
	make kafka-config
	make kafka-certs
	@docker-compose up -d

.PHONY: stop
stop:			## Stops the dockerised app.
	@docker-compose down

.PHONY: status
status:			## Status of the dockerised app.
	docker ps 

.PHONY: kafka-certs
kafka-certs: KAFKA_PASSWORD			## Creates certificates
	sh ./scripts/create-certs.sh

.PHONY: kafka-service-certs
kafka-service-certs: 			## Creates Kafka Certificates for your Service
	sh ./scripts/create-service-certs.sh

.PHONY: kafka-config
kafka-config: KAFKA_USERNAME KAFKA_PASSWORD			## Creates Kafka config
	sh ./scripts/create-config.sh


# VALIDATION
KAFKA_USERNAME:
ifndef KAFKA_USERNAME
	$(error KAFKA_USERNAME is undefined)
endif

KAFKA_PASSWORD:
ifndef KAFKA_PASSWORD
	$(error KAFKA_PASSWORD is undefined)
endif