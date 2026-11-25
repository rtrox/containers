#!/usr/bin/env bash
# Headless Proton Mail Bridge.
#
#   (no args)  run Bridge non-interactively, restarting it if it exits
#   init       one-time interactive login: stops the running Bridge, opens the
#              Bridge CLI (`login`, `info`, `exit`), then lets the loop restart it
#
# Log in once with:  kubectl exec -it <pod> -c <container> -- /entrypoint.sh init
# The session persists in $HOME (/config), so restarts do not need a new login.
set -euo pipefail

export GNUPGHOME="${HOME}/.gnupg"
export PASSWORD_STORE_DIR="${HOME}/.password-store"
init_flag=/tmp/bridge-init

mkdir -p "${GNUPGHOME}"
chmod 700 "${GNUPGHOME}"

# One-time: a passphrase-less GPG key backing the `pass` store. The key lives in
# the same volume as the vault it protects, so it adds no secrecy beyond the
# volume's own access control; it only satisfies Bridge's keychain requirement.
if [ ! -d "${PASSWORD_STORE_DIR}" ]; then
    echo ">> Generating GPG key for pass (one-time)"
    gpg --batch --pinentry-mode loopback --passphrase '' \
        --quick-generate-key "ProtonBridge <bridge@localhost>" rsa3072 default never
    pass init "$(gpg --list-keys --with-colons | awk -F: '/^fpr/ {print $10; exit}')"
fi

if [ "${1:-}" = "init" ]; then
    touch "${init_flag}"
    trap 'rm -f "${init_flag}"' EXIT
    pkill -x protonmail-bridge || true
    # Wait for the lock to be released before opening the CLI.
    for _ in $(seq 1 20); do pgrep -x protonmail-bridge >/dev/null || break; sleep 0.5; done
    protonmail-bridge --cli
    exit 0
fi

# Supervise Bridge so `init` can stop it without the container exiting.
rm -f "${init_flag}"
while true; do
    if [ ! -e "${init_flag}" ]; then
        protonmail-bridge --noninteractive || echo ">> Bridge exited with $?; restarting" >&2
    fi
    sleep 5
done
