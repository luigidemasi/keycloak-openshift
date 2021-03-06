#!/bin/sh
if [ "x$POSTGRES_SERVICE_SERVICE_HOST" != "x" ]; then
    POSTGRES_PORT_5432_TCP_ADDR=$POSTGRES_SERVICE_SERVICE_HOST
fi
if [ "x$POSTGRES_SERVICE_SERVICE_PORT" != "x" ]; then
    POSTGRES_PORT_5432_TCP_PORT=$POSTGRES_SERVICE_SERVICE_PORT
fi
export POSTGRES_PORT_5432_TCP_ADDR
export POSTGRES_PORT_5432_TCP_PORT


exec /opt/jboss/keycloak/bin/standalone.sh -c standalone-ha.xml -Djboss.node.name=$HOSTNAME -b $HOSTNAME -u 230.0.0.4 \
	-Dkeycloak.migration.action=export \
	-Dkeycloak.migration.provider=singleFile \
	-Dkeycloak.migration.file=/opt/jboss/keycloak/export.json \
	-Dkeycloak.migration.strategy=OVERWRITE_EXISTING
