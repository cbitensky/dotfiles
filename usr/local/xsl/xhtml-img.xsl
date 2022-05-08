<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:h="http://www.w3.org/1999/xhtml"
	xmlns:l="http://www.w3.org/1999/xlink">
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates select="//h:img"/>
</xsl:template>

<xsl:template match="//h:img | //h:video">
	<xsl:value-of select="@src"/>
	<xsl:text>&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>
