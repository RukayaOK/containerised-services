
# COMMANDS
.PHONY: help
help:				## Displays the help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build
build:				## Builds the dockerised app without cache.
	@docker-compose build --no-cache

.PHONY: start
start: 	## Starts the dockerised app. 
	@docker-compose up -d

.PHONY: stop
stop:				## Stops the dockerised app.
	@docker-compose down

.PHONY: status
status:				## Status of the dockerised app.
	docker ps 



