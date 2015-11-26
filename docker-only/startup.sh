#!/bin/sh
sudo docker run --name postgres -e POSTGRES_DATABASE=keycloak -e POSTGRES_USER=keycloak -e POSTGRES_PASSWORD=password -e POSTGRES_ROOT_PASSWORD=root_password -d postgres

// eine Dockerfile mit ssl 
<security-realm name="UndertowRealm">
        <server-identities>
            <ssl>
                <keystore path="localhost.jks" relative-to="jboss.server.config.dir" keystore-password="secret" alias="localhost" />
            </ssl>
        </server-identities>
</security-realm>

ins undertow subelement:
<https-listener name="https" socket-binding="https" security-realm="UndertowRealm"/>



sudo docker run --name keycloak -p 8180:8080 -p 8543:8433 --link postgres:postgres jboss/keycloak-postgres

