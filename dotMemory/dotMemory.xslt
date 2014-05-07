<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:nuspec="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd"
    exclude-result-prefixes="msxsl nuspec">

  <xsl:import href="..\Common.xslt" />
  <xsl:import href="http://www.jetbrains.com/profiler/updates/updates.dotMemory.xslt" />

  <xsl:template match="/">
    <xsl:apply-templates>
      <xsl:with-param name="ReleaseMajor" select="$ReleaseMajor" />
      <xsl:with-param name="ReleaseMinor" select="$ReleaseMinor" />
      <xsl:with-param name="ReleaseBuild" select="$ReleaseBuild - 1" />
      <xsl:with-param name="ReleaseRevision" select="0" />
    </xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>