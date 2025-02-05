#!/bin/bash -e

exec /usr/sbin/dnsmasq \
        -k \
        --log-facility=- \
        "$@"