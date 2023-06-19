#!/usr/bin/env python

import requests
import re

SEARCH=r"https.*linux64-([0-9]+-[0-9]+-[0-9]+).*zip"

URL="https://necessegame.com/server/"

def get_latest(channel):
    r = requests.get(URL)
    if r.status_code != 200:
        return None
    data = r.text
    versions = re.findall(SEARCH, data)
    if len(versions) == 0:
        return None
    return versions[0].replace("-", ".")

if __name__ == "__main__":
    import sys
    channel = sys.argv[1]
    print(get_latest(channel))
