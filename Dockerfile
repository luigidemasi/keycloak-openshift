FROM jboss/keycloak-postgres:1.5.0.Final
MAINTAINER Clint Eastwool <clint.eastwool@gmail.com>

# slightly modified from https://github.com/jboss-dockerfiles/keycloak/tree/master/server-ha-postgres

ADD update-standalone-ha.xsl /opt/jboss/keycloak/
RUN java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml -xsl:/opt/jboss/keycloak/update-standalone-ha.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml; rm /opt/jboss/keycloak/update-standalone-ha.xsl

ADD keycloak-server.json /opt/jboss/keycloak/standalone/configuration/
ADD start.sh /opt/jboss/keycloak/bin/
# use import.json, previously obtained from a keycloak server, for initial realm(s)
ADD import.json /opt/jboss/keycloak/
# provide a self signed certificate
ADD keycloak.jks /opt/jboss/keycloak/standalone/configuration/
# provide a cli batch file to configure ssl
ADD configure-security.cli	/opt/jboss/keycloak/bin/

USER root
RUN chmod 755 /opt/jboss/keycloak/bin/start.sh; chown jboss:jboss /opt/jboss/keycloak/bin/start.sh
USER jboss

CMD ["/opt/jboss/keycloak/bin/start.sh"]
