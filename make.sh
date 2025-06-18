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
	$(sass "$INPUT" | sed 's/^/  /' | head -n -1)
}" > "$OUTPUT"

xclip -sel clip < "$OUTPUT"
