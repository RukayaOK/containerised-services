#!/bin/bash
set -euf -o pipefail

TLD="local"
PASSWORD="kafkasecret"

echo "🔖  Creating secrets folder."
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
rm -rf $parent_path/../kafka-secrets/secrets
mkdir -p $parent_path/../kafka-secrets/secrets 
cd $parent_path/../kafka-secrets/secrets 

echo "🔖  Generating some fake certificates and other secrets."
echo "⚠️  Remember to type in \"yes\" for all prompts."
sleep 2

# Generate CA key
echo "🔖  Generating CA key."
openssl req -new -x509 -keyout fake-ca-1.key \
	-out fake-ca-1.crt -days 9999 \
	-subj "/CN=ca1.${TLD}/OU=CIA/O=REA/L=Melbourne/S=VIC/C=AU" \
	-passin pass:$PASSWORD -passout pass:$PASSWORD

# Add additional brokers here
for i in broker; do
	echo ${i}

	# Create keystores
	echo "🔖  Creating keystores."
	keytool -genkey -noprompt \
		-alias ${i} \
		-dname "CN=${i}.${TLD}, OU=CIA, O=REA, L=Melbourne, S=VIC, C=AU" \
		-keystore kafka.${i}.keystore.jks \
		-keyalg RSA \
		-storepass $PASSWORD \
		-keypass $PASSWORD

	echo "🔖  Creating CSR, sign the key and import back into keystore"
	keytool -keystore kafka.$i.keystore.jks -alias $i -certreq -file $i.csr -storepass $PASSWORD -keypass $PASSWORD

	openssl x509 -req -CA fake-ca-1.crt -CAkey fake-ca-1.key -in $i.csr -out $i-ca1-signed.crt -days 9999 -CAcreateserial -passin pass:$PASSWORD

	keytool -keystore kafka.$i.keystore.jks -alias CARoot -import -file fake-ca-1.crt -storepass $PASSWORD -keypass $PASSWORD

	keytool -keystore kafka.$i.keystore.jks -alias $i -import -file $i-ca1-signed.crt -storepass $PASSWORD -keypass $PASSWORD

	# Create truststore and import the CA cert.
	keytool -keystore kafka.$i.truststore.jks -alias CARoot -import -file fake-ca-1.crt -storepass $PASSWORD -keypass $PASSWORD

	echo $PASSWORD >${i}_sslkey_creds
	echo $PASSWORD >${i}_keystore_creds
	echo $PASSWORD >${i}_truststore_creds
done

echo "✅  All done."
