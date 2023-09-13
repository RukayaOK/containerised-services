# KAFKA - SSL AUTHENTICATION

## Purpose 

This docker-compose file will spin up a Kafka container on your localhost with SSL authentication (authenticate with certificate). 

This container should be used to support local development only.

Examples: 
- https://github.com/confluentinc/kafka-images/tree/master/examples
- https://github.com/vdesabou/kafka-docker-playground/tree/master/environment
- https://github.com/LGouellec/kafka-dotnet-ssl
- https://github.com/cloud-on-prem/kafka-docker-ssl


---
## Getting Started

1. Install keytool 

(a) Install Java JDK [here](https://www.oracle.com/java/technologies/downloads/#jdk18-windows) 

(b) Add the path of the JDK to your environment variables. Example path:

    Mac OS 

        /usr/bin 
        
    Windows 

        C:\Program Files\Java\jdk-18.0.2.1\bin

2. Create the certificates

    ```
    make certs 
    ```
    OR
    ```
    sh ./scripts/create-certs.sh
    ```



3. Build the Docker Image 
    ```
    make build 
    ```
    OR
    ```
    docker-compose build --no-cache
    ```
    > Note: This is a one of exercise (unless you delete this image)



4. Start the Docker Container 
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

2. Create a kafka topic 
    ```
    /usr/bin/kafka-topics --create \
        --bootstrap-server localhost:9092 \
        --topic my-topic \
        --command-config /etc/kafka/config/command.properties
    ```

3. List the kafka topic 
    ```
    /usr/bin/kafka-topics --list \
        --bootstrap-server localhost:9092 \
        --command-config /etc/kafka/config/command.properties
    ```


### Test Outside the Docker Container

1. Create a certificate for your service 

    (a) Make a directory for your service certificates 

        mkdir kafka-secrets/services
    
    (b) Create a private key / public key certificate pair for the service client
        
        openssl req -newkey rsa:2048 -nodes -keyout kafka-secrets/services/service1_client.key -out kafka-secrets/services/service1_client.csr 


    (b) Now you have the CSR, you can generate a CA signed certificate as follows

        openssl x509 -req -CA secrets/fake-ca-1.crt -CAkey kafka-secrets/fake-ca-1.key -in kafka-secrets/services/service1_client.csr -out secrets/services/service1_client.crt -days 365 -CAcreateserial

2. Connect
   
    Using Kcat

        kcat -b localhost:9092 -X security.protocol=SSL -X ssl.key.location=secrets/services/service1_client.key \
            -X ssl.key.password=kafkapassword -X ssl.certificate.location=secrets/services/service1_client.crt \
            -X ssl.ca.location=secrets/fake-ca-1.crt -X ssl.endpoint.identification.algorithm=none \
            -L 

---
## Using this in a Project

### .NET6

- An example of how to use this in a .NET 6 project can be found 


### Python

- An example of how to use this in a Python project can be found 




