#!/usr/bin/env bash
set -euo pipefail

INPUT="main.scss"
OUTPUT="WaniKani-ElementaryDark.css"
VERSION_FILE="version"
APP_NAME="WaniKani Elementary Dark" # used only for notify-send title

if [[ ! -f "$INPUT" ]]; then
    echo -e "\x1b[1;31mError: ${INPUT} not found.\x1b[0m" >&2
    exit 1
fi

if [[ ! -f "$VERSION_FILE" ]]; then
    echo -e "\x1b[1;31mError: Version file '${VERSION_FILE}' missing.\x1b[0m" >&2
    exit 1
fi

if ! command -v sass &> /dev/null; then
    echo -e "\x1b[1;31mError: 'sass' is not installed.\x1b[0m" >&2
    exit 1
fi

PROCESSED_CSS=$(sass "$INPUT" | sed 's/^/  /')

VERSION_VAL=$(cat "$VERSION_FILE")

cat <<EOF >"$OUTPUT"
/* ==UserStyle==
@name         WaniKani Elementary Dark
@namespace    github.com/openstyles/stylus
@version      ${VERSION_VAL}
@license      MIT
@description  Dark theme for the WaniKani domain
@author       Everesh
@homepageURL  https://github.com/Everesh/WaniKani-ElementaryDark
@supportURL   https://github.com/Everesh/WaniKani-ElementaryDark/issues
==/UserStyle== */

@-moz-document domain("www.wanikani.com") {
${PROCESSED_CSS}
}
EOF

if [[ "${1:-}" == "--clip" || "${1:-}" == "-c" ]]; then
  COPIED=false

  if command -v wl-copy &> /dev/null; then
    wl-copy <"$OUTPUT" && COPIED=true
  elif command -v xsel &> /dev/null; then
    xsel --clipboard <"$OUTPUT" && COPIED=true
  elif command -v xclip &> /dev/null; then
    xclip -selection clipboard <"$OUTPUT" && COPIED=true
  fi

  if [ "$COPIED" = true ]; then
    MESSAGE="Stylesheet copied to the clipboard"
    notify-send "$APP_NAME" "$MESSAGE" || echo "$MESSAGE"
  else
    MESSAGE="ERROR: Clipboard utility not found"
    notify-send -u critical "$APP_NAME" "$MESSAGE" || echo -e "\x1b[1;31m${MESSAGE}\x1b[0m"
  fi
fi
