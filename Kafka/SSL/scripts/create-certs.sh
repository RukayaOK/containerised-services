#!/bin/bash
set -euf -o pipefail


function check_environment_variables  {

    variables=(
                KAFKA_PASSWORD
               )

    for variable in "${variables[@]}"
    do
    if [[ -z ${!variable+x} ]]; then
        echo "var $variable is unset";
        exit 1
    fi
    done

}

export MSYS_NO_PATHCONV=1

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
	-subj "/CN=ca1.local/OU=Dev/O=TestCompant/L=London/S=LDN/C=UK" \
	-passin pass:$KAFKA_PASSWORD -passout pass:$KAFKA_PASSWORD

# Add additional brokers here
for i in broker; do
	echo ${i}

	# Create keystores
	echo "🔖  Creating keystores."
	keytool -genkey -noprompt \
		-alias ${i} \
		-dname "CN=${i}.local, OU=CIA, O=REA, L=Melbourne, S=VIC, C=AU" \
		-keystore kafka.${i}.keystore.jks \
		-keyalg RSA \
		-storepass $KAFKA_PASSWORD \
		-keypass $KAFKA_PASSWORD

	echo "🔖  Creating CSR, sign the key and import back into keystore"
	keytool -keystore kafka.$i.keystore.jks -alias $i -certreq -file $i.csr -storepass $KAFKA_PASSWORD -keypass $KAFKA_PASSWORD

	openssl x509 -req -CA fake-ca-1.crt -CAkey fake-ca-1.key -in $i.csr -out $i-ca1-signed.crt -days 9999 -CAcreateserial -passin pass:$KAFKA_PASSWORD

	keytool -keystore kafka.$i.keystore.jks -alias CARoot -import -file fake-ca-1.crt -storepass $KAFKA_PASSWORD -keypass $KAFKA_PASSWORD

	keytool -keystore kafka.$i.keystore.jks -alias $i -import -file $i-ca1-signed.crt -storepass $KAFKA_PASSWORD -keypass $KAFKA_PASSWORD

	# Create truststore and import the CA cert.
	keytool -keystore kafka.$i.truststore.jks -alias CARoot -import -file fake-ca-1.crt -storepass $KAFKA_PASSWORD -keypass $KAFKA_PASSWORD

	echo $KAFKA_PASSWORD >${i}_sslkey_creds
	echo $KAFKA_PASSWORD >${i}_keystore_creds
	echo $KAFKA_PASSWORD >${i}_truststore_creds
done

echo "✅  All done."
