FROM debian:stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        build-essential \
        python-dev \
        libxml2-dev \
        libxslt1-dev \
        libyaml-dev \
        python-virtualenv \
        virtualenv \
        zlib1g-dev

# Use commit fd47b78e1f14dbf16d7a345fc22894c6ae838c29 which is
# on the ra21-l2 branch.
ENV PYFF_SRC_URL=git+https://github.com/IdentityPython/pyFF.git@fd47b78e1f14dbf16d7a345fc22894c6ae838c29

RUN mkdir -p /opt/pyff \
    && virtualenv /opt/pyff --no-site-packages \
    && . /opt/pyff/bin/activate \
    && pip install ${PYFF_SRC_URL} \
    && mkdir -p /opt/pyff/lib/python2.7/site-packages/pyff/site/static/logos

WORKDIR /opt/pyff

COPY start.sh /usr/local/sbin/pyff-start.sh
COPY aaf-metadata-certificate.pem /opt/pyff/aaf-metadata-certificate.pem
COPY aaf_test.xrd /opt/pyff/aaf_test.xrd
COPY aaf_prod.xrd /opt/pyff/aaf_prod.xrd
COPY aaf_edugain.xrd /opt/pyff/aaf_edugain.xrd
COPY mwa_mdx.yaml /opt/pyff/mwa_mdx.yaml
COPY mwa-federation-metadata.xml /opt/pyff/mwa-federation-metadata.xml
COPY scg-idp-metadata.xml /opt/pyff/scg-idp-metadata.xml
COPY samlgw01.mwatelescope.org-metadata.xml /opt/pyff/samlgw01.mwatelescope.org-metadata.xml
COPY unitedid-metadata.xml /opt/pyff/unitedid-metadata.xml
COPY edugain_transform.xsl /opt/pyff/edugain_transform.xsl
COPY aaf_transform.xsl /opt/pyff/aaf_transform.xsl
COPY ds.html /opt/pyff/lib/python2.7/site-packages/pyff/templates/ds.html

COPY logos/* /opt/pyff/lib/python2.7/site-packages/pyff/site/static/logos/

# Until fixes are merged into upstream pyFF copy over Javascript that
# fixes cache timeout issue and IE11 issue.
COPY ds-client.js /opt/pyff/lib/python2.7/site-packages/pyff/site/static/js/
COPY sha1.js /opt/pyff/lib/python2.7/site-packages/pyff/site/static/js/

ENTRYPOINT ["/usr/local/sbin/pyff-start.sh"]
