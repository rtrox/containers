ARG VERSION
ARG REVISION

FROM ghcr.io/rtrox/ubuntu:jammy-20240911.1 as base

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="rtrox/steamcmd"
LABEL org.label-schema.description="Base SteamCMD Image customed for rtrox images."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

FROM base as builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections

ENV USER rtrox
ENV HOMEDIR "/home/${USER}"
ENV STEAMCMD_DIR "${HOMEDIR}/steamcmd"

RUN apt-get update -y && \
    apt-get install -y \
        lib32stdc++6 \
        lib32gcc-s1 \
        ca-certificates \
        curl

USER $USER

RUN mkdir -p ${STEAMCMD_DIR} && \
    curl -fsSL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C "${STEAMCMD_DIR}" && \
    ${STEAMCMD_DIR}/steamcmd.sh +quit

RUN mkdir -p "${HOMEDIR}/.steam/sdk32" && \
    ln -s "${STEAMCMD_DIR}/linux32/steamclient.so" "${HOMEDIR}/.steam/sdk32/steamclient.so" && \
    ln -s "${STEAMCMD_DIR}/linux32/steamcmd" "${STEAMCMD_DIR}/linux32/steam" && \
    ln -s "${STEAMCMD_DIR}/steamcmd.sh" "${STEAMCMD_DIR}/steam.sh"

USER root
# Symlink steamclient.so; So misconfigured dedicated servers can find it
RUN ln -s "${STEAMCMD_DIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so"
COPY ./steamcmd /usr/bin/steamcmd
RUN chmod +x /usr/bin/steamcmd

RUN apt-get remove --purge --auto-remove -y && \
    rm -rf /var/lib/apt/lists/*

USER $USER
RUN steamcmd +quit

CMD ["steamcmd", "+help", "+quit"]
