#!/usr/bin/env sh

mkdir -p /data/saves && \
    mkdir -p /data/logs &&  \
    mkdir -p /data/cache && \
    mkdir -p /config && \
    ln -s /data/saves /necesse/saves && \
    ln -s /data/logs /necesse/logs && \
    ln -s /data/cache /necesse/cache && \
    ln -s /config /necesse/cfg

cd "$(dirname "$0")"
java ${JVMARGS} -jar Server.jar           \
-nogui                                    \
-localdir                                 \
-world ${WORLD_NAME}                      \
-slots ${SLOTS}                           \
-owner ${OWNER}                           \
-motd ${MOTD}                             \
-password ${PASSWORD}                     \
-pausewhenempty ${PAUSE}                  \
-giveclientspower ${GIVE_CLIENTS_POWER}   \
-zipsaves 1
