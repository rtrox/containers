ARG VERSION="3.19.1"
ARG REVISION=""

FROM alpine:$VERSION

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="rtrox/alpine-base"
LABEL org.label-schema.description="Base Image customed for rtrox images."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

USER root

RUN addgroup -S rtrox --gid 314
RUN adduser -S rtrox --uid 314 -G rtrox

RUN apk add --no-cache tini

RUN mkdir /data && chown rtrox:rtrox /data
RUN mkdir /config && chown rtrox:rtrox /config

VOLUME ["/data", "/config"]
ENTRYPOINT ["/sbin/tini", "--"]
