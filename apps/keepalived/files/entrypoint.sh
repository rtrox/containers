#!/bin/bash -e

exec \
    keepalived \
      --dont-fork \
      --log-console \
      --log-detail \
      "$@"