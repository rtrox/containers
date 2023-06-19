#!/usr/bin/env sh

cd "$(dirname "$0")"
java ${JVMARGS} -jar Server.jar           \
-nogui                                    \
-world ${WORLD_NAME}                      \
-slots ${SLOTS}                           \
-owner ${OWNER}                           \
-motd ${MOTD}                             \
-password ${PASSWORD}                     \
-pausewhenempty ${PAUSE}                  \
-giveclientspower ${GIVE_CLIENTS_POWER}   \
-zipsaves 1
