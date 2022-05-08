<x:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:x="http://www.w3.org/1999/XSL/Transform"
	xmlns:l="http://www.w3.org/1999/xlink"
	xmlns:f="http://www.gribuser.ru/xml/fictionbook/2.0"
	exclude-result-prefixes="l f">

<x:output method="xml" encoding="UTF-8" omit-xml-declaration="yes"/>
<x:strip-space elements="*"/>
<x:preserve-space elements="f:p f:v f:subtitle f:text-author"/>

<x:template match="/f:FictionBook">
<x:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#xA;</x:text>
<html class="text" lang="{//f:lang}">
<x:text>&#xA;</x:text><head>
<x:text>&#xA;</x:text><meta charset="UTF-8"/>
<x:text>&#xA;</x:text><meta name="viewport" content="width=device-width"/>
<x:text>&#xA;</x:text><link rel="stylesheet" href="/usr/local/css/base.css"/>
<x:text>&#xA;</x:text><title><x:value-of select="//f:title-info/f:book-title"/></title>
<x:text>&#xA;</x:text></head>
<x:text>&#xA;</x:text><body>
<x:apply-templates select="f:body"/>
<x:text>&#xA;</x:text></body>
<x:text>&#xA;</x:text></html>
</x:template>

<x:template match="f:title">
	<x:text>&#xA;</x:text>
	<header>
	<x:attribute name="class">
		<x:text>l</x:text>
		<x:value-of select="count(ancestor::f:section) + 1"/>
	</x:attribute>
	<x:apply-templates select="node() | @*"/>
	<x:if test="count(f:p) > 1">
		<x:text>&#xA;</x:text>
	</x:if>
	</header>
</x:template>

<x:template match="f:title/f:p">
	<x:variable name="level" select="count(ancestor::f:section) + 1"/>
	<x:if test="count(../f:p) > 1">
		<x:text>&#xA;</x:text>
	</x:if>
	<x:choose>
		<x:when test="$level &lt; 6">
			<x:element name="{concat('h',$level)}">
				<x:apply-templates select="node() | @*"/>
			</x:element>
		</x:when>
		<x:otherwise>
			<h6><x:apply-templates select="node() | @*"/></h6>
		</x:otherwise>
	</x:choose>
</x:template>

<x:template match="f:subtitle">
	<x:variable name="level" select="count(ancestor::f:section) + count(ancestor::f:cite) + 2"/>
	<x:text>&#xA;</x:text>
	<header>
	<x:attribute name="class">
		<x:text>l</x:text>
		<x:value-of select="$level"/>
	</x:attribute>
	<x:choose>
		<x:when test="$level &lt; 6">
			<x:element name="{concat('h',$level)}">
				<x:apply-templates select="node() | @*"/>
			</x:element>
		</x:when>
		<x:otherwise>
			<h6><x:apply-templates select="node() | @*"/></h6>
		</x:otherwise>
	</x:choose>
	</header>
</x:template>

<x:template match="@id">
	<x:attribute name="id">
		<x:value-of select="."/>
	</x:attribute>
	<x:copy-of select="."/>
	<x:copy-of select="@id"/>
</x:template>

<x:template match="@style">
	<x:attribute name="class">
		<x:value-of select="."/>
	</x:attribute>
</x:template>

<x:template match="f:style">
	<x:choose>
		<x:when test="count(../node()) = 1">
			<x:attribute name="class"><x:value-of select="@name"/></x:attribute>
			<x:apply-templates/>
		</x:when>
		<x:otherwise>
			<span class="{@name}"><x:apply-templates select="node() | @*"/></span>
		</x:otherwise>
	</x:choose>
</x:template>

<x:template match="f:style[@name='aux']">
	<x:choose>
		<x:when test="count(../node()) = 1">
			<x:attribute name="class">aux</x:attribute>
			<x:apply-templates/>
		</x:when>
		<x:otherwise>
			<small>
			<x:apply-templates/>
			</small>
		</x:otherwise>
	</x:choose>
</x:template>

<x:template match="f:section">
	<x:text>&#xA;</x:text><x:element name="{name()}">
		<x:apply-templates select="node() | @*"/>
	<x:text>&#xA;</x:text></x:element>
</x:template>

<x:template match="f:sup | f:sub | f:strong">
	<x:element name="{name()}"><x:apply-templates select="node() | @*"/></x:element>
</x:template>

<x:template name="char2br">
	<x:param name="string"/>
	<x:param name="char"/>
	<x:choose>
			<x:when test="contains($string, $char)">
				<x:value-of select="substring-before($string, $char)"/>
				<br/>
				<x:call-template name="char2br">
					<x:with-param name="string" select="substring-after($string, $char)"/>
					<x:with-param name="char" select="$char"/>
				</x:call-template>
			</x:when>
			<x:otherwise>
				<x:value-of select="$string"/>
			</x:otherwise>
	</x:choose>
</x:template>

<x:template match="f:section/f:image | f:body/f:image" name="divimage">
	<x:text>&#xA;</x:text><figure>
	<!--t:copy-of select="@id"/-->
	<x:if test="@title and @src">
		<x:text>&#xA;</x:text>
	</x:if>
	<x:call-template name="image"/>
	<x:if test="@title">
		<x:text>&#xA;</x:text>
		<figcaption>
		<x:call-template name="char2br">
			<x:with-param name="string" select="@title"/>
			<x:with-param name="char" select="'&#xA;'"/>
		</x:call-template>
		<!--t:value-of select="@title"/-->
		</figcaption>
	</x:if>
	<x:if test="@title">
		<x:text>&#xA;</x:text>
	</x:if>
	</figure>
</x:template>

<x:template match="f:body[@name='notes']">
	<x:text>&#xA;</x:text>
	<section class="notes">
	<x:apply-templates select="node() | @*"/><x:text>&#xA;</x:text>
	</section><x:text>&#xA;</x:text>
</x:template>

<x:template match="f:p | f:v">
	<x:text>&#xA;</x:text><p><x:apply-templates select="node() | @*"/></p>
</x:template>

<x:template match="f:emphasis">
	<em><x:apply-templates select="node() | @*"/></em>
</x:template>

<x:template match="f:empty-line">
	<x:text>&#xA;</x:text><div class="empty-line"/>
</x:template>

<x:template match="f:section/node()[last()][self::f:empty-line]|f:section/node()[1][self::f:empty-line]">
</x:template>

<x:template match="f:a">
	<x:choose>
		<x:when test="(@type) = 'note'">
			<a class="note" href="{@l:href}"><sup><x:apply-templates select="node() | @*"/></sup></a>
		</x:when>
		<x:otherwise>
			<a href="{@l:href}"><x:apply-templates/></a>
		</x:otherwise>
	</x:choose>
</x:template>

<x:template match="f:epigraph | f:cite | f:poem">
	<x:text>&#xA;</x:text><blockquote class="{name()}">
		<x:apply-templates select="node() | @*"/>
	<x:text>&#xA;</x:text></blockquote>
</x:template>

<x:template match="f:text-author">
	<x:text>&#xA;</x:text><p class="author"><x:apply-templates select="node() | @*"/></p>
</x:template>

<x:template match="f:stanza">
	<x:text>&#xA;</x:text><div class="stanza">
		<x:apply-templates select="node() | @*"/>
	<x:text>&#xA;</x:text></div>
</x:template>

<x:template match="f:annotation">
	<x:text>&#xA;</x:text>
	<blockquote class="annotation">
	<x:apply-templates select="node() | @*"/>
	<x:text>&#xA;</x:text>
	</blockquote>
</x:template>

<x:template match="f:image" name="image">
	<x:if test="@l:href">
		<img>
		<x:choose>
			<x:when test="starts-with(@l:href,'#')">
				<x:variable name="href" select="substring-after(@l:href,'#')"/>
				<x:attribute name="src">
					<x:text>data:</x:text>
					<x:value-of select="//f:binary[@id=$href]/@content-type"/>
					<x:text>;base64,</x:text>
					<x:value-of select="translate(normalize-space(//f:binary[@id=$href]), ' ', '')"/>
				</x:attribute>
			</x:when>
			<x:otherwise>
				<x:attribute name="src"><x:value-of select="@l:href"/></x:attribute>
			</x:otherwise>
		</x:choose>
		<x:apply-templates select="@*"/>
		</img>
	</x:if>
</x:template>


<x:template match="f:table">
	<x:text>&#xA;</x:text><table>
	<x:apply-templates select="@*"/>
	<x:text>&#xA;</x:text><tbody>
		<x:apply-templates/>
	<x:text>&#xA;</x:text></tbody>
	<x:text>&#xA;</x:text></table>
</x:template>

<x:template match="f:tr">
	<x:text>&#xA;</x:text><tr>
	<x:copy-of select="@*"/>
	<x:apply-templates select="node() | @*"/></tr>
</x:template>

<x:template match="f:td | f:th">
	<x:element name="{name()}">
	<x:copy-of select="@rowspan|@colspan"/>
	<x:if test="@align">
		<x:attribute name="class"><x:value-of select="@align"/></x:attribute>
	</x:if>
	<x:apply-templates select="node() | @*"/>
	</x:element>
</x:template>

</x:stylesheet>
