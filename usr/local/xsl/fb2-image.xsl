<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fb="http://www.gribuser.ru/xml/fictionbook/2.0"
	xmlns:xlink="http://www.w3.org/1999/xlink">
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates select="//fb:image"/>
</xsl:template>

<xsl:template match="//fb:image">
	<xsl:value-of select="@xlink:href"/>
	<xsl:text>&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>
