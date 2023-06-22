#!/usr/bin/env bash

# Setup error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

#Exit Handler
exit_handler()
{
    printf "\nWaiting for server to shutdown...\n"
    kill -SIGINT "$child"
    sleep 5

    printf "Terminating..,\n"
    exit 0
}
trap "exit_handler" SIGHUP SIGINT SIGQUIT SIGTERM

printf  "Running as user: %s\n" "$(whoami)"

# Trim trailing slash
if [ "${INSTALL_DIR}" != "/" ]; then
    export INSTALL_DIR=${INSTALL_DIR%%/}
fi

if [ -z "${INSTALL_DIR}"]; then
    printf "Error: INSTALL_DIR environmental variable must be set."
    exit 1
fi

if [ ! -z "${UNATTENDED}"  ]; then
    ./install.sh
else
    if [ ! -f "${INSTALL_DIR}/installed" ] || [ -f "${INSTALL_DIR}/needs_update"]; then
        printf "Waiting for install or update. Attach to the container and run %s.\n" "/install.sh"
        printf "\nTo attach in docker:\n"
        printf "\tdocker exec -it <container name> bash\n"
        printf "\nTo attach in Kubernetes:\n"
        printf "\tkubectl exec -it <pod name> -- bash\n"
    fi

    while [ ! -f "${INSTALL_DIR}/installed" ] || [ -f "${INSTALL_DIR}/needs_update" ]; do
        printf "."
        sleep 5
    done
fi

printf "\n\nInstall/Update complete.\n"

# Configure Server
printf "Configuring Starbound server... "
/configure_server.sh
printf "Done.\n"

# Start Server
printf "Starting Starbound server...\n"
cd ${INSTALL_DIR}/linux/ && ./starbound_server &

child=$!

wait $child
