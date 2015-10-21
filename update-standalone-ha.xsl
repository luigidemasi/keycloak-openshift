<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                              xmlns:undertow="urn:jboss:domain:undertow:2.0">
                              
	<xsl:output method="xml" indent="no" />
	<xsl:variable name="undertow" select="'urn:jboss:domain:undertow:'" />
	
	<xsl:variable name="newRealm">
		<security-realm name="UndertowRealm">
			<server-identities>
				<ssl>
					<keystore path="keycloak.jks" relative-to="jboss.server.config.dir" keystore-password="secret" />
				</ssl>
			</server-identities>
		</security-realm>
	</xsl:variable>
	
	<xsl:variable name="newHttpsListener">
		<https-listener name="https" socket-binding="https" security-realm="UndertowRealm" />
	</xsl:variable>
	
	<xsl:template match="//*[local-name()='management']/*[local-name()='security-realms']">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
			<xsl:copy-of select="$newRealm" />
		</xsl:copy>
	</xsl:template>
	
<!-- 	<xsl:template match="//*[local-name()='subsystem' and starts-with(namespace-uri(),$undertow)]"> -->
	<xsl:template match="//undertow:server[@name='default-server']">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
			<xsl:copy-of select="$newHttpsListener" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>