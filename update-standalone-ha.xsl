<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                              ertow="urn:jboss:domain:undertow:2.0"
                              xmlns:ispn="urn:jboss:domain:infinispan:3.0">
	<!-- Changes for using ssl -->
	<xsl:output method="xml" indent="yes" />
<!-- 	<xsl:variable name="newRealm"> -->
<!-- 		<security-realm xmlns="urn:jboss:domain:3.0" name="UndertowRealm"> -->
<!-- 			<server-identities> -->
<!-- 				<ssl> -->
<!-- 					<keystore path="keycloak.jks" relative-to="jboss.server.config.dir" alias="keycloak" keystore-password="secret" /> -->
<!-- 				</ssl> -->
<!-- 			</server-identities> -->
<!-- 		</security-realm> -->
<!-- 	</xsl:variable> -->
<!-- 	<xsl:variable name="newHttpsListener"> -->
<!-- 		<https-listener xmlns="urn:jboss:domain:undertow:2.0" name="https" socket-binding="https" security-realm="UndertowRealm" /> -->
<!-- 	</xsl:variable> -->
<!-- 	<xsl:template match="//*[local-name()='management']/*[local-name()='security-realms']"> -->
<!-- 		<xsl:copy> -->
<!-- 			<xsl:apply-templates select="@*|node()" /> -->
<!-- 			<xsl:copy-of copy-namespaces="no" select="$newRealm" /> -->
<!-- 		</xsl:copy> -->
<!-- 	</xsl:template> -->
<!-- 	<!-- <xsl:template match="//*[local-name()='subsystem' and starts-with(namespace-uri(),$undertow)]"> --> -->
<!-- 	<xsl:template match="//undertow:server[@name='default-server']"> -->
<!-- 		<xsl:copy> -->
<!-- 			<xsl:apply-templates select="node()|@*" /> -->
<!-- 			<xsl:copy-of copy-namespaces="no" select="$newHttpsListener" /> -->
<!-- 		</xsl:copy> -->
<!-- 	</xsl:template> -->
	<xsl:template match="//ispn:subsystem">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
			<cache-container name="keycloak" jndi-name="infinispan/Keycloak" start="EAGER">
				<transport lock-timeout="60000" />
				<invalidation-cache name="realms" mode="SYNC" />
				<invalidation-cache name="users" mode="SYNC" />
				<distributed-cache name="sessions" mode="SYNC" owners="1" />
				<distributed-cache name="loginFailures" mode="SYNC" owners="1" />
			</cache-container>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>