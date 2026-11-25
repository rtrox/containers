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
    # Needs an encryption-capable key: `pass` encrypts to it. A plain
    # --quick-generate-key "default" usage made a sign-only key ("Unusable
    # public key"), so spell out the capabilities in a batch spec.
    gpg --batch --gen-key <<'EOF_GPG'
%no-protection
Key-Type: RSA
Key-Length: 3072
Key-Usage: sign,encrypt
Name-Real: ProtonBridge
Name-Email: bridge@localhost
Expire-Date: 0
%commit
EOF_GPG
    # Fail loudly now rather than later inside Bridge if the key still can't encrypt.
    echo test | gpg --batch --trust-model always --encrypt -r bridge@localhost >/dev/null
    pass init "$(gpg --list-keys --with-colons | awk -F: '/^fpr/ {print $10; exit}')"
fi

if [ "${1:-}" = "init" ]; then
    touch "${init_flag}"
    trap 'rm -f "${init_flag}"' EXIT
    # Bridge is a launcher ("protonmail-bridge", 16 chars: too long for -x, which
    # silently matches nothing) plus the real binary under /usr/lib. Match both
    # on the full command line.
    bridge_procs='protonmail-bridge --noninteractive|/usr/lib/protonmail/bridge/bridge'
    pkill -f "${bridge_procs}" || true
    # Wait for the lock to be released before opening the CLI.
    for _ in $(seq 1 20); do pgrep -f "${bridge_procs}" >/dev/null || break; sleep 0.5; done
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
