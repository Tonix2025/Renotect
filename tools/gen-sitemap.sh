#!/bin/bash
# Rebuilds sitemap.xml: home page, every services/<slug>/ and projects/<slug>/ page, with project images. Run from the repo root.
set -e
today=$(date +%F)
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">'
  echo "  <url><loc>https://www.renotect.ca/</loc><lastmod>$today</lastmod><image:image><image:loc>https://www.renotect.ca/images/projects/silverfox-custom-home-1.jpg</image:loc></image:image></url>"
  for d in services/*/; do
    echo "  <url><loc>https://www.renotect.ca/services/$(basename "$d")/</loc><lastmod>$today</lastmod></url>"
  done
  echo "  <url><loc>https://www.renotect.ca/guides/</loc><lastmod>$today</lastmod></url>"
  for d in guides/*/; do
    echo "  <url><loc>https://www.renotect.ca/guides/$(basename "$d")/</loc><lastmod>$today</lastmod></url>"
  done
  for d in projects/*/; do
    s=$(basename "$d")
    echo "  <url>"
    echo "    <loc>https://www.renotect.ca/projects/$s/</loc>"
    echo "    <lastmod>$today</lastmod>"
    for f in $(ls images/projects/ | grep -E "^$s-(site-)?[0-9]+\.jpg$"); do
      echo "    <image:image><image:loc>https://www.renotect.ca/images/projects/$f</image:loc></image:image>"
    done
    echo "  </url>"
  done
  echo '</urlset>'
} > sitemap.xml
echo "sitemap: $(grep -c '<loc>https://www.renotect.ca/[a-z/-]*</loc>' sitemap.xml) pages"
