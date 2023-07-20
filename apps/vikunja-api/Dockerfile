ARG VERSION=""
ARG REVISION=""

FROM ghcr.io/rtrox/alpine:3.18 as base

LABEL maintainer="rtrox <rtrox@noreply.github.com>"
LABEL org.label-schema.name="vikunji-api"
LABEL org.label-schema.description="Kubernetes Optimized Image for Vikunji API."
LABEL org.label-schema.vendor="rtrox <rtrox@noreply.github.com>"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

FROM vikunja/api:${VERSION} as builder

FROM base as export

WORKDIR /app/vikunja

RUN apk add --no-cache tzdata && \
    rm -rf /var/cache/apk/*

RUN mkdir files && chown -R rtrox:rtrox files && chown -R rtrox:rtrox /app/vikunja

COPY --from=builder /app/vikunja/vikunja /app/vikunja/vikunja

ENV VIKUNJA_SERVICE_ROOTPATH=/app/vikunja/
ENV PUID 314
ENV PGID 314

EXPOSE 3456

CMD ["/app/vikunja/vikunja"]
