<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	
	<xsl:variable name="jboss" select="'urn:jboss:domain:'" />
	
	<xsl:variable name="newRealm">
		<security-realm name="UndertowRealm">
			<server-identities>
				<ssl>
					<keystore path="keycloak.jks" relative-to="jboss.server.config.dir" keystore-password="secret" />
				</ssl>
			</server-identities>
		</security-realm>
	</xsl:variable>
	
	<xsl:template match="//*[local-name()='management' and starts-with(namespace-uri(), $jboss)]/*[local-name()='security-realms']">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
		<xsl:copy-of select="$newRealm" />
	</xsl:template>
	
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>