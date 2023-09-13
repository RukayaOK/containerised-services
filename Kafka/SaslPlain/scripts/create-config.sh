#!/bin/bash


function check_environment_variables  {

    variables=(
                KAFKA_USERNAME
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
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="${KAFKA_USERNAME}" password="${KAFKA_PASSWORD}";
security.protocol=SASL_PLAINTEXT
sasl.mechanism=PLAIN
EOL

echo "🔖  Creating Kafka JAAS config."
cat >./kafka.jaas.conf <<EOL
Client {
   org.apache.zookeeper.server.auth.DigestLoginModule required
   username="${KAFKA_USERNAME}"
   password="${KAFKA_PASSWORD}";
};
KafkaServer {
  org.apache.kafka.common.security.plain.PlainLoginModule required
  username="${KAFKA_USERNAME}"
  password="${KAFKA_PASSWORD}"
  user_${KAFKA_USERNAME}="${KAFKA_PASSWORD}";
};
EOL

echo "🔖  Creating Zookeeper JAAS config."
cat >./zookeeper.jaas.conf <<EOL
Server {
   org.apache.kafka.common.security.plain.PlainLoginModule required
   username="${KAFKA_USERNAME}"
   password="${KAFKA_PASSWORD}"
   user_${KAFKA_USERNAME}="${KAFKA_PASSWORD}";
};
EOL

echo "✅  All done."
