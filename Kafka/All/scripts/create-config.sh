#!/bin/bash

username="kafka"
password="kafka"


echo "🔖  Creating config folder"
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
mkdir -p $parent_path/../kafka-secrets/config 
cd $parent_path/../kafka-secrets/config 


echo "🔖  Creating Command Properties for accessing Kafka."
cat >./command.properties <<EOL
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="${username}" password="${password}";
security.protocol=SASL_PLAINTEXT
sasl.mechanism=PLAIN
EOL

echo "🔖  Creating Kafka JAAS config."
cat >./kafka.jaas.conf <<EOL
Client {
   org.apache.zookeeper.server.auth.DigestLoginModule required
   username="${username}"
   password="${username}";
};
KafkaServer {
  org.apache.kafka.common.security.plain.PlainLoginModule required
  username="${username}"
  password="${password}"
  user_${username}="${password}";
};
EOL

echo "🔖  Creating Zookeeper JAAS config."
cat >./zookeeper.jaas.conf <<EOL
Server {
   org.apache.kafka.common.security.plain.PlainLoginModule required
   username="${username}"
   password="${password}"
   user_${username}="${username}";
};
EOL

echo "✅  All done."
