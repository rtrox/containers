ARG VERSION
ARG REVISION

FROM jvmilazz0/kavita:$VERSION

RUN cp -r /kavita/config /config
COPY files/entrypoint.sh /kube_entry.sh

LABEL maintainer="rtrox <rtrox@noreply.github.com"
LABEL org.label-schema.name="kavita"
LABEL org.label-schema.description="Kavita Container optimized for Kubernetes"
LABEL org.label-schema.vendor="rtrox"
LABEL org.label-schema.url="https://github.com/rtrox/containers"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-url="https://github.com/rtrox/containers"
LABEL org.label-schema.vcs-ref=$REVISION
LABEL org.label-schema.source="jvmilazz0/kavita"

CMD ["/kube_entry.sh"]