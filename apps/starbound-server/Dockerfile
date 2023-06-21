FROM ghcr.io/rtrox/steamcmd:0-20180105-4

ARG VERSION
ARG REVISION

ARG INSTALL_DIR=/starbound
ENV INSTALL_DIR=${INSTALL_DIR}

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="starbound-server"
LABEL org.label-schema.description="Containerized Starbound Server optimized for use in Kubernetes."
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION

USER root
COPY files/entrypoint.sh /entrypoint.sh
COPY files/install.sh /install.sh
COPY files/prepare_update.sh /prepare_update.sh
COPY files/install.txt /install.txt
COPY files/configure_server.sh /configure_server.sh
COPY files/starbound_server.config.template /starbound_server.config.template

RUN chmod +x \
    /entrypoint.sh \
    /install.sh \
    /prepare_update.sh \
    /configure_server.sh

RUN mkdir -p ${INSTALL_DIR} && chown -R rtrox:rtrox ${INSTALL_DIR}

USER rtrox

EXPOSE 21025/tcp

CMD ["/entrypoint.sh"]
