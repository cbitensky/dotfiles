<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:fb="http://www.gribuser.ru/xml/fictionbook/2.0"
	extension-element-prefixes="exsl">
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates select="//fb:binary"/>
</xsl:template>

<xsl:template match="//fb:binary">
	<xsl:variable name="filename" select="concat(@id, '.', substring-after(@content-type, '/'), '.base64')"/>
	<exsl:document href="{$filename}" method="text">
		<xsl:apply-templates/>
	</exsl:document>
	<xsl:value-of select="$filename"/>
	<xsl:text>&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>
