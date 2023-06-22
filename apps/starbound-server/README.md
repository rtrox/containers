# Starbound: Attended vs Unattended Installations

Chucklefish has configured their apps, even their dedicated server app, to require authentication to install. As such, the starbound server files are not present in this image, instead, the entrypoint script will authenticate with your credentials, and download or update the starbound installation. As most of us use Steam Guard, this means that installations and updates typically require human interaction.

If you do *not* have Steam Guard configured on your steam account, you can set the `UNATTENDED` environmental variable to any value to automate installation. If you do, the container will pause on start to allow you to `exec` into the container to provide your Steam Guard token.

Once you start the container, you will see this message in the logs:
```
Running as user: rtrox
Waiting for install or update. Attach to the container and run /install.sh.

To attach in docker:
    docker exec -it <container name> bash

To attach in Kubernetes:
    kubectl exec -it <pod name> -- bash
.....
```

Proceed to "Authenticating & Installing"

## Authenticating & Installing

Because Starbound requires login to download, you'll need to enter your Steam Guard code, so first install must be slightly interactive. Once installed, interaction is only needed when you'd like to update. Once you're ready:

1. Enter the container
```
docker exec -it starbound-docker-starbound-1 /bin/bash
```

2. Run the install script
```
/install.sh
```

3. Enter your Steam Guard code when you see the prompt:
```
steam@3dfa89b7a099:/$ /home/steam/install.sh
Running as user: steam
Installing to /home/steam/starbound/
Redirecting stderr to '/home/steam/Steam/logs/stderr.txt'
[  0%] Checking for available updates...
[----] Verifying installation...
[  0%] Downloading update...
[  0%] Checking for available updates...
[----] Download complete.
[----] Extracting package...
[----] Extracting package...
[----] Extracting package...
[----] Extracting package...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Cleaning up...
[----] Update complete, launching Steamcmd...
Redirecting stderr to '/home/steam/Steam/logs/stderr.txt'
[  0%] Checking for available updates...
[----] Verifying installation...
Steam Console Client (c) Valve Corporation - version 1679680174
-- type 'quit' to exit --
Loading Steam API...OK
@sSteamCmdForcePlatformType linux
"@sSteamCmdForcePlatformType" = "linux"
force_install_dir /starbound
Logging in user 'yourusername' to Steam Public...
Enter the current code from your Steam Guard Mobile Authenticator app
Two-factor code:ABCDF
OK
Waiting for client config...OK
Waiting for user info...OK
```

## Updating

1. exec into the container, and run `/prepare_update.sh`. This script will touch a file that tells the entrypoint to pause for an update on the next server restart.

2. Restart your container, and re-run `/install.sh`. The script will clean up after itself, no other steps are needed to return to unattended restarts.

## Available Configuration Variables

Variable | Description | Required
--- | ---  | ---
STEAM_USERNAME | Username you use to login to Steam. This account must have a license for Starbound | ✅
STEAM_PASSWORD | Password you use to login to Steam | ✅
INSTALL_DIR | Directory in the container to install Starbound to (default: /starbound) |
UNATTENDED | Indicates that the specified account does not have Steam Guard enabled, and the install can be unattended |
STARBOUND_MODS | Comma delimited list of mod ids to install |
SERVER_NAME | Name to use for the server in server listings. |
SERVER_PORT | Port to listen on (don't change this without changing your deployment's port) |
RCON_PORT | Port for RCON to listen on |
RCON_PASSWORD | Password for RCON Access |
RUN_RCON_SERVER | Turn on RCON Server |
RUN_QUERY_SERVER | Turn on Query Server |
MAX_PLAYERS | Set server slot count |
MAX_TEAM_SIZE | Set the max players on a given team |
