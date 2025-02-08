#!/usr/bin/env python

import requests
import json

# Get the latest version of Alpine Linux

URL = "https://registry.hub.docker.com/v2/repositories/jvmilazz0/kavita/tags?page_size=200&ordering=last_updated"

def get_latest(channel):
    u = URL
    if channel != "stable":
        u = f"{URL}&name={channel}"
    r = requests.get(u)
    data = json.loads(r.text)
    for tag in data['results']:
        if tag['name'] == "latest":
            continue
        if channel == "stable":
            if tag['name'].startswith("nightly") or tag['name'].startswith("canary"):
                continue
            return tag['name']
        else:
            if tag['name'].startswith(channel):
                return tag['name']

if __name__ == "__main__":
    import sys
    channel = sys.argv[1]
    print(get_latest(channel))
