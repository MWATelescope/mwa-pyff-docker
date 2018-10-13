<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
                xmlns:idpdisc="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol"
                xmlns:mdrpi="urn:oasis:names:tc:SAML:metadata:rpi"
                xmlns:mdui="urn:oasis:names:tc:SAML:metadata:ui"
                xmlns:mdattr="urn:oasis:names:tc:SAML:metadata:attribute"
                xmlns:shibmd="urn:mace:shibboleth:metadata:1.0"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:fed="http://docs.oasis-open.org/wsfed/federation/200706"
                xmlns:privacy="http://docs.oasis-open.org/wsfed/privacy/200706"
                xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata">

    <!-- Prefix to use for IdP logo images -->
    <xsl:variable name="idp_logo_url_prefix" select="'http://login-chooser.mwatelescope.org/static/logos/'"/>

    <xsl:template match="/">
        <EntitiesDescriptor
            xmlns="urn:oasis:names:tc:SAML:2.0:metadata"
            xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
            xmlns:idpdisc="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol"
            xmlns:mdrpi="urn:oasis:names:tc:SAML:metadata:rpi"
            xmlns:mdui="urn:oasis:names:tc:SAML:metadata:ui"
            xmlns:mdattr="urn:oasis:names:tc:SAML:metadata:attribute"
            xmlns:shibmd="urn:mace:shibboleth:metadata:1.0"
            xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fed="http://docs.oasis-open.org/wsfed/federation/200706"
            xmlns:privacy="http://docs.oasis-open.org/wsfed/privacy/200706"
            xmlns:remd="http://refeds.org/metadata">

        <!-- Loop over each <EntityDescriptor> and apply templates. -->
        <xsl:for-each select="/md:EntitiesDescriptor/md:EntityDescriptor">
            <xsl:apply-templates select="."/>
        </xsl:for-each>

        </EntitiesDescriptor>
    </xsl:template>

    <!-- The identity template. It matches if no other templates match. -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <!-- Match all SPs and take no action so they are not copied into the output. -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[md:SPSSODescriptor and not(@entityID='https://cern.ch/login')]">
    </xsl:template>

    <!-- Match all stand-alone attribute authorities and take no action so they are
         not copied into the output. -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[md:AttributeAuthorityDescriptor and not(md:IDPSSODescriptor)]">
    </xsl:template>

    <!-- Change name for UW-Milwaukee to work around parsing issue. -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://idp.uwm.edu/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
          <mdui:DisplayName xml:lang="en">University of Wisconsin Milwaukee</mdui:DisplayName>
          <mdui:Description xml:lang="en">Primary Identity Provider for UW Milwaukee</mdui:Description>
          <mdui:InformationURL xml:lang="en">http://uwm.edu/iam/</mdui:InformationURL>
          <mdui:PrivacyStatementURL xml:lang="en">https://www.wisconsin.edu/regents/policies/acceptable-use-of-information-technology-resources/</mdui:PrivacyStatementURL>
          <mdui:Logo height="81" width="276" xml:lang="en">https://md.uwm.edu/files/uwm_preferred_logo.gif</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>


</xsl:stylesheet>
