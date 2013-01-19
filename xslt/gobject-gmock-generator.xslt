<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
    GObject GMock Generator, XSL transform from GIR data to mock headers
    Copyright : (C) 2013 Sam Spilsbury
    E-mail    : smspillaz@gmail.com
 
 
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.
 
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
-->
<xsl:stylesheet version="1.0"
                xmlns:gi="http://www.gtk.org/introspection/core/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:c="http://www.gtk.org/introspection/c/1.0"
                xmlns:glib="http://www.gtk.org/introspection/glib/1.0">

    <xsl:output method="text"/>
    <xsl:include href="xslt/ggm-internal.xslt"/>

    <xsl:template name="processArgument">
        <xsl:text> parameter type: </xsl:text><xsl:value-of select="gi:type/@c:type"/>
        <xsl:value-of select="$newline"/>
        <xsl:text> parameter name: </xsl:text><xsl:value-of select="@name"/>
        <xsl:value-of select="$newline"/>
    </xsl:template>

    <xsl:template name="processVirtualMethod">
        <xsl:text>Found virtual method: </xsl:text><xsl:value-of select="@name"/>
        <xsl:value-of select="$newline"/>
        <xsl:text> returns: </xsl:text><xsl:value-of select="gi:return-value/gi:type/@c:type"/>
        <xsl:value-of select="$newline"/>
        <xsl:for-each select="gi:parameters/gi:parameter">
            <xsl:call-template name="processArgument"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="processInterface">
        <xsl:text>Found interface: </xsl:text><xsl:value-of select="@name"/>
        <xsl:value-of select="$newline"/>
        <xsl:for-each select="gi:virtual-method">
            <xsl:call-template name="processVirtualMethod"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="processNamespace">
        <xsl:text>Found namespace: </xsl:text><xsl:value-of select="@name"/>
        <xsl:value-of select="$newline"/>
        <xsl:for-each select="gi:interface">
            <xsl:call-template name="processInterface"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="/gi:repository">
        <xsl:for-each select="gi:namespace">
            <xsl:call-template name="processNamespace"/>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
