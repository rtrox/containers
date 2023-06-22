ARG VERSION
ARG REVISION

FROM ghcr.io/rtrox/ubuntu:jammy-20230605 as base

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="rtrox/steamcmd"
LABEL org.label-schema.description="Base SteamCMD Image customed for rtrox images."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG STEAMCMD_DIR="/steamcmd"
ENV STEAMCMD_DIR=${STEAMCMD_DIR}

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6 \
        lib32gcc-s1 \
        ca-certificates \
        locales \
        bash

FROM base as builder

USER rtrox

RUN apt-get install -y curl tar

RUN mkdir -p ${STEAMCMD_DIR}
RUN curl -fsSL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C "${STEAMCMD_DIR}"

FROM base as final

RUN apt-get remove --purge --auto-remove -y && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder ${STEAMCDM_DIR} ${STEAMCMD_DIR}
RUN mkdir -p /home/rtrox/.steam/sdk32/ && \
    ln -s ${STEAMCMD_DIR}/linux32/steamclient.so /home/rtrox/.steam/sdk32/steamclient.so && \
    ln -s ${STEAMCMD_DIR}/linux64/steamclient.so /usr/lib/x86_64-linux-gnu/steamclient.so

USER rtrox

RUN steamcmd +quit

CMD ["steamcmd", "+help", "+quit"]
