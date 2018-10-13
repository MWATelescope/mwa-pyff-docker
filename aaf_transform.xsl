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

    <!-- Match all SPs besides the proxy SP and take no action so they are
         not copied into the output. -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[md:SPSSODescriptor and not(@entityID='https://proxy.mwatelescope.org/sp')]">
    </xsl:template>

    <!-- Match all stand-alone attribute authorities and take no action so they are
         not copied into the output. -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[md:AttributeAuthorityDescriptor and not(md:IDPSSODescriptor)]">
    </xsl:template>


    <!-- Add logo for Curtin University -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://idpp1.curtin.edu.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
              <mdui:DisplayName xml:lang="en">Curtin University</mdui:DisplayName>
              <mdui:Description xml:lang="en">IdP for Curtin University</mdui:Description>
              <mdui:Logo height="400" width="400" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>curtin.jpg</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>

    <!-- Add logo for ANU -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://idp2.anu.edu.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
          <mdui:DisplayName xml:lang="en">Australian National University</mdui:DisplayName>
          <mdui:Description xml:lang="en">Australian National University IdP</mdui:Description>
          <mdui:Logo height="350" width="350" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>anu.png</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>

    <!-- Add logo for CSIRO -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://aafidp2.csiro.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
          <mdui:DisplayName xml:lang="en">CSIRO</mdui:DisplayName>
          <mdui:Description xml:lang="en">The Commonwealth Scientific and Industrial Research Organisation is Australia's national science agency.</mdui:Description>
          <mdui:Logo height="400" width="400" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>csiro.jpg</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>

    <!-- Add logo for University of Melbourne -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://idp.unimelb.edu.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
          <mdui:DisplayName xml:lang="en">The University of Melbourne</mdui:DisplayName>
          <mdui:Description xml:lang="en">IdP of The University of Melbourne</mdui:Description>
          <mdui:Logo height="400" width="400" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>unimelb.jpg</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>

    <!-- Add logo for Swinburne University of Technology -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://idp.cc.swin.edu.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
        <mdui:DisplayName xml:lang="en">Swinburne University of Technology</mdui:DisplayName>
        <mdui:Description xml:lang="en">Swinburne University of Technology</mdui:Description>
        <mdui:Logo height="400" width="400" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>swinburne.jpg</mdui:Logo>
      </mdui:UIInfo>
    </xsl:template>

    <!-- Add logo for University of Sydney -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://federation.sydney.edu.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
          <mdui:DisplayName xml:lang="en">The University of Sydney</mdui:DisplayName>
          <mdui:Description xml:lang="en">IdP for University of Sydney students and staff.</mdui:Description>
          <mdui:Logo height="400" width="400" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>sydney.jpg</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>

    <!-- Add logo for University of Western Australia -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://idp.uwa.edu.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
          <mdui:DisplayName xml:lang="en">The University of Western Australia</mdui:DisplayName>
          <mdui:Description xml:lang="en">The IdP of the University of Western Australia</mdui:Description>
          <mdui:Logo height="400" width="400" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>uwa.jpg</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>

    <!-- Add logo for Western Sydney University -->
    <xsl:template match="/md:EntitiesDescriptor/md:EntityDescriptor[@entityID='https://idp.uws.edu.au/idp/shibboleth']/md:IDPSSODescriptor/md:Extensions/mdui:UIInfo">
        <mdui:UIInfo>
          <mdui:DisplayName xml:lang="en">Western Sydney University </mdui:DisplayName>
          <mdui:Description xml:lang="en">Western Sydney University</mdui:Description>
          <mdui:Logo height="400" width="400" xml:lang="en"><xsl:copy-of select="$idp_logo_url_prefix"/>wsu.jpg</mdui:Logo>
        </mdui:UIInfo>
    </xsl:template>

</xsl:stylesheet>
