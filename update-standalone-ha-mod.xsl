<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:variable name="jboss" select="'urn:jboss:domain:'" />
	<xsl:variable name="ispn" select="'urn:jboss:domain:infinispan:'" />
	<xsl:variable name="undertow" select="'urn:jboss:domain:undertow:'" />
	<xsl:variable name="newInfinispan">
		<cache-container name="keycloak" jndi-name="infinispan/Keycloak" start="EAGER">
			<transport lock-timeout="60000" />
			<invalidation-cache name="realms" mode="SYNC" />
			<invalidation-cache name="users" mode="SYNC" />
			<distributed-cache name="sessions" mode="SYNC" owners="1" />
			<distributed-cache name="loginFailures" mode="SYNC" owners="1" />
		</cache-container>
	</xsl:variable>
	
	<xsl:variable name="newRealm">
		<security-realm name="UndertowRealm">
			<server-identities>
				<ssl>
					<keystore path="keycloak.jks" relative-to="jboss.server.config.dir" keystore-password="secret" />
				</ssl>
			</server-identities>
		</security-realm>
	</xsl:variable>
	
	<xsl:template match="//*[local-name()='subsystem' and starts-with(namespace-uri(), $ispn)]">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
		<xsl:copy-of select="$newInfinispan" />
	</xsl:template>
	
	<!-- Prevent duplicates ? -->
	<xsl:template match="//*[local-name()='management' and starts-with(namespace-uri(), $jboss)]/*[local-name()='security-realms']">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
		<xsl:copy-of select="$newRealm" />
	</xsl:template>
	
	<!-- match="//*[local-name()='management' and starts-with(namespace-uri(), $jboss)] -->
	<!-- /*[local-name()='security-realms']"> -->
	<!-- <xsl:copy> -->
	<!-- <xsl:apply-templates select="node()|@*" /> -->
	<!-- <xsl:copy-of select="$newInfinispan" /> -->
	<!-- </xsl:copy> -->
	<!-- </xsl:template> -->
	<!-- <xsl:template match="//ispn:subsystem"> -->
	<!-- <xsl:copy> -->
	<!-- <xsl:apply-templates select="node()|@*" /> -->
	<!-- <cache-container name="keycloak" jndi-name="infinispan/Keycloak" start="EAGER"> -->
	<!-- <transport lock-timeout="60000" /> -->
	<!-- <invalidation-cache name="realms" mode="SYNC" /> -->
	<!-- <invalidation-cache name="users" mode="SYNC" /> -->
	<!-- <distributed-cache name="sessions" mode="SYNC" owners="1" /> -->
	<!-- <distributed-cache name="loginFailures" mode="SYNC" owners="1" /> -->
	<!-- </cache-container> -->
	<!-- </xsl:copy> -->
	<!-- </xsl:template> -->
	<!-- <xsl:template match="//management/security-realms"> -->
	<!-- <xsl:copy> -->
	<!-- <xsl:apply-templates select="node()|@*" /> -->
	<!-- <security-realm name="UndertowRealm"> -->
	<!-- <server-identities> -->
	<!-- <ssl> -->
	<!-- <keystore path="keycloak.jks" relative-to="jboss.server.config.dir" keystore-password="secret" /> -->
	<!-- </ssl> -->
	<!-- </server-identities> -->
	<!-- </security-realm> -->
	<!-- </xsl:copy> -->
	<!-- </xsl:template> -->
	<!-- <xsl:template match="//undertow:subsystem"> -->
	<!-- <xsl:copy> -->
	<!-- <xsl:apply-templates select="node()|@*" /> -->
	<!-- <https-listener name="https" socket-binding="https" security-realm="UndertowRealm"/> -->
	<!-- </xsl:copy> -->
	<!-- </xsl:template> -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>