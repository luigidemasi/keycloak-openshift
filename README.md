# keycloak-openshift
Create a keycloak/postgres cluster on openshift origin using kubernetes

This is based on the example in https://github.com/jboss-dockerfiles/keycloak/tree/master/server-ha-postgres.

Some adjustments have been made, e.g. creating a .yaml representation of the keycloak-kube.json file 
given in the example using apiVersion: v1.

