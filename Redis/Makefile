
# COMMANDS
.PHONY: help
help:				## Displays the help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build
build:				## Builds the dockerised app without cache.
	@docker-compose build --no-cache

.PHONY: start
start: REDIS_DB_PASSWORD	## Starts the dockerised app. [Requires: REDIS_DB_PASSWORD]
	@docker-compose up -d

.PHONY: stop
stop:				## Stops the dockerised app.
	@docker-compose down

.PHONY: status
status:				## Status of the dockerised app.
	docker ps 


# VALIDATION
REDIS_DB_PASSWORD:
ifndef REDIS_DB_PASSWORD
	$(error REDIS_DB_PASSWORD is undefined)
endif
