FROM alpine:3.21.2
# https://github.com/flungo-docker/avahi

ARG VERSION
ARG REVISION

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="avahi"
LABEL org.label-schema.description="Avahi mDNS Daemon, forked from flungo/avahi."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

RUN apk add --no-cache \
    avahi \
    augeas \
    bash \
    catatonit

ADD files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]