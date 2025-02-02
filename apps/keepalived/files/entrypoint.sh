#!/bin/bash -e

exec \
    /usr/bin/keepalived \
      --dont-fork \
      --log-console \
      --log-detail \
      "$@"