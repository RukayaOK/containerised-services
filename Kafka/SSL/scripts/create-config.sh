#!/bin/bash


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

echo "🔖  Checking environmnet variables"
check_environment_variables

echo "🔖  Creating config folder"
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
rm -rf $parent_path/../kafka-secrets/config
sleep 2

mkdir -p $parent_path/../kafka-secrets/config 
cd $parent_path/../kafka-secrets/config 


echo "🔖  Creating Command Properties for accessing Kafka."
cat >./command.properties <<EOL
request.timeout.ms=20000
retry.backoff.ms=500
security.protocol=SSL
ssl.truststore.location=/etc/kafka/secrets/kafka.control-center.truststore.jks
ssl.keystore.location=/etc/kafka/secrets/kafka.control-center.keystore.jks
ssl.truststore.password=${KAFKA_PASSWORD}
ssl.keystore.password=${KAFKA_PASSWORD}
ssl.key.password=${KAFKA_PASSWORD}
ssl.endpoint.identification.algorithm=
EOL


echo "✅  All done."
