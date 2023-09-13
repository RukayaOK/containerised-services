#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Provide the service name"
    exit 1 
fi

export MSYS_NO_PATHCONV=1

# export OPENSSL_CNF=/c/OpenSSL/openssl-1.0.2j-fips-x86_64/OpenSSL/bin/openssl.cnf

service_name=fake_$1

echo "🔖  Creating services secret folder."
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
mkdir -p $parent_path/../kafka-secrets/secrets/services 
cd $parent_path/../kafka-secrets/secrets/services

echo "🔖  Creating certificate for service ${service_name}."
openssl req \
    -newkey rsa:2048 -nodes \
    -keyout ${service_name}_client.key \
    -out ${service_name}_client.csr -days 9999 \
    -subj "/CN=local/OU=Dev/O=Company/L=London/S=LDN/C=UK" \
	-passin pass:$KAFKA_PASSWORD -passout pass:$KAFKA_PASSWORD


echo "🔖  Signing certificate for service ."

openssl x509 -req \
    -CA $parent_path/../kafka-secrets/secrets/fake-ca-1.crt \
    -CAkey $parent_path/../kafka-secrets/secrets/fake-ca-1.key \
    -in ./${service_name}_client.csr \
    -out ./${service_name}_client.crt \
    -days 365 -CAcreateserial \
    -passin pass:$KAFKA_PASSWORD 