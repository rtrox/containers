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

FROM base as builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections

RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6 \
        lib32gcc-s1 \
        ca-certificates \
        locales \
        bash \
        steamcmd

RUN apt-get install -y \
    curl \
    tar

WORKDIR /tmp
RUN curl -fsSL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf -

FROM base as final

COPY --from=builder /tmp/ /usr/lib/games/steam/
COPY --from=builder /usr/games/steamcmd /usr/bin/steamcmd

ARG STEAMCMD_DIR="/steamcmd"
ENV STEAMCMD_DIR=${STEAMCMD_DIR}

RUN ln -s /usr/lib/games/steam/linux32/steamcmd /usr/lib/games/steam/steamcmd

RUN apt-get remove --purge --auto-remove -y && \
    rm -rf /var/lib/apt/lists/*

USER rtrox

RUN steamcmd +quit

CMD ["steamcmd", "+help", "+quit"]
