#!/usr/bin/env python

import requests
import json

# Get the latest version of Alpine Linux

URL = "https://api.github.com/repos/bluesky-social/pds/tags"

def get_latest(channel):
    r = requests.get(URL)
    data = json.loads(r.text)
    return data[0]["name"]

if __name__ == "__main__":
    import sys
    channel = sys.argv[1]
    print(get_latest(channel))
