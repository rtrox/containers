ARG VERSION=""
ARG REVISION=""

FROM ubuntu:${VERSION}

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="rtrox/ubuntu"
LABEL org.label-schema.description="Base Image customed for rtrox images."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

USER root

RUN set -eux \
    && echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Get::Install-Recommends "false";' >>/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Get::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

RUN apt-get update && apt-get install -y --no-install-recommends bash tini && rm -rf /var/lib/apt/lists/*

RUN adduser rtrox --uid 314 --group --system --disabled-password --gecos ""

RUN mkdir /data && chown rtrox:rtrox /data
RUN mkdir /config && chown rtrox:rtrox /config

VOLUME ["/data", "/config"]
ENTRYPOINT ["/usr/bin/tini", "--"]
