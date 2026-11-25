ARG VERSION=""
ARG REVISION=""

# Stage 1: fetch Proton's signed .deb and verify it before it goes anywhere near
# the runtime image. The signing key is pinned by fingerprint, so a swapped key
# file or a tampered package fails the build instead of shipping.
FROM debian:bookworm-slim AS fetch

ARG VERSION
# Proton "ProtonMail Bridge developers" signing key (bridge@protonmail.ch).
ARG BRIDGE_KEY_FPR=D51E64D3E63EDC3EEF7864CEE2C75D68E6234B07

RUN set -eux; \
    test -n "${VERSION}"; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl gnupg; \
    base=https://proton.me/download/bridge; \
    deb="protonmail-bridge_${VERSION}-1_amd64.deb"; \
    cd /tmp; \
    curl -fsSLO "${base}/${deb}"; \
    curl -fsSLO "${base}/${deb}.sig"; \
    curl -fsSLO "${base}/bridge_pubkey.gpg"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --import bridge_pubkey.gpg; \
    gpg --batch --with-colons --fingerprint | grep -q "^fpr:::::::::${BRIDGE_KEY_FPR}:"; \
    gpg --batch --status-fd 1 --verify "${deb}.sig" "${deb}" | grep -q "^\[GNUPG:\] VALIDSIG ${BRIDGE_KEY_FPR} "; \
    mv "${deb}" /bridge.deb

# Stage 2: runtime
FROM debian:bookworm-slim

ARG VERSION
ARG REVISION

LABEL maintainer="rtrox <rtrox@noreply.github.com>"
LABEL org.label-schema.name="protonmail-bridge"
LABEL org.label-schema.description="Headless Proton Mail Bridge (IMAP/SMTP) for Kubernetes, built from Proton's signed .deb."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=fetch /bridge.deb /tmp/bridge.deb

# gnupg + pass: Bridge needs a secret-service backend for its vault; headless,
# it falls back to `pass` (GPG-backed). tini reaps children and forwards signals.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates gnupg pass tini procps libfido2-1 /tmp/bridge.deb; \
    rm -rf /var/lib/apt/lists/* /tmp/bridge.deb; \
    groupadd --gid 568 bridge; \
    useradd --uid 568 --gid 568 --home-dir /config --no-create-home --shell /usr/sbin/nologin bridge; \
    mkdir -p /config; \
    chown 568:568 /config

COPY files/entrypoint.sh /entrypoint.sh
RUN chmod 0755 /entrypoint.sh

# All state (GPG key, pass store, Bridge vault/cache) lives under HOME.
ENV HOME=/config
USER 568:568
WORKDIR /config
VOLUME ["/config"]

# Bridge binds IMAP 1143 and SMTP 1025 on 127.0.0.1 only. Run it as a sidecar and
# connect over localhost; nothing is forwarded to other interfaces.
ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
