#!/bin/bash
INPUT="main.scss"
OUTPUT="WaniKani-ElementaryDark.css"
VERSION="version"

echo "/* ==UserStyle==
@name         WaniKani Elementary Dark
@namespace    github.com/openstyles/stylus
@version      $(cat "$VERSION")
@license      MIT
@description  Dark theme for the WaniKani domain
@author       Everesh
@homepageURL  https://github.com/Everesh/WaniKani-ElementaryDark
@supportURL   https://github.com/Everesh/WaniKani-ElementaryDark/issues
==/UserStyle== */

@-moz-document domain("www.wanikani.com") {
$(sass "$INPUT" | sed 's/^/  /')
}" > "$OUTPUT"

if [[ "$1" == "--clip" || "$1" == "-c" ]]; then
  xclip -sel clip < "$OUTPUT"
  echo "(ᵕ • ᴗ •) That's a lot of CSS in your clipboard, careful where you paste..."
fi
