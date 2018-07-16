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

# Use the merged version of master after pull 144 included.
ENV PYFF_SRC_URL=git+https://github.com/IdentityPython/pyFF.git@refs/pull/144/merge

# Use the head of the master branch of the official pyXMLSecurity repository
ENV PYXMLSECURITY_SRC_URL=git+git://github.com/IdentityPython/pyXMLSecurity

RUN mkdir -p /opt/pyff \
    && virtualenv /opt/pyff --no-site-packages \
    && . /opt/pyff/bin/activate \
    && pip install lxml==4.1.1 \
    && pip install ${PYXMLSECURITY_SRC_URL} \
    && pip install ${PYFF_SRC_URL}

WORKDIR /opt/pyff

COPY start.sh /usr/local/sbin/pyff-start.sh
COPY aaf-metadata-certificate.pem /opt/pyff/aaf-metadata-certificate.pem
COPY aaf_test.xrd /opt/pyff/aaf_test.xrd
COPY aaf_prod.xrd /opt/pyff/aaf_prod.xrd
COPY aaf_edugain.xrd /opt/pyff/aaf_edugain.xrd
COPY mwa_mdx.yaml /opt/pyff/mwa_mdx.yaml
COPY mwa-federation-metadata.xml /opt/pyff/mwa-federation-metadata.xml
COPY scg-idp-metadata.xml /opt/pyff/scg-idp-metadata.xml
COPY unitedid-metadata.xml /opt/pyff/unitedid-metadata.xml
COPY edugain_whitelist.xsl /opt/pyff/edugain_whitelist.xsl
COPY aaf_whitelist.xsl /opt/pyff/aaf_whitelist.xsl
COPY ds.html /opt/pyff/lib/python2.7/site-packages/pyff/templates/ds.html

ENTRYPOINT ["/usr/local/sbin/pyff-start.sh"]
