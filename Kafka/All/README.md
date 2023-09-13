# KAFKA - PLAIN, SASL AND SSL AUTHENTICATION

## Purpose 

This docker-compose file will spin up a Kafka container on your localhost with Plaintext, SASL (authentication with username and password) and SSL authentication (authenticate with certificate). 

This container should be used to support local development only.

Examples: 
- https://github.com/confluentinc/kafka-images/tree/master/examples
- https://github.com/vdesabou/kafka-docker-playground/tree/master/environment
- https://github.com/LGouellec/kafka-dotnet-ssl
- https://github.com/cloud-on-prem/kafka-docker-ssl



---
## Getting Started

1. Set Enviornment Variables 

    | **Environment Variable**   |  **Purpose**                                         |
    | ---------------------------| -----------------------------------------------------|
    |                            |                                                      | 
    | __KAFKA_USERNAME__         | This is the username for your kafka cluster          |
    | __KAFKA_PASSWORD__         | This is the password for your kafka cluster          |


2. Create the certificates

    ```
    make certs 
    ```
    OR
    ```
    sh ./scripts/create-certs.sh
    ```

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

1. Start an interactive bash session inside the container
    ```
    docker exec -it broker bash 
    ```

2. Connect

    Plain 

    ```
    /usr/bin/kafka-topics.sh --list --zookeeper zookeeper:2181
    ```

    SASL 
    ```
    /usr/bin/kafka-topics --list --bootstrap-server localhost:9093 --command-config /etc/kafka/command.properties
    ```

    SSL
    
    (a) Create a kafka topic 
    ```
    /usr/bin/kafka-topics --create \
        --bootstrap-server localhost:9092 \
        --topic my-topic \
        --command-config /etc/kafka/config/command.properties
    ```

    (b) List the kafka topic 
    ```
    /usr/bin/kafka-topics --list \
        --bootstrap-server localhost:9092 \
        --command-config /etc/kafka/config/command.properties
    ```


### Test Outside the Docker Container

1. Create a certificate for your service 

    (a) Make a directory for your service certificates 

        mkdir secrets/services
    
    (b) Create a private key / public key certificate pair for the service client
        
        openssl req -newkey rsa:2048 -nodes -keyout secrets/services/service1_client.key -out secrets/services/service1_client.csr 


    (b) Now you have the CSR, you can generate a CA signed certificate as follows

        openssl x509 -req -CA secrets/fake-ca-1.crt -CAkey secrets/fake-ca-1.key -in secrets/services/service1_client.csr -out secrets/services/service1_client.crt -days 365 -CAcreateserial

2. Connect
   
    Using Kcat

    Plaintext

        kcat -b localhost:9092 -L

    SASL

        kcat -b localhost:9092 \
            -X security.protocol=sasl_plaintext -X sasl.mechanisms=PLAIN \
            -X sasl.username="kafka" -X sasl.password="kafka"  \
            -L

    SSL

        kcat -b localhost:19092 -X security.protocol=SSL -X ssl.key.location=secrets/services/service1_client.key \
            -X ssl.key.password=kafkapassword -X ssl.certificate.location=secrets/services/service1_client.crt \
            -X ssl.ca.location=secrets/fake-ca-1.crt -X ssl.endpoint.identification.algorithm=none \
            -L 


---
## Using this in a Project

### .NET

- An example of how to use this in a .NET 6 project can be found [here](../../Examples/dotnet/docker-compose/Kafka/SSL)

