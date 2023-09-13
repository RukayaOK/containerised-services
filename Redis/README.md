# REDIS

## Purpose 

This docker-compose file will spin up a redis container on your localhost. 

This container should be used to support local development only.

---
## Getting Started

1. Set Enviornment Variables 

    | **Environment Variable**   |  **Purpose**                                         |
    | ---------------------------| -----------------------------------------------------|
    |                            |                                                      | 
    | __REDIS_DB_PASSWORD__      | This is the password for your __Redis__ database     |
    |                            |                                                      |


2. Build the Docker Image 
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



### Test Inside the Docker Container
```
docker exec -it redis bash 
```


### Test Outside the Docker Container

Using the Redis CLI 

Mac:

    redis-cli -h localhost -p 6379 -a $REDIS_DB_PASSWORD

Windows

    rdcli -h localhost -p 6379 -a $REDIS_DB_PASSWORD

---
## Using this in a Project

### .NET6

- An example of how to use this in a .NET 6 project can be found 


### Python

- An example of how to use this in a Python project can be found 
  