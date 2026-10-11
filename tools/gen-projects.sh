#!/bin/bash
# Builds projects/<slug>/index.html from the data below. Run from the repo root.
set -e
SLUGS=(north-york-custom-home silverfox-custom-home maple-modern-kitchen custom-millwork)
declare -A NAME TITLE DESC INTRO TYPE LOC SCOPE IMGS
declare -A CAT=([silverfox-custom-home]="Residential" [north-york-custom-home]="Residential" [maple-modern-kitchen]="Millwork &amp; Kitchen" [custom-millwork]="Millwork &amp; Kitchen")

NAME[north-york-custom-home]="Custom home facade, North York"
TITLE[north-york-custom-home]="Custom Home Facade Design, North York"
DESC[north-york-custom-home]="Facade design for a new custom home in North York: limestone-style cladding, slate mansard roof, black-framed windows and planned exterior lighting."
INTRO[north-york-custom-home]="Exterior design for a new custom home on McGillivray Avenue in North York. The front elevation pairs smooth limestone-style cladding with a dark slate mansard roof, tall black-framed windows and a double garage. Lighting was planned as part of the design, with soffit pot lights and wall sconces that frame the windows after dark."
TYPE[north-york-custom-home]="New custom home"; LOC[north-york-custom-home]="North York, Toronto"; SCOPE[north-york-custom-home]="Facade design, exterior lighting, 3D visuals"
IMGS[north-york-custom-home]="1|1600|900|Front elevation of the custom home in daylight, with stone steps and a double garage
2|1600|900|The same facade at dusk with soffit lights and wall sconces on
3|1600|900|Close-up of the upper window, stone surround and lit soffits"

NAME[maple-modern-kitchen]="Maple Modern Kitchen"
TITLE[maple-modern-kitchen]="Maple Modern Kitchen, Vaughan: Design to Install"
DESC[maple-modern-kitchen]="Maple Modern Kitchen in Vaughan: sage green shaker cabinetry, quartz and marble, warm wood and aged brass, for a 6,000 sq ft custom home. From concept and renders to installation."
INTRO[maple-modern-kitchen]="A modern kitchen for a 6,000 sq ft custom home in Vaughan. The concept pairs muted sage green shaker cabinetry with warm wood, light quartz and marble, and aged brass, for a calm room that will still feel right in twenty years. A long island with seating faces the cooking wall, tall cabinets keep the fridge, ovens and pantry built in flush, and a long picture window opens the room to the garden. The photos follow it from the first renders to cabinets and counters going in."
TYPE[maple-modern-kitchen]="Kitchen for a new custom home"; LOC[maple-modern-kitchen]="Vaughan, Ontario"; SCOPE[maple-modern-kitchen]="Kitchen design, cabinetry and materials, site oversight"
IMGS[maple-modern-kitchen]="1|1403|1121|Sage green kitchen with a large island, bar stools and full-height cabinetry
2|1402|1122|Two views of the kitchen: the island and window wall, and the gas range with open shelves
3|1500|1060|Design concept board with the colour palette, materials and finishes, inspiration images and cabinet elevations"



NAME[custom-millwork]="Custom millwork"
TITLE[custom-millwork]="Custom Millwork and Vanity Design, Toronto"
DESC[custom-millwork]="Custom millwork designed by Renotect in Toronto and the GTA: vanities and built-in cabinetry sized to the room, with finishes, hardware and lighting planned together."
INTRO[custom-millwork]="Custom millwork designed to fit the room exactly, with cabinetry, finishes, hardware and lighting planned as one piece. Shown here are three vanity designs: a green double vanity with integrated lighting, a sage shaker double vanity with a centre linen tower, and a floating olive vanity with three arched mirrors."
TYPE[custom-millwork]="Custom millwork"; LOC[custom-millwork]="Toronto and the GTA"; SCOPE[custom-millwork]="Millwork design, finishes, mirrors and lighting"
IMGS[custom-millwork]="1|1024|1024|Green double vanity with drawers, stone top and mirrors with vertical lights
2|1024|1024|Sage shaker double vanity with a centre tower and black-framed mirrors
3|1600|1600|Floating olive vanity with three arched backlit mirrors"

# Construction photos (optional per project): "site-N|width|height|alt", files images/projects/<slug>-site-N.jpg
NAME[silverfox-custom-home]="Silverfox Place custom home, Vaughan"
TITLE[silverfox-custom-home]="Modern 6,000 sq ft Custom Home in Vaughan"
DESC[silverfox-custom-home]="A modern 6,000 sq ft custom home on Silverfox Place in Vaughan: black aluminum, floated wood panels and a white stone base. Interior and facade design and construction oversight by Renotect."
INTRO[silverfox-custom-home]="A modern home of about 6,000 sq ft on Silverfox Place in Vaughan, Ontario. The facade is built from clean geometry and a tight palette: black aluminum cladding frames the structure, floated wood panels add warmth and a vertical rhythm to the upper floor, a white stone base grounds the house, and silver aluminum trim sharpens the edges. Wall-mounted lights wash the materials and mark the entries after dark. Renotect designed the interiors and the facade, and oversaw the work on site through construction so the build followed the design."
TYPE[silverfox-custom-home]="New custom home, approx. 6,000 sq ft"; LOC[silverfox-custom-home]="Vaughan, Ontario"; SCOPE[silverfox-custom-home]="Interior design, facade design, construction oversight"
IMGS[silverfox-custom-home]="1|1800|670|Render of the front facade: black aluminum, floated wood panels, white stone base and a flat roof with deep overhangs"

declare -A SITE SITE_INTRO
SITE[north-york-custom-home]="site-3|1280|677|Front of the house during construction, with the third-floor dormers framed and the walls sheathed
site-2|1280|677|Angled view of the framed and sheathed house, showing the dormer framing and roof trusses
site-1|1280|721|Closer view of the front during construction, with window openings boarded and the front steps in place"
SITE_INTRO[north-york-custom-home]="Photos from site during construction, with the upper floors framed and sheathed."
SITE[silverfox-custom-home]="site-1|1280|721|Front of the modern home during construction, with the windows installed and the walls wrapped
site-2|1280|721|Wide view of the front elevation, showing the deep roof overhang and the walk-out lower level
site-3|1280|721|Front of the house with large upper windows and the entry framed, during construction
site-4|1280|721|Upper floor wrapped in house wrap, with black-framed windows in place
site-5|1280|721|Side elevation with large window openings on both levels
site-6|1280|721|Corner of the house with the cantilevered upper floor and balcony framing
site-7|721|1280|Tall view of the side of the house across all three levels
site-8|721|1280|Side wall in sunlight, with windows installed and the house wrap on
site-9|721|1280|Corner of the house with the roof overhang and lower-level windows
site-10|721|1280|Stone cladding starting at the base of the wall
site-11|1280|721|Side of the house with the large lower-level windows installed
site-12|721|1280|Front entry and steps, with the upper balcony framed
site-13|1280|721|Side entry steps and the wrapped walls, with the woods behind the house"
SITE_INTRO[silverfox-custom-home]="Photos from site visits during construction, after the windows went in and before the exterior finishes."
SITE[maple-modern-kitchen]="site-1|1280|721|The kitchen area during framing, with the long window already in place
site-2|1280|721|The kitchen as an empty shell, with the ceiling details built and the floor prepared
site-3|1280|721|Cabinetry and islands installed, with sage green lower cabinets and tall taupe units
site-4|1280|721|Sage green cabinets and quartz counters under the long picture window
site-5|1280|721|The cooking wall with built-in ovens and tall cabinets, seen past the island"
SITE_INTRO[maple-modern-kitchen]="From framing in 2024, to the finished shell in 2025, to cabinets and counters going in at the start of 2026."
declare -A BA=([maple-modern-kitchen]="maple-modern-kitchen-compare-before.jpg|1280|721|The empty kitchen before cabinetry, with the floor membrane down|maple-modern-kitchen-compare-design.jpg|1400|787|Design render of the finished kitchen|Before|Design")
declare -A MATS=([maple-modern-kitchen]="Cabinets|Sage green shaker
Counters|Natural white quartz
Backsplash|White marble
Accents|Warm wood wall and ceiling, aged brass hardware")
declare -A RELATED=([silverfox-custom-home]="The kitchen for this home: <a href=\"/projects/maple-modern-kitchen/\">Maple Modern Kitchen</a>" [maple-modern-kitchen]="This kitchen is part of the <a href=\"/projects/silverfox-custom-home/\">Silverfox Place custom home in Vaughan</a>")

items() { # slug, data, first-image-eager(1/0)
  local out="" n w h alt lazy
  while IFS='|' read -r n w h alt; do
    [ -z "$n" ] && continue
    lazy=' loading="lazy"'; [ "$3" = 1 ] && [ "$n" = 1 ] && lazy=""
    sm="-sm"; cls=""; [ $(( w * 10 / h )) -ge 20 ] && { cls=" class=\"wide\""; sm=""; }
    out+="<button type=\"button\"$cls data-full=\"/images/projects/$1-$n.jpg\" aria-label=\"View larger image\"><img src=\"/images/projects/$1-$n$sm.jpg\" alt=\"$alt\" width=\"$( [ -z "$sm" ] && echo $w || echo 800 )\" height=\"$( [ -z "$sm" ] && echo $h || echo $(( h*800/w )) )\" decoding=\"async\"$lazy></button>"$'\n'
  done <<< "$2"
  printf '%s' "$out"
}

N=${#SLUGS[@]}
for i in "${!SLUGS[@]}"; do
  s=${SLUGS[$i]}; prev=${SLUGS[$(( (i-1+N)%N ))]}; next=${SLUGS[$(( (i+1)%N ))]}
  url="https://www.renotect.ca/projects/$s/"
  mkdir -p "projects/$s"
  gallery=$(items "$s" "${IMGS[$s]}" 1)
  first="$s-1"; [ -z "${IMGS[$s]}" ] && first="$s-site-1"
  if [ -n "${SITE[$s]}" ] && [ -z "${IMGS[$s]}" ]; then
    gallery="<h2>On site</h2>"$'
'"<p class=\"lead\">${SITE_INTRO[$s]}</p>"$'
'"$(items "$s" "${SITE[$s]}" 1)"
  elif [ -n "${SITE[$s]}" ]; then
    gallery="<h2>Design</h2>"$'\n'"$gallery"$'\n'"<h2>On site</h2>"$'\n'"<p class=\"lead\">${SITE_INTRO[$s]}</p>"$'\n'"$(items "$s" "${SITE[$s]}" 0)"
  fi
  gallery+=$'\n'
  compare=""
  if [ -n "${BA[$s]}" ]; then
    IFS="|" read -r da dw dh dalt ba bw bh balt tl tr <<< "${BA[$s]}"
    compare="<div class=\"wrap\" style=\"padding-bottom:56px\"><h2 style=\"font-size:36px;margin:0\">Before and design</h2><p class=\"lead\">Drag the line to compare the empty room with the design.</p><div class=\"ba\"><img src=\"/images/projects/$ba\" alt=\"$balt\" width=\"$bw\" height=\"$bh\" decoding=\"async\"><div class=\"ba-before\"><img src=\"/images/projects/$da\" alt=\"$dalt\" width=\"$dw\" height=\"$dh\" decoding=\"async\"></div><input type=\"range\" min=\"0\" max=\"100\" value=\"50\" aria-label=\"Compare the room before with the design\"><span class=\"ba-knob\" aria-hidden=\"true\">‹ ›</span><span class=\"ba-tag l\">$tl</span><span class=\"ba-tag r\">$tr</span></div></div>"
  fi
  mats=""
  if [ -n "${MATS[$s]}" ]; then
    while IFS='|' read -r k v; do mats+="<li><b>$k</b>$v</li>"; done <<< "${MATS[$s]}"
    mats="<ul class=\"facts\">$mats</ul>"
  fi
  cat >"projects/$s/index.html" <<EOF
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
<meta property="og:image" content="https://www.renotect.ca/images/projects/$first.jpg">
<meta name="twitter:card" content="summary_large_image">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/site.css?v=10">
<script type="application/ld+json">
{"@context":"https://schema.org","@graph":[
{"@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Home","item":"https://www.renotect.ca/"},{"@type":"ListItem","position":2,"name":"Projects","item":"https://www.renotect.ca/#works"},{"@type":"ListItem","position":3,"name":"${NAME[$s]}","item":"$url"}]},
{"@type":"CreativeWork","name":"${NAME[$s]}","description":"${DESC[$s]}","url":"$url","image":"https://www.renotect.ca/images/projects/$first.jpg","creator":{"@id":"https://www.renotect.ca/#business"},"locationCreated":{"@type":"Place","name":"${LOC[$s]}"}}
]}
</script>
</head>
<body>
<div class="offer"><div class="wrap"><span>Free initial consultation for projects in Toronto &amp; the GTA</span><a href="tel:+14372549794">Call (437) 254-9794</a></div></div>
<header><div class="wrap">
<a class="logo" href="/"><img src="/images/logo-horizontal.png" alt="Renotect" width="246" height="62"></a>
<button class="menu-toggle" type="button" aria-expanded="false" aria-controls="site-nav" aria-label="Menu"><span></span><span></span></button>
<nav id="site-nav"><a href="/#services">Services</a><a href="/#works">Projects</a><a href="/#process">Process</a><a href="/#about">About</a><a href="/#faq">FAQ</a><a class="nav-tel" href="tel:+14372549794">(437) 254-9794</a><a class="btn" href="/#contact">Free consultation</a></nav>
</div></header>

<main>
<section class="project-hero"><div class="wrap">
<p class="crumbs"><a href="/">Home</a> / <a href="/#works">Projects</a> / ${NAME[$s]}</p>
<h1>${NAME[$s]}</h1>
<p>${INTRO[$s]}</p>${RELATED[$s]:+<p class="related">${RELATED[$s]}</p>}
<ul class="facts"><li><b>Category</b>${CAT[$s]}</li><li><b>Project</b>${TYPE[$s]}</li><li><b>Location</b>${LOC[$s]}</li>${SCOPE[$s]:+<li><b>Scope</b>${SCOPE[$s]}</li>}</ul>${mats}
</div></section>

${compare}
<div class="wrap gallery">
${gallery}</div>

<section class="contact" style="padding:64px 0"><div class="wrap" style="display:block">
<h2>Planning something similar?</h2>
<p class="lead">Tell us about your space and we will reply within one business day. The first consultation is free. Call <a href="tel:+14372549794">(437) 254-9794</a> or send a request.</p>
<p style="margin-top:22px"><a class="btn" href="/#contact">Book a free consultation</a></p>
<nav class="more" aria-label="More projects"><a href="/projects/$prev/"><small>&larr; Previous project</small>${NAME[$prev]}</a><a href="/projects/$next/"><small>Next project &rarr;</small>${NAME[$next]}</a></nav>
</div></section>
</main>

<div class="mbar"><a href="tel:+14372549794">Call</a><a href="/#contact">Free consultation</a></div>
<footer><div class="wrap"><span>&copy; 2026 Renotect. Interior design and renovation, Etobicoke, Toronto, Ontario.</span><span><a href="tel:+14372549794">(437) 254-9794</a> · <a href="mailto:info@renotect.ca">info@renotect.ca</a></span></div></footer>

<dialog class="lb" aria-label="Image viewer"><figure><img alt=""><figcaption></figcaption></figure><button class="x" type="button" aria-label="Close">&times;</button><button class="prev" type="button" aria-label="Previous image">&#8249;</button><button class="next" type="button" aria-label="Next image">&#8250;</button></dialog>
<script src="/js/site.js?v=2" defer></script>
<script src="/js/gallery.js?v=2" defer></script>
</body>
</html>
EOF
  echo "built projects/$s"
done
