from steam.client import SteamClient

APP_ID = 211820

def get_latest(channel):
    client = SteamClient()
    client.anonymous_login()
    app = client.get_product_info(apps=[211820])
    return "-".join([
        app["apps"][211820]['depots']['branches'][channel]['buildid'],
        app["apps"][211820]['depots']['branches'][channel]['timeupdated']
    ])

if __name__ == "__main__":
    import sys
    channel = sys.argv[1]
    print(get_latest(channel))
