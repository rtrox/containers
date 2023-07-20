#!/usr/bin/env python

import requests
import json

from packaging import version

URL = "https://registry.hub.docker.com/v2/repositories/vikunja/frontend/tags"

def get_latest(channel):
    r = requests.get(URL)
    data = json.loads(r.text)
    ret = ""
    for tag in data['results']:
        try:
            version.parse(tag['name'])
        except version.InvalidVersion:
            continue
        if ret == "" or version.parse(tag['name']) > version.parse(ret):
            ret = tag['name']
    return ret

if __name__ == "__main__":
    import sys
    channel = sys.argv[1]
    print(get_latest(channel))
