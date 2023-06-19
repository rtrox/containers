ARG VERSION=""
ARG REVISION=""

FROM ghcr.io/rtrox/alpine:3.18 as base

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="ghcr.io/rtrox/necesse-server"
LABEL org.label-schema.description="Dockerized Necessse Server optimized for Kubernetes."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

ENV WORLD_NAME="world"
ENV SLOTS=10
ENV OWNER=""
ENV MOTD="Necesse Powered by Kubernetes"
ENV PASSWORD=""
ENV PAUSE=0
ENV GIVE_CLIENTS_POWER=0
ENV LOGGING=1
ENV JVMARGS=""

FROM base as builder

ENV NECESSE_SERVER_FILES_URL="https://necessegame.com/server/"

RUN apk add --no-cache \
    bash  \
    curl  \
    wget  \
    unzip \
    sed

RUN mkdir -p /tmp
COPY ./download-server-files.sh /tmp/download-server-files.sh
RUN chmod +x /tmp/download-server-files.sh  && \
    /tmp/download-server-files.sh ${NECESSE_SERVER_FILES_URL} ${VERSION} && \
    unzip server-files.zip -d /tmp && \
    mv /tmp/necesse-server* /tmp/necesse-server && \
    rm -rf /tmp/necesse-server/jre && \
    ls -lahR /tmp

FROM base as export

RUN apk add --no-cache openjdk8 && \
    rm -rf /var/cache/apk/*

COPY --from=builder /tmp/necesse-server /necesse
COPY ./entrypoint.sh /necesse/entrypoint.sh
RUN chmod +x /necesse/entrypoint.sh

EXPOSE 14159/udp
VOLUME ["/data", "/config"]

RUN mkdir -p /data/saves && \
    mkdir -p /data/logs &&  \
    mkdir -p /data/cache && \
    ln -s /data/saves /necesse/saves && \
    ln -s /data/logs /necesse/logs && \
    ln -s /data/cache /necesse/cache && \
    ln -s /config /necesse/cfg

WORKDIR /necesse

ENTRYPOINT ["/necesse/entrypoint.sh"]

