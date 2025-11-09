import requests
import re
import sys
import tarfile
import os
import zipfile

BASE_URL = "https://api.github.com/repos"


def get_releases(repo):
    """
    Get release description from github
    """
    response = requests.get(f"{BASE_URL}/{repo}/releases/latest")

    raw = response.json()
    assets = raw["assets"]

    # Get the name and the url
    releases = list(
        map(lambda x: {"name": x["name"], "url": x["browser_download_url"]}, assets)
    )

    return releases


def get_release(keywords, releases):
    """
    Check and get the release that matches the keyword here
    """
    # Compile the regex
    lookaheads = "".join(f"(?=.*{k})" for k in keywords)
    negative = "".join(f"(?!.*({'|'.join(keywords)}).*\\1)")
    exp = f"^{lookaheads}{negative}.+$"

    url = ""
    for release in releases:
        name = release["name"]

        # Check for keywords
        regex = re.compile(exp)

        if regex.search(name):
            url = release["url"]
            break

    return url


def get_release_file(url, filename):
    """
    Unwrap the release and get the binary
    The type can either be a zip or tar
    """
    # Get the file provided
    response = requests.get(url, stream=True)
    response.raise_for_status()

    with open(filename, "wb") as f:
        for chunk in response.iter_content(chunk_size=8192):
            if chunk:
                f.write(chunk)

    return filename


def unzip_file(zip):
    """
    Unzip the file
    """
    with zipfile.ZipFile(zip, "r") as file:
        file.extractall()
    os.remove(zip)


def untar_file(tar):
    """
    Untar the file
    """
    with tarfile.open(tar, "r:gz") as file:
        file.extractall()
        os.remove(tar)


def main():
    """
    Entrance
    """
    repo = ""
    filename = ""
    keywords = ""
    binary = 0  # - | 1 | 2 -> 0 is binary, 1 is zip and 2 is tar

    try:
        repo = sys.argv[1]
        filename = sys.argv[2]
        keywords = sys.argv[3].split(",")
        binary = {"binary": 0, "zip": 1, "tar": 2}.get(sys.argv[4].lower(), 0)
    except Exception:
        print(
            "Ex: python3 binary-github.py [repo] [filename] ['keyword1,keyword2'] ['zip' | 'binary' | 'tar']"
        )
        quit(1)

    releases = get_releases(repo)
    url = get_release(keywords, releases)
    file = get_release_file(url, filename or "")

    if binary == 2:
        untar_file(file)
    elif binary == 1:
        unzip_file(file)


main()
