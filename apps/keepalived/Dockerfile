FROM alpine:3.23.0
# https://github.com/flungo-docker/avahi

ARG VERSION
ARG REVISION

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="keepalived"
LABEL org.label-schema.description="Minimal Keepalived Container"
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

COPY files/keepalived.conf /etc/keepalived/keepalived.conf
COPY files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN apk add --no-cache \
    bash \
    catatonit \
    keepalived

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]