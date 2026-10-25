#!/bin/bash
# Builds guides/<slug>/index.html from tools/guides/<slug>.{meta,body,schema}, plus the guides/ index. Run from the repo root.
#   .meta   : shell variables TITLE, DESC, NAME (breadcrumb label), H1, SUMMARY (index card text), IMG (og image under /images), DATE (YYYY-MM-DD)
#   .body   : article content; it starts inside the hero wrap and closes it
#   .schema : JSON objects (e.g. FAQPage), comma-separated, added to the @graph after the Article
# Header and footer are taken from a built project page so every page shares the same chrome.
set -e
ref=projects/maple-modern-kitchen/index.html
css=$(grep -o 'href="/css/site.css?v=[0-9]*"' "$ref" | head -1)
js=$(grep -o 'src="/js/site.js?v=[0-9]*"' "$ref" | head -1)
fonts=$(grep -o '<link href="https://fonts.googleapis.com/css2[^>]*>' "$ref" | head -1)
chrome_top=$(sed -n '/^<div class="offer">/,/^<\/div><\/header>/p' "$ref")
chrome_bottom=$(sed -n '/^<div class="mbar">/,/^<footer>.*<\/footer>$/p' "$ref")
beacon=$(grep -o "<script defer src='https://static.cloudflareinsights.com[^>]*></script>" "$ref" | head -1)

head_block() { # title, desc, url, og image, og type
cat <<EOF
<!DOCTYPE html>
<html lang="en-CA">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$1</title>
<meta name="description" content="$2">
<meta name="robots" content="index, follow, max-image-preview:large">
<meta name="theme-color" content="#2d5a52">
<link rel="icon" href="/favicon.ico?v=2" sizes="48x48">
<link rel="icon" type="image/png" sizes="96x96" href="/images/favicon-96.png?v=2">
<link rel="icon" type="image/png" sizes="192x192" href="/images/favicon-192.png?v=2">
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png?v=2">
<link rel="canonical" href="$3">
<meta property="og:type" content="$5">
<meta property="og:site_name" content="Renotect">
<meta property="og:locale" content="en_CA">
<meta property="og:title" content="$1">
<meta property="og:description" content="$2">
<meta property="og:url" content="$3">
<meta property="og:image" content="https://www.renotect.ca/images/$4">
<meta name="twitter:card" content="summary_large_image">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
$fonts
<link rel="stylesheet" $css>
EOF
}

cards=""
for meta in tools/guides/*.meta; do
  slug=$(basename "$meta" .meta)
  # shellcheck disable=SC1090
  . "$meta"
  url="https://www.renotect.ca/guides/$slug/"
  pretty=$(date -d "$DATE" '+%B %-d, %Y')
  mkdir -p "guides/$slug"
  {
    head_block "$TITLE" "$DESC" "$url" "$IMG" article
    cat <<EOF
<script type="application/ld+json">
{"@context":"https://schema.org","@graph":[
{"@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Home","item":"https://www.renotect.ca/"},{"@type":"ListItem","position":2,"name":"Guides","item":"https://www.renotect.ca/guides/"},{"@type":"ListItem","position":3,"name":"$NAME","item":"$url"}]},
{"@type":"Article","headline":"$H1","description":"$DESC","image":"https://www.renotect.ca/images/$IMG","datePublished":"$DATE","dateModified":"$DATE","author":{"@id":"https://www.renotect.ca/#business"},"publisher":{"@id":"https://www.renotect.ca/#business"},"mainEntityOfPage":"$url"},
$(cat "tools/guides/$slug.schema")
]}
</script>
</head>
<body>
$chrome_top

<main>
<section class="project-hero"><div class="wrap">
<p class="crumbs"><a href="/">Home</a> / <a href="/guides/">Guides</a> / $NAME</p>
<span class="eyebrow">Guide · $pretty</span>
<h1>$H1</h1>
$(cat "tools/guides/$slug.body")
</main>

$chrome_bottom
$beacon
<script $js defer></script>
</body>
</html>
EOF
  } > "guides/$slug/index.html"
  cards+="<li><a href=\"/guides/$slug/\"><span class=\"eyebrow\">$pretty</span><h3>$H1</h3><p>$SUMMARY</p></a></li>"$'\n'
  echo "built guides/$slug"
done

{
  head_block "Renovation and Permit Guides for Toronto Homes | Renotect" "Plain-language guides to renovating in Toronto: building permits, structural changes, kitchens and bathrooms, from a BCIN-qualified design studio." "https://www.renotect.ca/guides/" "renotect-share.jpg" website
  cat <<EOF
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Home","item":"https://www.renotect.ca/"},{"@type":"ListItem","position":2,"name":"Guides","item":"https://www.renotect.ca/guides/"}]}
</script>
</head>
<body>
$chrome_top

<main>
<section class="project-hero"><div class="wrap">
<p class="crumbs"><a href="/">Home</a> / Guides</p>
<span class="eyebrow">Guides</span>
<h1>Renovation and permit guides</h1>
<p>Plain-language answers to the questions we hear most from Toronto homeowners, from building permits to structural changes, kitchens and bathrooms.</p>
<ul class="guide-list">
$cards</ul>
</div></section>
</main>

$chrome_bottom
$beacon
<script $js defer></script>
</body>
</html>
EOF
} > guides/index.html
echo "built guides/index"
