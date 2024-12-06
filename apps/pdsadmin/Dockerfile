FROM ubuntu:24.04

ARG VERSION
ARG REVISION

ARG PDS

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="pdsadmin"
LABEL org.label-schema.description="Container containing the pdsadmin script for managing Bluesky Personal Data Server."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

USER root

COPY files/entrypoint.sh /entrypoint.sh
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    jq \
    openssl \
    sqlite3 \
    xxd \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*
RUN curl --silent --show-error --fail --output "/usr/local/bin/pdsadmin" \
    https://raw.githubusercontent.com/bluesky-social/pds/refs/tags/${VERSION}/pdsadmin.sh
RUN chmod +x /usr/local/bin/pdsadmin

CMD ["/entrypoint.sh"]
