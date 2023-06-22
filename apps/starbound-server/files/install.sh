#!/usr/bin/env bash

# Enable debugging
# set -x

# Setup error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

printf  "Running as user: %s\n" "$(whoami)"

# Strip trailing slash
if [ "${INSTALL_DIR}" != "/" ]; then
    export INSTALL_DIR=${INSTALL_DIR%%/}
fi

if [ -z "$STEAM_USERNAME" ] || [ -z "$STEAM_PASSWORD" ]; then
    printf "STEAM_USERNAME and STEAM_PASSWORD environmental variables must be set.\n"
    exit
fi

if [ ! -d $INSTALL_DIR ]; then
    mkdir -p $INSTALL_DIR
fi

printf "Installing to %s\n" "${INSTALL_DIR}"

# Copy file into place to preserve ability to leave filesystem read-only
# (${INSTALL_DIR} is a volume mount)
cp /install.txt ${INSTALL_DIR}/install.txt
sed -i "s/login anonymous/login $STEAM_USERNAME $STEAM_PASSWORD/" ${INSTALL_DIR}/install.txt

sed -i "s:force_install_dir /starbound:force_install_dir ${INSTALL_DIR}:" ${INSTALL_DIR}/install.txt

# Install Mods
IFS=',' read -ra STARBOUND_MODS <<< "$STARBOUND_MODS"
for mod in ${STARBOUND_MODS[@]}; do
    if ! grep $mod ${INSTALL_DIR}/install.txt; then
        sed -i "/^quit/i\workshop_download_item 211820 ${mod}" ${INSTALL_DIR}/install.txt
    fi
done

steamcmd +runscript ${INSTALL_DIR}/install.txt

if [ $? != 0 ] || [ ! -f ${INSTALL_DIR}/linux/starbound_server ]; then
    printf "SteamCMD failed to install Starbound, exiting.\n"
    exit 1
fi

# Mod Files could be copied to $INSTALL_DIR/mods, but the starbound server only seems to recognize and log
# Mod names when they are accessed from the content folder.
for mod in $(find ${INSTALL_DIR}/steamapps/workshop/content/211820/ -mindepth 1 -type d); do
  if ! grep -q $mod ${INSTALL_DIR}/linux/sbinit.config; then
    printf "Adding %s to sbinit.config\n" "$mod"
    sed -i "/\"\.\.\/assets\/\"/i\    \"$mod\"," ${INSTALL_DIR}/linux/sbinit.config
  fi
done

touch ${INSTALL_DIR}/installed
rm ${INSTALL_DIR}/install.txt
[[ -f ${INSTALL_DIR}/needs_update ]] && rm ${INSTALL_DIR}/needs_update

printf "Install/Update sequence complete. To run an attended upgrade in the future, run ./prepare_update.sh, and restart the container, after which you can re-run this script.\n"
