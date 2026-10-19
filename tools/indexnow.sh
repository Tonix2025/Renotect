#!/bin/bash
# Tells Bing (and other IndexNow engines) which pages changed. Run from the repo root after a push.
#   bash tools/indexnow.sh                 -> submits every page in sitemap.xml
#   bash tools/indexnow.sh <url> [<url>...] -> submits only those URLs
key=c666ba46a1ad47f09a20abf8010bd217
if [ $# -gt 0 ]; then urls=("$@"); else mapfile -t urls < <(grep -o '<loc>https://www.renotect.ca/[a-z0-9/-]*</loc>' sitemap.xml | sed 's#</\?loc>##g'); fi
list=$(printf '"%s",' "${urls[@]}"); list="[${list%,}]"
curl -s -o /dev/null -w "IndexNow: HTTP %{http_code} for ${#urls[@]} URLs\n" -X POST https://api.indexnow.org/indexnow -H "Content-Type: application/json; charset=utf-8" --data "{\"host\":\"www.renotect.ca\",\"key\":\"$key\",\"keyLocation\":\"https://www.renotect.ca/$key.txt\",\"urlList\":$list}"
