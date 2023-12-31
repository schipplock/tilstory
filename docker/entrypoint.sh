#!/bin/bash
JBOSS_MODULES_SYSTEM_PKGS="org.jboss.byteman"
JBOSS_JAVA_SIZING="-Xms${Xms:-64m} -Xmx${Xmx:-512m} -XX:MetaspaceSize=${MetaspaceSize:-96m} -XX:MaxMetaspaceSize=${MaxMetaspaceSize:-256m}"
JAVA_OPTS="$JBOSS_JAVA_SIZING -Djava.net.preferIPv4Stack=true"
JAVA_OPTS="$JAVA_OPTS -Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS -Djava.awt.headless=true"

if [ "${REMOTE_DEBUG_ENABLED}" = "true" ]; then
  export JAVA_OPTS="${JAVA_OPTS} -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=0.0.0.0:8000"
fi

WILDFLY_OPTS="-Djboss.tx.node.id=${WILDFLY_NODE_ID:-4711}"

sed -i "s/%POSTGRES_HOST%/${POSTGRES_HOST:-localhost}/g" \
 $JBOSS_HOME/standalone/configuration/standalone.xml

sed -i "s/%POSTGRES_PORT%/${POSTGRES_PORT:-5432}/g" \
 $JBOSS_HOME/standalone/configuration/standalone.xml

sed -i "s/%POSTGRES_DB%/${POSTGRES_DB:-tilstory}/g" \
 $JBOSS_HOME/standalone/configuration/standalone.xml

sed -i "s/%POSTGRES_USER%/${POSTGRES_USER:-tilstory}/g" \
 $JBOSS_HOME/standalone/configuration/standalone.xml

POSTGRES_PASSWORD="$(cat ${POSTGRES_PASSWORD_FILE})"
sed -i "s/%POSTGRES_PASSWORD%/${POSTGRES_PASSWORD:-tilstory}/g" \
 $JBOSS_HOME/standalone/configuration/standalone.xml

KEYSTORE_PASSWORD="$(cat ${KEYSTORE_PASSWORD_FILE})"
sed -i "s/%KEYSTORE_PASSWORD%/${KEYSTORE_PASSWORD:-password}/g" \
 $JBOSS_HOME/standalone/configuration/standalone.xml

/opt/jboss/wildfly/bin/standalone.sh ${WILDFLY_OPTS} -b 0.0.0.0