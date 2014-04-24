<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:nuspec="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:my="my"
    exclude-result-prefixes="msxsl nuspec my">

  <msxsl:script language="C#" implements-prefix="my">
    <msxsl:using namespace="System.IO" />
    <![CDATA[
    public void Write(XPathNavigator BASE, string file, string content)
    {
      File.WriteAllText(new Uri(new Uri(BASE.BaseURI), file).LocalPath, content);
    }
    ]]>
  </msxsl:script>

  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="ReleaseMajor" />
  <xsl:variable name="ReleaseMinor" />
  <xsl:variable name="ReleaseBuild" />
  <xsl:variable name="ReleaseRevision" />
  
  <xsl:template match="nuspec:package">
    <xsl:param name="ReleaseMajor" select="$ReleaseMajor" />
    <xsl:param name="ReleaseMinor" select="$ReleaseMinor" />
    <xsl:param name="ReleaseBuild" select="$ReleaseBuild" />
    <xsl:param name="ReleaseRevision" select="$ReleaseRevision" />
    <xsl:variable name="AA">
      <LocalInfo>
        <Product>
          <Version>
            <xsl:attribute name="Major"><xsl:value-of select="$ReleaseMajor"/></xsl:attribute>
            <xsl:attribute name="Minor"><xsl:value-of select="$ReleaseMinor"/></xsl:attribute>
            <xsl:attribute name="Build"><xsl:value-of select="$ReleaseBuild"/></xsl:attribute>
            <xsl:attribute name="Revision"><xsl:value-of select="$ReleaseRevision"/></xsl:attribute>
          </Version>
        </Product>
        <License>
          <SubscriptionEndDate DateInt="99991231" />
        </License>
      </LocalInfo>
    </xsl:variable>
    <xsl:variable name="BB">
      <xsl:apply-templates select="msxsl:node-set($AA)/LocalInfo" />
    </xsl:variable>
    <xsl:call-template name="Common">
      <xsl:with-param name="UpdateInfo" select="msxsl:node-set($BB)/UpdateInfos/UpdateInfo" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="node()|@*" name="Common">
    <xsl:param name="UpdateInfo" />
    <xsl:copy>
      <xsl:apply-templates select="node()|@*">

        <xsl:with-param name="UpdateInfo" select="$UpdateInfo" />
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="nuspec:id">
    <xsl:param name="UpdateInfo" />

    <xsl:variable name="install">
      <xsl:text>Install-ChocolateyPackage '</xsl:text>
      <xsl:value-of select="." />
      <xsl:text>' 'msi' '/q' '</xsl:text>
      <xsl:value-of select="$UpdateInfo/DownloadUri" />
      <xsl:text>'</xsl:text>
    </xsl:variable>
    <xsl:copy-of select='my:Write(., "chocolateyInstall.ps1", $install)'/>

    <xsl:call-template name="Common">
      <xsl:with-param name="UpdateInfo" select="$UpdateInfo" />
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="nuspec:authors|nuspec:owners|nuspec:copyright">
    <xsl:param name="UpdateInfo" />
    <xsl:copy>
      <xsl:value-of select="$UpdateInfo/CompanyName"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="nuspec:version">
    <xsl:param name="UpdateInfo" />
    <xsl:element name="version" namespace="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
      <xsl:value-of select="$UpdateInfo/ProductVersion"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="nuspec:releaseNotes">
    <xsl:param name="UpdateInfo" />
    <xsl:element name="releaseNotes" namespace="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
      <xsl:value-of select="$UpdateInfo/Description" />
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
