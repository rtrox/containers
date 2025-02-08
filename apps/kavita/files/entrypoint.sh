#! /bin/bash

if [ ! -f /kavita/config/appsettings.json ]; then
    cp -r /config/* /kavita/config/
fi

chmod +x /entrypoint.sh
/entrypoint.sh