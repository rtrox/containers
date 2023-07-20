ARG VERSION=""
ARG REVISION=""

FROM nginx:stable-alpine as base

LABEL maintainer="rtrox <rtrox@noreply.github.com>"
LABEL org.label-schema.name="vikunji-api"
LABEL org.label-schema.description="Kubernetes Optimized Image for Vikunji API."
LABEL org.label-schema.vendor="rtrox <rtrox@noreply.github.com>"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

FROM vikunja/frontend:${VERSION} as builder

ENV GOPATH=/go

RUN \
    apk add --no-cache go \
    && go install -ldflags="-s -w" github.com/drone/envsubst/cmd/envsubst@latest

ENV VIKUNJA_HTTP_PORT 8080
ENV VIKUNJA_HTTP2_PORT 8081

RUN /go/bin/envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/templates/default.conf
RUN /docker-entrypoint.d/50-injector.sh

FROM base as export

COPY --from=builder /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html
COPY --from=builder /etc/nginx/templates/default.conf /etc/nginx/conf.d/default.conf

RUN chown -R nginx:nginx /etc/nginx/ /usr/share/nginx/

USER nginx

EXPOSE 8080
EXPOSE 8081

VOLUME ["/var/cache/nginx", "/var/run"]

CMD ["nginx", "-g", "daemon off;"]
