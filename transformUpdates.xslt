<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="products">
    <packages>
      <xsl:apply-templates select="product" />
    </packages>
  </xsl:template>
  
  <xsl:template match="product">
    <xsl:variable name="sorted_channels">
      <xsl:for-each select="channel[@status='release' or @status='Release']">
          <xsl:sort select="@majorVersion" data-type="number" order="descending" />
          <xsl:copy-of select="." />
        </xsl:for-each>
    </xsl:variable>
    <xsl:apply-templates select="msxsl:node-set($sorted_channels)/channel[1]">
      <xsl:with-param name="code" select="code"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="channel">
    <xsl:param name="code" />
    <package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
      <metadata>
        <id><xsl:value-of select="@id"/></id>
        <version><xsl:value-of select="build/@version" /></version>
        <title><xsl:value-of select="@name"/></title>
        <authors>JetBrains</authors>
        <owners>JetBrains</owners>
        <projectUrl><xsl:value-of select="@url"/></projectUrl>
        <iconUrl>https://github.com/JetBrains/Chocolatey/raw/master/dotPeek.portable/dotPeek.png</iconUrl>
        <licenseUrl>http://www.jetbrains.com/decompiler/download/license.html</licenseUrl>
        <requireLicenseAcceptance>false</requireLicenseAcceptance>
        <xsl:call-template name="GetDescription">
          <xsl:with-param name="code" select="$code" />
        </xsl:call-template>
        <releaseNotes>
          <xsl:value-of select="build/message" />
          <xsl:for-each select="build/button[not(@download)]">
            <xsl:text> </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="@url"/>
          </xsl:for-each>
        </releaseNotes>
        <url>
          <xsl:call-template name="GetDownloadUrl">
            <xsl:with-param name="code" select="$code" />
            <xsl:with-param name="baseUrl" select="build/button[@download]/@url" />
            <xsl:with-param name="buildNumber" select="build/@number" />
          </xsl:call-template>
        </url>
      </metadata>
    </package>
  </xsl:template>

  <xsl:template name="GetDescription">
    <xsl:param name="code" />
    <xsl:choose>
      <xsl:when test="$code='RM'">
        <description>RubyMine</description>
        <summary>AE!</summary>
        <tags>rubymine</tags>
      </xsl:when>
      <xsl:otherwise>
        <description>dotPeek is a free .NET decompiler and assembly browser from JetBrains. The main idea behind dotPeek is to make high-quality decompiling coupled with powerful ReSharper-like navigation and search features available to everyone in the .NET community, free of charge.</description>
        <summary>dotPeek is a free-of-charge .NET decompiler and assembly browser from JetBrains, the makers of ReSharper and more developer productivity tools.</summary>
        <tags>.net decompiler</tags>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="GetDownloadUrl">
    <xsl:param name="code" />
    <xsl:param name="baseUrl" />
    <xsl:param name="buildNumber" />
    <xsl:choose>
      <xsl:when test="$code='RM'">
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$baseUrl"/>
        <xsl:value-of select="$buildNumber"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
