<x:stylesheet version="1.0" exclude-result-prefixes="t ex h"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://www.w3.org/1999/xhtml"
	xmlns:t="tag:kostya3@gmail.com,2020:text"
	xmlns:x="http://www.w3.org/1999/XSL/Transform"
	xmlns:ex="http://exslt.org/common">
<x:output method="xml" omit-xml-declaration="yes" doctype-system="about:legacy-compat"/>
<x:strip-space elements="*"/>


<!--x:template match="t:call">
	<x:apply-templates select="//*[not(self::t:call)][@tn=current()/@t]"/>
</x:template-->

<!--x:template match="@n">
	<x:param name="testParam"/>
	<x:value-of select="$testParam"/>
	<x:message terminate="no"><x:value-of select="."/></x:message>
	<x:message terminate="no">!!!!!!n: <x:value-of select="$testParam"/></x:message>
</x:template-->


<x:template match="*">
	<x:variable name="name" select="local-name()"/>
	<x:choose>
		<x:when test="//*[@n=$name]">
			<x:variable name="template">
				<x:for-each select="//*[@n=$name]/. | //*[@n=$name]//@* | //*[@n=$name]//node()">
					<x:message terminate="no">
						!<x:value-of select="name(.)"/>: <x:value-of select="."/>
					</x:message>
					<x:choose>
						<x:when test="@* and contains(., '{')">
							<x:attribute name="{name()}">
								<x:value-of select="subsring-before(., '{')"/>
								<x:value-of select="subsring-after(., '}')"/>
							</x:attribute>
						</x:when>
						<x:otherwise>
							<x:copy-of select="."/>
						</x:otherwise>
					</x:choose>
				</x:for-each>
			</x:variable>
		</x:when>
		<x:otherwise>
			<x:message terminate="no">Unmatched element: <x:value-of select="$name"/></x:message>
		</x:otherwise>
	</x:choose>
</x:template>


<x:template match="@*">
	<x:message terminate="no">Unmatched attribute: <x:value-of select="name()"/></x:message>
</x:template>


<x:template match="/">
	<x:variable name="pass1">
		<x:apply-templates/>
	</x:variable>
	<x:apply-templates mode="pass2" select="ex:node-set($pass1)"/>
</x:template>


<x:template match="t:t">
	<x:apply-templates/>
</x:template>


<x:template match="t:the">
	<the>
		<x:copy-of select="@*"/>
	</the>
</x:template>


<x:template match="node() | @*" mode="pass2">
	<x:copy>
		<x:apply-templates select="node() | @*" mode="pass2"/>
	</x:copy>
</x:template>


<x:template match="h:the" mode="pass2">
	<x:value-of select="count(preceding::h:the[@counter=current()/@counter]) + 1"/>
</x:template>


<x:param name="max-level">
	<x:for-each select="//t:section">
		<x:sort select="count(ancestor::t:section)" order="descending"/>
		<x:if test="position() = 1">
			<x:value-of select="count(ancestor::t:section) + 1"/>
		</x:if>
	</x:for-each>
</x:param>


<x:template match="t:meta | @tn"/>

<x:template match="@lang | @id">
	<x:copy-of select="."/>
</x:template>


<x:template match="t:d">
	<x:apply-templates select="node()"/>
</x:template>


<x:template match="/t:root">
	<x:apply-templates select="* | @*"/>
</x:template>


<x:template match="t:text">
	<html>
		<x:apply-templates select="@*"/>
		<x:text>&#xA;</x:text>
		<head>
			<x:text>&#xA;</x:text>
			<meta charset="UTF-8"/>
			<x:text>&#xA;</x:text>
			<meta name="viewport" content="width=device-width"/>
			<x:text>&#xA;</x:text>
			<link rel="stylesheet" href="/local/css/base.css"/>
			<x:text>&#xA;</x:text>
			<title>
				<x:apply-templates select="t:meta/t:short-name/node()"/>
			</title>
			<x:text>&#xA;</x:text>
		</head>
		<x:text>&#xA;</x:text>
		<body class="text">
			<x:apply-templates/>
			<x:text>&#xA;</x:text>
		</body>
		<x:text>&#xA;</x:text>
	</html>
</x:template>


<x:template name="block">
	<x:param name="name"/>
	<x:text>&#xA;</x:text>
	<x:element name="{$name}">
		<x:apply-templates select="* | @*"/>
		<x:text>&#xA;</x:text>
	</x:element>
</x:template>


<x:template match="t:header | t:section | t:ul | t:ol">
	<x:call-template name="block">
		<x:with-param name="name" select="local-name()"/>
	</x:call-template>
</x:template>


<x:template match="t:br">
	<x:element name="{local-name()}">
		<x:copy-of select="@*"/>
	</x:element>
	<x:text>&#xA;</x:text>
</x:template>


<x:template match="t:p | t:img">
	<x:text>&#xA;</x:text>
	<x:element name="{local-name()}">
		<x:apply-templates select="node() | @*"/>
	</x:element>
</x:template>


<x:template match="t:header//t:sub | t:header//t:title | t:weak">
<x:text>&#xA;</x:text>
<div class="{local-name()}">
	<x:apply-templates select="* | @*"/>
	<x:text>&#xA;</x:text>
</div>
</x:template>


<x:template match="t:header">
	<x:text>&#xA;</x:text>
	<header class="l{$max-level - count(ancestor::t:section) + 1}">
		<x:apply-templates select="* | @*"/>
		<x:text>&#xA;</x:text>
	</header>
</x:template>


<x:template match="t:text/t:header//t:author">
	<x:text>&#xA;</x:text>
	<div class="{local-name()}">
		<x:text>&#xA;</x:text>
		<p>
			<x:variable name="name" select="document('/xml/author.xml')//t:author[@id=current()/@oid]/t:name"/>
			<x:variable name="format" select="$name/@format"/>
			<x:choose>
				<x:when test="$format='ФИО'">
					<x:variable name="ИО" select="substring-after($name, ' ')"/>
					<x:value-of select="substring-before($ИО, ' ')"/>
					<x:text> </x:text>
					<x:value-of select="substring-before($name, ' ')"/>
				</x:when>
				<x:otherwise>
				</x:otherwise>
			</x:choose>
		</p>
		<x:text>&#xA;</x:text>
	</div>
</x:template>

<x:template match="t:sub | t:sup">
<x:text>&#xA;</x:text>
<blockquote class="{local-name()}">
	<x:apply-templates select="* | @*"/>
	<x:text>&#xA;</x:text>
</blockquote>
</x:template>


<x:template match="t:text/t:header//t:date">
	<x:text>&#xA;</x:text>
	<p class="{local-name()}">
		<x:value-of select="@value"/>
	</p>
</x:template>

<x:template match="t:e">
<em><x:apply-templates select="node() | @*"/></em>
</x:template>

<x:template match="t:w">
<small><x:apply-templates select="node() | @*"/></small>
</x:template>

<x:template match="t:pi">
<x:text>&#xA;</x:text>
<li><x:apply-templates select="node() | @*"/></li>
</x:template>

<x:template match="t:s">
<strong><x:apply-templates select="node() | @*"/></strong>
</x:template>


<x:template match="t:cite">
	<x:call-template name="block">
		<x:with-param name="name" select="'blockquote'"/>
	</x:call-template>
</x:template>


<x:template match="t:fig">
	<x:call-template name="block">
		<x:with-param name="name" select="'figure'"/>
	</x:call-template>
</x:template>


<x:template match="t:capt">
	<x:call-template name="block">
		<x:with-param name="name" select="'caption'"/>
	</x:call-template>
</x:template>


</x:stylesheet>
