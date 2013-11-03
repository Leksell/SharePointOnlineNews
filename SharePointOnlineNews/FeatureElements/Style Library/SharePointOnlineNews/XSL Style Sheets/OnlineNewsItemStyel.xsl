<xsl:stylesheet
  version="1.0"
  exclude-result-prefixes="x d xsl msxsl cmswrt"
  xmlns:x="http://www.w3.org/2001/XMLSchema"
  xmlns:d="http://schemas.microsoft.com/sharepoint/dsp"
  xmlns:cmswrt="http://schemas.microsoft.com/WebParts/v3/Publishing/runtime"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime">
  <xsl:param name="ItemsHaveStreams">
    <xsl:value-of select="'False'" />
  </xsl:param>
  <xsl:variable name="OnClickTargetAttribute" select="string('javascript:this.target=&quot;_blank&quot;')" />
  <xsl:variable name="ImageWidth" />
  <xsl:variable name="ImageHeight" />
  <xsl:template name="Default" match="*" mode="itemstyle">
    <xsl:variable name="SafeLinkUrl">
      <xsl:call-template name="OuterTemplate.GetSafeLink">
        <xsl:with-param name="UrlColumnName" select="'LinkUrl'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="SafeImageUrl">
      <xsl:call-template name="OuterTemplate.GetSafeStaticUrl">
        <xsl:with-param name="UrlColumnName" select="'ImageUrl'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="DisplayTitle">
      <xsl:call-template name="OuterTemplate.GetTitle">
        <xsl:with-param name="Title" select="@Title"/>
        <xsl:with-param name="UrlColumnName" select="'LinkUrl'"/>
      </xsl:call-template>
    </xsl:variable>
    <div class="item item-rollup OnlineNews-item-rollup">
      <xsl:if test="string-length($SafeImageUrl) != 0">
        <div class="image-area-left image-area-left-rollup OnlineNews-image-area-left OnlineNews-image-area-left-rollup">
          <a href="{$SafeLinkUrl}">
            <xsl:if test="$ItemsHaveStreams = 'True'">
              <xsl:attribute name="onclick">
                <xsl:value-of select="@OnClickForWebRendering"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$ItemsHaveStreams != 'True' and @OpenInNewWindow = 'True'">
              <xsl:attribute name="onclick">
                <xsl:value-of disable-output-escaping="yes" select="$OnClickTargetAttribute"/>
              </xsl:attribute>
            </xsl:if>
            <img class="image image-rollup OnlineNews-image-rollup" src="{$SafeImageUrl}" title="{@ImageUrlAltText}">
              <xsl:if test="$ImageWidth != ''">
                <xsl:attribute name="width">
                  <xsl:value-of select="$ImageWidth" />
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="$ImageHeight != ''">
                <xsl:attribute name="height">
                  <xsl:value-of select="$ImageHeight" />
                </xsl:attribute>
              </xsl:if>
            </img>
          </a>
        </div>
      </xsl:if>
      <div class="link-item title-rollup OnlineNews-link-item OnlineNews-title-rollup">
        <xsl:call-template name="OuterTemplate.CallPresenceStatusIconTemplate"/>
        <a href="{$SafeLinkUrl}" title="{@LinkToolTip}">
          <xsl:if test="$ItemsHaveStreams = 'True'">
            <xsl:attribute name="onclick">
              <xsl:value-of select="@OnClickForWebRendering"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="$ItemsHaveStreams != 'True' and @OpenInNewWindow = 'True'">
            <xsl:attribute name="onclick">
              <xsl:value-of disable-output-escaping="yes" select="$OnClickTargetAttribute"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="$DisplayTitle"/>
        </a>
        <div class="date-rollup OnlineNews-date-rollup">
          Postad: <xsl:value-of select="ddwrt:FormatDateTime(string(@ArticleStartDate) ,1053 , 'yyyy-MM-dd')" />
        </div>

        <div class="description ingress-rollup OnlineNews-description OnlineNews-ingress-rollup">
          <xsl:value-of select="@Description" />
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template name="HiddenSlots" match="Row[@Style='HiddenSlots']" mode="itemstyle">
    <div class="SipAddress">
      <xsl:value-of select="@SipAddress" />
    </div>
    <div class="LinkToolTip">
      <xsl:value-of select="@LinkToolTip" />
    </div>
    <div class="OpenInNewWindow">
      <xsl:value-of select="@OpenInNewWindow" />
    </div>
    <div class="OnClickForWebRendering">
      <xsl:value-of select="@OnClickForWebRendering" />
    </div>
  </xsl:template>
</xsl:stylesheet>
