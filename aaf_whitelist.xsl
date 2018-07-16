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

        <!-- IdPs from AAF to include. -->
        <xsl:copy-of select="//*[@entityID='https://idp2.anu.edu.au/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='https://idpp1.curtin.edu.au/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='https://aafidp2.csiro.au/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='https://idp.unimelb.edu.au/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='https://idp.cc.swin.edu.au/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='https://federation.sydney.edu.au/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='https://idp.uwa.edu.au/idp/shibboleth']"/>
        <xsl:copy-of select="//*[@entityID='https://idp.uws.edu.au/idp/shibboleth']"/>

        <!-- Include the SP side of the SAML IdP/SP proxy which
             is published in the AAF.  -->
        <xsl:copy-of select="//*[@entityID='https://proxy.mwatelescope.org/sp']"/>

        </EntitiesDescriptor>
    </xsl:template>

</xsl:stylesheet>
