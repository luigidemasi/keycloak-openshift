<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ds="urn:jboss:domain:datasources:2.0"
    xmlns:undertow="urn:jboss:domain:undertow:2.0"
	xmlns:ispn="urn:jboss:domain:infinispan:3.0">
	<xsl:output method="xml" indent="yes" />
	
<!-- 	<xsl:template match="//ispn:subsystem"> -->
<!-- 		<xsl:copy> -->
<!-- 			<xsl:apply-templates select="node()|@*" /> -->
<!-- 			<cache-container name="keycloak" jndi-name="infinispan/Keycloak" start="EAGER"> -->
<!-- 				<transport lock-timeout="60000" /> -->
<!-- 				<invalidation-cache name="realms" mode="SYNC" /> -->
<!-- 				<invalidation-cache name="users" mode="SYNC" /> -->
<!-- 				<distributed-cache name="sessions" mode="SYNC" owners="1" /> -->
<!-- 				<distributed-cache name="loginFailures" mode="SYNC" owners="1" /> -->
<!-- 			</cache-container> -->
<!-- 		</xsl:copy> -->
<!-- 	</xsl:template> -->
	
<!-- 	<xsl:template match="//management/security-realms"> -->
<!-- 		<xsl:copy> -->
<!-- 			<xsl:apply-templates select="node()|@*" /> -->
<!-- 			<security-realm name="UndertowRealm"> -->
<!-- 				<server-identities> -->
<!-- 					<ssl> -->
<!-- 						<keystore path="keycloak.jks" relative-to="jboss.server.config.dir" keystore-password="secret" /> -->
<!-- 					</ssl> -->
<!-- 				</server-identities> -->
<!-- 			</security-realm> -->
<!-- 		</xsl:copy> -->
<!-- 	</xsl:template> -->
	
<!-- 	<xsl:template match="//undertow:subsystem"> -->
<!-- 		<xsl:copy> -->
<!-- 			<xsl:apply-templates select="node()|@*" /> -->
<!-- 			<https-listener name="https" socket-binding="https" security-realm="UndertowRealm"/> -->
<!-- 		</xsl:copy> -->
<!-- 	</xsl:template> -->
	
	
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>