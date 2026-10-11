#!/bin/bash
# Builds projects/<slug>/index.html from the data below. Run from the repo root.
set -e
SLUGS=(north-york-custom-home green-kitchen-island skylight-bathroom oak-green-kitchen custom-vanities)
declare -A NAME TITLE DESC INTRO TYPE LOC SCOPE IMGS
declare -A CAT=([north-york-custom-home]="Residential" [skylight-bathroom]="Residential" [green-kitchen-island]="Millwork &amp; Kitchen" [oak-green-kitchen]="Millwork &amp; Kitchen" [custom-vanities]="Millwork &amp; Kitchen")

NAME[north-york-custom-home]="Custom home facade, North York"
TITLE[north-york-custom-home]="Custom Home Facade Design, North York"
DESC[north-york-custom-home]="Facade design for a new custom home in North York: limestone-style cladding, slate mansard roof, black-framed windows and planned exterior lighting."
INTRO[north-york-custom-home]="Exterior design for a new custom home on McGillivray Avenue in North York. The front elevation pairs smooth limestone-style cladding with a dark slate mansard roof, tall black-framed windows and a double garage. Lighting was planned as part of the design, with soffit pot lights and wall sconces that frame the windows after dark."
TYPE[north-york-custom-home]="New custom home"; LOC[north-york-custom-home]="North York, Toronto"; SCOPE[north-york-custom-home]="Facade design, exterior lighting, 3D visuals"
IMGS[north-york-custom-home]="1|1600|900|Front elevation of the custom home in daylight, with stone steps and a double garage
2|1600|900|The same facade at dusk with soffit lights and wall sconces on
3|1600|900|Close-up of the upper window, stone surround and lit soffits"

NAME[green-kitchen-island]="Sage green kitchen with island"
TITLE[green-kitchen-island]="Sage Green Kitchen with Island, Kitchen Design"
DESC[green-kitchen-island]="Kitchen design with sage green shaker cabinetry, a large island with seating, built-in appliances and layered lighting, by Renotect in the GTA."
INTRO[green-kitchen-island]="A kitchen planned around a long island with seating for four. Sage green shaker cabinets run to the ceiling, with the fridge, wall oven and coffee station built in flush. A tray ceiling with cove lighting, under-cabinet LEDs and glass pendants layer the light for cooking and for evenings."
TYPE[green-kitchen-island]="Kitchen renovation"; LOC[green-kitchen-island]="Greater Toronto Area"; SCOPE[green-kitchen-island]="Layout, custom cabinetry, lighting design"
IMGS[green-kitchen-island]="1|1403|1121|Sage green kitchen with a large island, bar stools and full-height cabinetry
2|1402|1122|Two views of the kitchen: the island and window wall, and the gas range with open shelves"

NAME[skylight-bathroom]="Skylight bathroom"
TITLE[skylight-bathroom]="Skylight Bathroom Renovation, Bathroom Design"
DESC[skylight-bathroom]="Bathroom design with a skylight, floating oak vanity, backlit mirror, large-format tile and frameless glass shower, by Renotect in the GTA."
INTRO[skylight-bathroom]="A bathroom designed around natural light from a skylight. A floating oak vanity with an open shelf and toe-kick lighting, a backlit mirror, large-format porcelain tile and a frameless glass shower keep the room bright, calm and easy to clean."
TYPE[skylight-bathroom]="Bathroom renovation"; LOC[skylight-bathroom]="Greater Toronto Area"; SCOPE[skylight-bathroom]="Layout, vanity, tile and lighting"
IMGS[skylight-bathroom]="1|928|1232|Bathroom with skylight, floating oak vanity, backlit mirror and glass shower
2|928|1232|Floating vanity with open shelf and toe-kick lighting beside the shower
3|928|1232|Oak vanity drawers, backlit mirror and shower niche under the skylight"

NAME[oak-green-kitchen]="Oak and green kitchen"
TITLE[oak-green-kitchen]="Oak and Green Kitchen Design, Toronto"
DESC[oak-green-kitchen]="Toronto kitchen design pairing deep green shaker cabinetry with warm oak: oak island, lit open shelving, tall pantry towers and a farmhouse sink."
INTRO[oak-green-kitchen]="Deep green shaker cabinetry paired with warm oak: an oak-topped island, lit oak open shelving and wide-plank floors. Tall pantry and oven towers keep storage on one wall, and a farmhouse sink sits under the window."
TYPE[oak-green-kitchen]="Kitchen renovation"; LOC[oak-green-kitchen]="Toronto"; SCOPE[oak-green-kitchen]="Kitchen design, custom millwork"
IMGS[oak-green-kitchen]="1|1600|719|Green shaker kitchen with an oak island, open shelving and under-cabinet lighting"

NAME[custom-vanities]="Custom vanities"
TITLE[custom-vanities]="Custom Bathroom Vanity Designs, Toronto"
DESC[custom-vanities]="Three custom bathroom vanity designs by Renotect: shaker double vanity, flat-panel vanity with arched mirrors and a green double vanity with integrated lighting."
INTRO[custom-vanities]="Three vanity designs, each with custom cabinetry sized to its room: a green double vanity with integrated lighting, a sage shaker double vanity with a centre linen tower, and a floating olive vanity with three arched mirrors."
TYPE[custom-vanities]="Custom millwork"; LOC[custom-vanities]="Toronto and the GTA"; SCOPE[custom-vanities]="Vanity design, mirrors and lighting"
IMGS[custom-vanities]="1|1024|1024|Green double vanity with drawers, stone top and mirrors with vertical lights
2|1024|1024|Sage shaker double vanity with a centre tower and black-framed mirrors
3|1600|1600|Floating olive vanity with three arched backlit mirrors"

# Construction photos (optional per project): "site-N|width|height|alt", files images/projects/<slug>-site-N.jpg
declare -A SITE SITE_INTRO
SITE[north-york-custom-home]="site-3|1280|677|Front of the house during construction, with the third-floor dormers framed and the walls sheathed
site-2|1280|677|Angled view of the framed and sheathed house, showing the dormer framing and roof trusses
site-1|1280|721|Closer view of the front during construction, with window openings boarded and the front steps in place"
SITE_INTRO[north-york-custom-home]="Photos from site during construction, with the upper floors framed and sheathed."

items() { # slug, data, first-image-eager(1/0)
  local out="" n w h alt lazy
  while IFS='|' read -r n w h alt; do
    [ -z "$n" ] && continue
    lazy=' loading="lazy"'; [ "$3" = 1 ] && [ "$n" = 1 ] && lazy=""
    out+="<button type=\"button\" data-full=\"/images/projects/$1-$n.jpg\" aria-label=\"View larger image\"><img src=\"/images/projects/$1-$n-sm.jpg\" alt=\"$alt\" width=\"800\" height=\"$(( h*800/w ))\" decoding=\"async\"$lazy></button>"$'\n'
  done <<< "$2"
  printf '%s' "$out"
}

N=${#SLUGS[@]}
for i in "${!SLUGS[@]}"; do
  s=${SLUGS[$i]}; prev=${SLUGS[$(( (i-1+N)%N ))]}; next=${SLUGS[$(( (i+1)%N ))]}
  url="https://www.renotect.ca/projects/$s/"
  mkdir -p "projects/$s"
  gallery=$(items "$s" "${IMGS[$s]}" 1)
  if [ -n "${SITE[$s]}" ]; then
    gallery="<h2>Design</h2>"$'\n'"$gallery"$'\n'"<h2>On site</h2>"$'\n'"<p class=\"lead\">${SITE_INTRO[$s]}</p>"$'\n'"$(items "$s" "${SITE[$s]}" 0)"
  fi
  gallery+=$'\n'
  cat > "projects/$s/index.html" <<EOF
<!DOCTYPE html>
<html lang="en-CA">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${TITLE[$s]} | Renotect</title>
<meta name="description" content="${DESC[$s]}">
<meta name="robots" content="index, follow, max-image-preview:large">
<meta name="theme-color" content="#2d5a52">
<link rel="icon" href="/images/logo.ico">
<link rel="canonical" href="$url">
<meta property="og:type" content="article">
<meta property="og:site_name" content="Renotect">
<meta property="og:locale" content="en_CA">
<meta property="og:title" content="${NAME[$s]} | Renotect">
<meta property="og:description" content="${DESC[$s]}">
<meta property="og:url" content="$url">
<meta property="og:image" content="https://www.renotect.ca/images/projects/$s-1.jpg">
<meta name="twitter:card" content="summary_large_image">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/site.css?v=5">
<script type="application/ld+json">
{"@context":"https://schema.org","@graph":[
{"@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Home","item":"https://www.renotect.ca/"},{"@type":"ListItem","position":2,"name":"Projects","item":"https://www.renotect.ca/#works"},{"@type":"ListItem","position":3,"name":"${NAME[$s]}","item":"$url"}]},
{"@type":"CreativeWork","name":"${NAME[$s]}","description":"${DESC[$s]}","url":"$url","image":"https://www.renotect.ca/images/projects/$s-1.jpg","creator":{"@id":"https://www.renotect.ca/#business"},"locationCreated":{"@type":"Place","name":"${LOC[$s]}"}}
]}
</script>
</head>
<body>
<header><div class="wrap">
<a class="logo" href="/"><img src="/images/logo-horizontal.png" alt="Renotect" width="246" height="62"></a>
<button class="menu-toggle" type="button" aria-expanded="false" aria-controls="site-nav" aria-label="Menu"><span></span><span></span></button>
<nav id="site-nav"><a href="/#services">Services</a><a href="/#works">Projects</a><a href="/#process">Process</a><a href="/#about">About</a><a href="/#faq">FAQ</a><a class="nav-tel" href="tel:+14372549794">(437) 254-9794</a><a class="btn" href="/#contact">Book a consultation</a></nav>
</div></header>

<main>
<section class="project-hero"><div class="wrap">
<p class="crumbs"><a href="/">Home</a> / <a href="/#works">Projects</a> / ${NAME[$s]}</p>
<h1>${NAME[$s]}</h1>
<p>${INTRO[$s]}</p>
<ul class="facts"><li><b>Category</b>${CAT[$s]}</li><li><b>Project</b>${TYPE[$s]}</li><li><b>Location</b>${LOC[$s]}</li><li><b>Scope</b>${SCOPE[$s]}</li></ul>
</div></section>

<div class="wrap gallery">
${gallery}</div>

<section class="contact" style="padding:64px 0"><div class="wrap" style="display:block">
<h2>Planning something similar?</h2>
<p class="lead">Tell us about your space and we will reply within one business day. Call <a href="tel:+14372549794">(437) 254-9794</a> or send a request.</p>
<p style="margin-top:22px"><a class="btn" href="/#contact">Book a consultation</a></p>
<nav class="more" aria-label="More projects"><a href="/projects/$prev/"><small>&larr; Previous project</small>${NAME[$prev]}</a><a href="/projects/$next/"><small>Next project &rarr;</small>${NAME[$next]}</a></nav>
</div></section>
</main>

<footer><div class="wrap"><span>&copy; 2026 Renotect. Interior design and renovation, Etobicoke, Toronto, Ontario.</span><span><a href="tel:+14372549794">(437) 254-9794</a> · <a href="mailto:info@renotect.ca">info@renotect.ca</a></span></div></footer>

<dialog class="lb" aria-label="Image viewer"><figure><img alt=""><figcaption></figcaption></figure><button class="x" type="button" aria-label="Close">&times;</button><button class="prev" type="button" aria-label="Previous image">&#8249;</button><button class="next" type="button" aria-label="Next image">&#8250;</button></dialog>
<script src="/js/site.js?v=1" defer></script>
<script src="/js/gallery.js?v=2" defer></script>
</body>
</html>
EOF
  echo "built projects/$s"
done
