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

COMPILED_CSS=$(sass "$INPUT")

MAIN_CSS=$(echo "$COMPILED_CSS" | awk '/WKOF_START/{f=1} !f; /WKOF_END/{f=0}' | sed 's/^/  /')

WKOF_CSS=$(echo "$COMPILED_CSS" | awk '/WKOF_START/{f=1; next} /WKOF_END/{f=0} f')

WKOF_ADAPTIVE=$(echo "$WKOF_CSS" | sed 's/^/  /')

WKOF_ENFORCE=$(echo "$WKOF_CSS" | sed 's/\([^!]\);$/\1 !important;/' | sed 's/^/  /')

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

@advanced     dropdown wkof_mode "Open Framework integration" {
    wkof_adaptive "Adaptive" <<<EOT
${WKOF_ADAPTIVE}
    EOT;
    wkof_strict "Strict" <<<EOT
${WKOF_ENFORCE}
    EOT;
    wkof_none "None" <<<EOT
    EOT;
}
==/UserStyle== */

@-moz-document domain("www.wanikani.com") {
${MAIN_CSS}
  /*[[wkof_mode]]*/
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
