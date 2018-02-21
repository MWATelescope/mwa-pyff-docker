FROM debian:jessie

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

# Use the head of the master branch of the official pyFF repository
ENV PYFF_SRC_URL=git+git://github.com/leifj/pyFF@master

# Use the head of the master branch of the official pyXMLSecurity repository
ENV PYXMLSECURITY_SRC_URL=git+git://github.com/leifj/pyXMLSecurity.git#egg=pyXMLSecurity

RUN mkdir -p /opt/pyff \
    && virtualenv /opt/pyff --no-site-packages \
    && . /opt/pyff/bin/activate \
    && pip install --upgrade ${PYFF_SRC_URL} \
    && pip install --upgrade ${PYXMLSECURITY_SRC_URL} 

WORKDIR /opt/pyff

COPY start.sh /usr/local/sbin/pyff-start.sh
COPY aaf-metadata-certificate.pem /opt/pyff/aaf-metadata-certificate.pem
COPY aaf_test.xrd /opt/pyff/aaf_test.xrd
COPY aaf_prod.xrd /opt/pyff/aaf_prod.xrd
COPY mwa_mdx.yaml /opt/pyff/mwa_mdx.yaml
COPY mwa-federation-metadata.xml /opt/pyff/mwa-federation-metadata.xml
COPY scg-idp-metadata.xml /opt/pyff/scg-idp-metadata.xml
COPY unitedid-metadata.xml /opt/pyff/unitedid-metadata.xml

ENTRYPOINT ["/usr/local/sbin/pyff-start.sh"]
