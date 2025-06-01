ARG VERSION
ARG REVISION

FROM alpine:3.22.0

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="keepalived"
LABEL org.label-schema.description="Minimal Keepalived Container"
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

COPY files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN apk add --no-cache \
    bash \
    catatonit \
    dnsmasq

EXPOSE 53 67 69
ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]