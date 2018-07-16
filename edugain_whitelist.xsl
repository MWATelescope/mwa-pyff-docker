<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata">

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

        <!-- IdPs from eduGAIN to include. -->
        <xsl:copy-of select="//*[@entityID='https://idp.uwm.edu/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='urn:mace:incommon:asu.edu']"/>
        <xsl:copy-of select="//*[@entityID='https://sso.brown.edu/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='urn:mace:incommon:berkeley.edu']"/>
        <xsl:copy-of select="//*[@entityID='https://idp.utorauth.utoronto.ca/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='urn:mace:incommon:washington.edu']"/>

        </EntitiesDescriptor>
    </xsl:template>


</xsl:stylesheet>
