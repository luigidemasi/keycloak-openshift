#!/bin/sh
if [ "x$POSTGRES_SERVICE_SERVICE_HOST" != "x" ]; then
    POSTGRES_PORT_5432_TCP_ADDR=$POSTGRES_SERVICE_SERVICE_HOST
fi
if [ "x$POSTGRES_SERVICE_SERVICE_PORT" != "x" ]; then
    POSTGRES_PORT_5432_TCP_PORT=$POSTGRES_SERVICE_SERVICE_PORT
fi
export POSTGRES_PORT_5432_TCP_ADDR
export POSTGRES_PORT_5432_TCP_PORT

# echo "Parameter: $TEST_PARAM" > /opt/jboss/keycloak/start_sh_test_parameter

# use this for export
#exec /opt/jboss/keycloak/bin/standalone.sh -c standalone-ha.xml -Djboss.node.name=$HOSTNAME -b $HOSTNAME -u 230.0.0.4 \
#-Dkeycloak.migration.action=export \
#-Dkeycloak.migration.provider=singleFile \
#-Dkeycloak.migration.file=/opt/jboss/keycloak/export.json \
#-Dkeycloak.migration.strategy=OVERWRITE_EXISTING

# use this for import the demo realm
#exec /opt/jboss/keycloak/bin/standalone.sh -c standalone-ha.xml -Djboss.node.name=$HOSTNAME -b $HOSTNAME -u 230.0.0.4 \
#-Dkeycloak.migration.action=import \
#-Dkeycloak.migration.provider=singleFile \
#-Dkeycloak.migration.file=/opt/jboss/keycloak/import.json \
#-Dkeycloak.migration.realmName=demo \
#-Dkeycloak.migration.strategy=IGNORE_EXISTING

exec /opt/jboss/keycloak/bin/standalone.sh -c standalone-ha.xml -Djboss.node.name=$HOSTNAME -b $HOSTNAME -u 230.0.0.4

# configure SSL using self signed certificate and jboss-cli.sh
# exec /opt/jboss/keycloak/bin/jboss-cli.sh --connect --file=configure-security.cli

# mal den einfachen Start von keycloak und ssl probieren