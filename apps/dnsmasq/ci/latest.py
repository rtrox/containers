import requests
import tarfile
import io

def get_latest_package_version(repo_url, version, repo, arch, package_name):
    """
    Fetch the latest available version of a package from Alpine repository.

    Args:
        repo_url (str): Base URL of the Alpine repository.
        version (str): Alpine version (e.g., "v3.18").
        arch (str): Architecture (e.g., "x86_64").
        package_name (str): Name of the package to fetch.

    Returns:
        str: Latest version of the package, or None if not found.
    """
    # Construct the URL for the APKINDEX file
    apkindex_url = f"{repo_url}/{version}/{repo}/{arch}/APKINDEX.tar.gz"

    try:
        # Fetch the APKINDEX file
        response = requests.get(apkindex_url, timeout=10)
        response.raise_for_status()

        # Open the APKINDEX file as a tar archive
        with tarfile.open(fileobj=io.BytesIO(response.content), mode='r:gz') as tar:
            for member in tar:
                if member.name == "APKINDEX":
                    # Extract and read the APKINDEX file
                    apkindex_data = tar.extractfile(member).read().decode('utf-8')

                    # Parse the APKINDEX data
                    lines = apkindex_data.splitlines()
                    for i, line in enumerate(lines):
                        if line.startswith(f"P:{package_name}"):
                            # The version is in the next line starting with "V:"
                            version_line = lines[i + 1]
                            if version_line.startswith("V:"):
                                return version_line[2:]  # Strip the "V:" prefix
    except Exception as e:
        print(f"Error fetching or parsing APKINDEX: {e}")
        return None

    return None

# Example usage
repo_url = "https://dl-cdn.alpinelinux.org/alpine"
version = "v3.21"
repo = "main"
arch = "x86_64"
package_name = "dnsmasq"

def get_latest(channel):
    return get_latest_package_version(repo_url, version, repo, arch, package_name)

if __name__ == "__main__":
    import sys
    channel = sys.argv[1]
    print(get_latest(channel))