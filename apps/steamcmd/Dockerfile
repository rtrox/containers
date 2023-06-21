ARG VERSION
ARG REVISION

FROM ghcr.io/rtrox/ubuntu:jammy-20230605 AS builder

WORKDIR /tmp

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections

ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        locales \
        steamcmd \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    tar

RUN curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
    -o steamcmd.tar.gz
RUN tar -xvzf steamcmd.tar.gz && \
    rm steamcmd.tar.gz

# -- FINAL IMAGE -- #
FROM ghcr.io/rtrox/alpine:3.18.2 AS final

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="rtrox/steamcmd"
LABEL org.label-schema.description="Base SteamCMD Image customed for rtrox images."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

COPY --from=builder /tmp/steamcmd.sh /usr/lib/games/steam/
COPY --from=builder /tmp/linux32/steamcmd /usr/lib/games/steam/
COPY --from=builder /usr/games/steamcmd /usr/bin/steamcmd

COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /lib/i386-linux-gnu /lib/
COPY --from=builder /tmp/linux32/libstdc++.so.6 /lib/

RUN apk add --no-cache bash

RUN steamcmd +quit

CMD ["steamcmd", "+help", "+quit"]
