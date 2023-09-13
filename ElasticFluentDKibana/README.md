# ELASTIC SEARCH, FLUENTD, KIBANA 

## Purpose 

This docker-compose file will spin up an elastic search, fluentd and kibana container on your localhost. 

These containers should be used to support local development only.

Examples:
- https://docs.fluentd.org/v/0.12/articles/docker-logging-efk-compose



---
## Getting Started



1. Build the Docker Image 
    ```
    make build 
    ```
    OR
    ```
    docker-compose build --no-cache
    ```
    > Note: This is a one of exercise (unless you delete this image)



3. Start the Docker Container 
    ```
    make start
    ```
    OR
    ```
    docker-compose up -d
    ```



---

## Test Connection


### Test Outside the Docker Container


1. Set up the index name pattern for Kibana

2. Generate Logs from your Web Server
    ```
    repeat 10 curl http://localhost:80/
    ````

3. Search for logs in kibana 




---
## Using this in a Project

### .NET6

- An example of how to use this in a .NET 6 project can be found 


### Python

- An example of how to use this in a Python project can be found 

---
### Troubleshooting

https://github.com/fluent/fluentd-docs-gitbook/issues/391