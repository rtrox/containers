#!/usr/bin/env sh

# Ensure volume directories still exist
mkdir -p /data/saves && \
    mkdir -p /data/logs &&  \
    mkdir -p /data/cache && \
    mkdir -p /config

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
