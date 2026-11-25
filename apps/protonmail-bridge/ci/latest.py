#!/usr/bin/env python
"""Print the latest Proton Mail Bridge release version (without the leading v)."""

import requests

URL = "https://api.github.com/repos/ProtonMail/proton-bridge/releases/latest"


def get_latest(channel):
    r = requests.get(URL, timeout=10, headers={"Accept": "application/vnd.github+json"})
    r.raise_for_status()
    return r.json()["tag_name"].lstrip("v")


if __name__ == "__main__":
    import sys

    channel = sys.argv[1]
    print(get_latest(channel))
