# KAFKA - PLAINTEXT AUTHENTICATION

## Purpose 

This docker-compose file will spin up a Kafak container on your localhost with plaintext authentication (no username, password or certificate needed). 

This container should be used to support local development only.

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

2. Start the Docker Container 
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
docker exec -it broker bash 
```

```
/usr/bin/kafka-topics.sh --list --zookeeper zookeeper:2181
```

### Test Outside the Docker Container

Using Kcat
```
kcat -b localhost:9092 -L
```

---
## Using this in a Project

### .NET6

- An example of how to use this in a .NET 6 project can be found 


### Python

- An example of how to use this in a Python project can be found 


