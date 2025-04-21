#!/bin/bash
SASS_INPUT="WaniKani-ElementaryDark.scss"
TMP_STEP="tmp.css"
OUTPUT="WaniKani-ElementaryDark.css"

trap 'rm -f "$TMP_STEP"*' EXIT

sass "$SASS_INPUT" "$TMP_STEP"

echo "/* ==UserStyle==
@name         WaniKani Elementary Dark
@namespace    github.com/openstyles/stylus
@version      3.0.0
@license      MIT
@description  Dark theme for the WaniKani domain
@author       Everesh
@homepageURL  https://github.com/Everesh/WaniKani-ElementaryDark
@supportURL   https://github.com/Everesh/WaniKani-ElementaryDark/issues
==/UserStyle== */

@-moz-document domain("www.wanikani.com") {" > "$OUTPUT"

sed 's/^/  /' "$TMP_STEP" | head -n -1 >> "$OUTPUT"

echo "}" >> "$OUTPUT"

rm "$TMP_STEP"

cat WaniKani-ElementaryDark.css | xclip -sel clip
