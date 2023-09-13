# COMMANDS
.PHONY: help
help:											## Displays the help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build
build:											## Builds the dockerised app without cache.
	@docker-compose build --no-cache

.PHONY: start
start: SA_PASSWORD APPLICATION_DB APPLICATION_DB_USER APPLICATION_DB_PASSWORD		## Starts the dockerised app
	@docker-compose up -d

.PHONY: stop
stop:											## Stops the dockerised app.
	@docker-compose down

.PHONY: status
status:											## Status of the dockerised app.
	docker ps 

.PHONY: database
database: SA_PASSWORD 									## Creates database tables 
	docker exec -it sql-server-db /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '$(SA_PASSWORD)' -i /usr/config/scripts/setup.sql


# VALIDATION
SA_PASSWORD:
ifndef SA_PASSWORD
	$(error SA_PASSWORD is undefined)
endif

APPLICATION_DB:
ifndef APPLICATION_DB
	$(error APPLICATION_DB is undefined)
endif

APPLICATION_DB_USER:
ifndef APPLICATION_DB_USER
	$(error APPLICATION_DB_USER is undefined)
endif

APPLICATION_DB_PASSWORD:
ifndef APPLICATION_DB_PASSWORD
	$(error APPLICATION_DB_PASSWORD is undefined)
endif