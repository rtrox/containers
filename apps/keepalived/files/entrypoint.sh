#!/bin/bash -e

exec \
    /usr/sbin/keepalived \
      --dont-fork \
      --log-console \
      --log-detail \
      "$@"