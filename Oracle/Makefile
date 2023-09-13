
# COMMANDS
.PHONY: help
help:				## Displays the help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build
build:				## Builds the dockerised app without cache.
	sh ./buildContainerImage.sh -v 18.4.0 -x

.PHONY: start
start: ORACLE_PWD 		## Starts the dockerised app
	@docker-compose up -d

.PHONY: stop
stop:						## Stops the dockerised app.
	@docker-compose down

.PHONY: status
status:						## Status of the dockerised app.
	docker ps 


# VALIDATION
ORACLE_PWD:
ifndef ORACLE_PWD
	$(error ORACLE_PWD is undefined)
endif