#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Provide the service name"
    exit 1 
fi

service_name=fake_$1
TLD="local"
PASSWORD="kafkasecret"

echo "🔖  Creating services secret folder."
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
mkdir -p $parent_path/../kafka-secrets/secrets/services 
cd $parent_path/../kafka-secrets/secrets/services

echo "🔖  Creating certificate for service ${service_name}."
openssl req \
    -newkey rsa:2048 -nodes \
    -keyout ${service_name}_client.key \
    -out ${service_name}_client.csr -days 9999 \
    -subj "/CN=${TLD}/OU=Company/O=Dev/L=London/S=LDN/C=UK" \
	-passin pass:$PASSWORD -passout pass:$PASSWORD


echo "🔖  Signing certificate for service ."
openssl x509 -req \
    -CA $parent_path/../kafka-secrets/certs/fake-ca-1.crt \
    -CAkey $parent_path/../kafka-secrets/certs/fake-ca-1.key \
    -in ./${service_name}_client.csr \
    -out ./${service_name}_client.crt \
    -days 365 -CAcreateserial \
    -passin pass:$PASSWORD 