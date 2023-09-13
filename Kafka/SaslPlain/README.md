# KAFKA - SASL PLAIN AUTHENTICATION

## Purpose 

This docker-compose file will spin up a Kafka container on your localhost with sasl plain authentication (authenticate with username and password). 

This container should be used to support local development only.

Examples: 
- https://github.com/confluentinc/kafka-images/tree/master/examples
- https://github.com/vdesabou/kafka-docker-playground/tree/master/environment



---
## Getting Started

1. Set Enviornment Variables 

    | **Environment Variable**   |  **Purpose**                                         |
    | ---------------------------| -----------------------------------------------------|
    |                            |                                                      | 
    | __KAFKA_USERNAME__         | This is the username for your kafka cluster          |
    | __KAFKA_PASSWORD__         | This is the password for your kafka cluster          |


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
    sh ./scripts/create-config.sh
    docker-compose up -d
    ```

---

## Test Connection

### Test Inside the Docker Container
```
docker exec -it broker bash 
```

```
/usr/bin/kafka-topics --list --bootstrap-server localhost:9092 --command-config /etc/kafka/command.properties
```

### Test Outside the Docker Container

Using Kcat
```
kcat -b localhost:9092 \
    -X security.protocol=sasl_plaintext -X sasl.mechanisms=PLAIN \
    -X sasl.username="${KAFKA_USERNAME}" -X sasl.password="${KAFKA_PASSWORD}"  \
    -L
```

---
## Using this in a Project

### .NET6

- An example of how to use this in a .NET 6 project can be found 


### Python

- An example of how to use this in a Python project can be found 


