#!/usr/bin/env python3

import requests
import json

URL = "https://api.launchpad.net/1.0/ubuntu/+archive/primary?ws.op=getPublishedSources&source_name=steamcmd&exact_match=true"

def get_latest(_):
    r = requests.get(URL)
    data = json.loads(r.text)
    for pkg in data['entries']:
        if pkg['distro_series_link'] == "https://api.launchpad.net/1.0/ubuntu/jammy":
            return pkg['source_package_version'].replace("~", "-")

if __name__ == "__main__":
    import sys
    channel = sys.argv[1]
    print(get_latest(channel))
