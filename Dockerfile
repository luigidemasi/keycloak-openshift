FROM jboss/keycloak-postgres:latest
MAINTAINER Clint Eastwool <clint.eastwool@gmail.com>

# slightly modified from https://github.com/jboss-dockerfiles/keycloak/tree/master/server-ha-postgres

##ADD update-standalone-ha.xsl /opt/jboss/keycloak/
##RUN java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml -xsl:/opt/jboss/keycloak/update-standalone-ha.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml; rm /opt/jboss/keycloak/update-standalone-ha.xsl

#USER root
#RUN yum install -y mc && yum clean all
#USER jboss
#ENV TERM xterm

# ADD keycloak-server.json /opt/jboss/keycloak/standalone/configuration/
ADD start.sh /opt/jboss/keycloak/bin/
# use import.json, previously obtained from a keycloak server, for initial realm(s)
ADD import.json /opt/jboss/keycloak/
# provide a self signed certificate
ADD keycloak.jks /opt/jboss/keycloak/standalone/configuration/
ADD root_ca.cer /opt/jboss/keycloak/standalone/configuration/

USER root
RUN chmod 755 /opt/jboss/keycloak/bin/start.sh; chown jboss:jboss /opt/jboss/keycloak/bin/start.sh
USER jboss

EXPOSE 8443
EXPOSE 9990
EXPOSE 9993

## CMD ["/opt/jboss/keycloak/bin/start.sh" "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

CMD ["/opt/jboss/keycloak/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
