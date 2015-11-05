#!/bin/bash

# Usage: execute.sh [JBOSS_HOME] [WildFly mode] [configuration file]
#
# The default mode is 'standalone' and default configuration is based on the
# mode. It can be 'standalone.xml' or 'domain.xml'.
#
# from https://github.com/goldmann/wildfly-docker-configuration/tree/master/cli

JBOSS_HOME=${1:-"/opt/jboss/keycloak"}
JBOSS_MODE=${2:-"standalone"}
JBOSS_CONFIG=${3:-"$JBOSS_MODE.xml"}

JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh

# slightly modfied by testing for keycloak-server.war deployment
function wait_for_server() {
  until `$JBOSS_CLI -c --command="ls /deployment" | grep -q "keycloak-server.war"`; do
    echo "wait 1 sec..."
    sleep 1
  done
}

#function wait_for_server() {
#  $JBOSS_CLI --version
#  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
#  # until `$JBOSS_CLI --version`; do
#    # echo "wait 1 sec..."
#    sleep 1
#  done
#}

if [ "x$POSTGRES_SERVICE_SERVICE_HOST" != "x" ]; then
    POSTGRES_PORT_5432_TCP_ADDR=$POSTGRES_SERVICE_SERVICE_HOST
fi
if [ "x$POSTGRES_SERVICE_SERVICE_PORT" != "x" ]; then
    POSTGRES_PORT_5432_TCP_PORT=$POSTGRES_SERVICE_SERVICE_PORT
fi
export POSTGRES_PORT_5432_TCP_ADDR
export POSTGRES_PORT_5432_TCP_PORT

echo "=> Starting WildFly server"
# $JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG > /dev/null &
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG -Djboss.node.name=$HOSTNAME -b $HOSTNAME

echo "=> Waiting for the server to boot"
wait_for_server

$JBOSS_CLI -c --command="ls /deployment"

echo "=> Executing the commands"
$JBOSS_CLI -c --file=`dirname "$0"`/commands.cli

echo "=> Shutting down WildFly"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi