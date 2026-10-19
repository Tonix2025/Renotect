#!/bin/bash
# Builds services/<slug>/index.html from tools/services/<slug>.{meta,body,schema}. Run from the repo root.
#   .meta   : shell variables TITLE, DESC, NAME (breadcrumb label), IMG (og image path under /images)
#   .body   : the page's <main> content
#   .schema : JSON objects for the page (Service, FAQPage), comma-separated, added to the @graph
# Header and footer are taken from a built project page so every page shares the same chrome.
set -e
ref=projects/maple-modern-kitchen/index.html
css=$(grep -o 'href="/css/site.css?v=[0-9]*"' "$ref" | head -1)
js=$(grep -o 'src="/js/site.js?v=[0-9]*"' "$ref" | head -1)
fonts=$(grep -o '<link href="https://fonts.googleapis.com/css2[^>]*>' "$ref" | head -1)
chrome_top=$(sed -n '/^<div class="offer">/,/^<\/div><\/header>/p' "$ref")
chrome_bottom=$(sed -n '/^<div class="mbar">/,/^<footer>.*<\/footer>$/p' "$ref")
for meta in tools/services/*.meta; do
  slug=$(basename "$meta" .meta)
  # shellcheck disable=SC1090
  . "$meta"
  url="https://www.renotect.ca/services/$slug/"
  mkdir -p "services/$slug"
  cat > "services/$slug/index.html" <<EOF
<!DOCTYPE html>
<html lang="en-CA">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$TITLE</title>
<meta name="description" content="$DESC">
<meta name="robots" content="index, follow, max-image-preview:large">
<meta name="theme-color" content="#2d5a52">
<link rel="icon" href="/favicon.ico" sizes="48x48">
<link rel="icon" type="image/png" sizes="96x96" href="/images/favicon-96.png">
<link rel="icon" type="image/png" sizes="192x192" href="/images/favicon-192.png">
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png">
<link rel="canonical" href="$url">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Renotect">
<meta property="og:locale" content="en_CA">
<meta property="og:title" content="$TITLE">
<meta property="og:description" content="$DESC">
<meta property="og:url" content="$url">
<meta property="og:image" content="https://www.renotect.ca/images/$IMG">
<meta name="twitter:card" content="summary_large_image">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
$fonts
<link rel="stylesheet" $css>
<script type="application/ld+json">
{"@context":"https://schema.org","@graph":[
{"@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Home","item":"https://www.renotect.ca/"},{"@type":"ListItem","position":2,"name":"Services","item":"https://www.renotect.ca/#services"},{"@type":"ListItem","position":3,"name":"$NAME","item":"$url"}]},
$(cat "tools/services/$slug.schema")
]}
</script>
</head>
<body>
$chrome_top

<main>
<section class="project-hero"><div class="wrap">
<p class="crumbs"><a href="/">Home</a> / <a href="/#services">Services</a> / $NAME</p>
$(cat "tools/services/$slug.body")
</main>

$chrome_bottom
<script $js defer></script>
</body>
</html>
EOF
  echo "built services/$slug"
done
