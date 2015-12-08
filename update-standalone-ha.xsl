<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:undertow="urn:jboss:domain:undertow:2.0"
	xmlns:jboss="urn:jboss:domain:3.0"
	xmlns="urn:jboss:domain:3.0">
	<xsl:output method="xml" indent="yes" />

	<!-- add attributes to http-listener -->
	<!-- <http-listener name="default" socket-binding="http" proxy-address-forwarding="true" redirect-socket="proxy-https"/> -->
	<xsl:template match="//undertow:server[@name='default-server']/undertow:http-listener[@name='default']">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
			<xsl:attribute name="proxy-address-forwarding">true</xsl:attribute>
			<xsl:attribute name="redirect-socket">proxy-https</xsl:attribute>
		</xsl:copy>
	</xsl:template>

	<!-- add to socket-binding-group: -->
	<!-- <socket-binding-group name="standard-sockets" default-interface="public" -->
	<!-- port-offset="${jboss.socket.binding.port-offset:0}"> -->
	<!--    ... -->
	<!--    <socket-binding name="proxy-https" port="443"/> -->
	<!--    ... -->
	<!-- </socket-binding-group> -->
	<xsl:template match="//jboss:socket-binding-group">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
			<xsl:element name="socket-binding" >
				<xsl:attribute name="name">proxy-https</xsl:attribute>
				<xsl:attribute name="port">443</xsl:attribute>
			</xsl:element>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>