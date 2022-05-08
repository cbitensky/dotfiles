<xsl:stylesheet
	version="1.1"
	xmlns="http://www.gribuser.ru/xml/fictionbook/2.0"
	xmlns:f="http://www.gribuser.ru/xml/fictionbook/2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="f xsl">


<xsl:template match="f:p">
	<p>
	<xsl:apply-templates select="@*"/>
	<xsl:attribute name="id">
		<xsl:value-of select="count(preceding::p)+1"/>
	</xsl:attribute>
	<xsl:value-of select="."/>
	</p>
</xsl:template>


<xsl:template match="@*|node()">
	<xsl:copy>
		<xsl:apply-templates select="@*|node()"/>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>