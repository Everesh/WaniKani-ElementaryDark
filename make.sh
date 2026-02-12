#!/usr/bin/env bash
set -euo pipefail

# Gather main references

ROOT_FILE="${WKED_ROOT:-main.scss}"
WKOF_FILE="${WKED_WKOF:-auxiliary/wkof.scss}"
OUTPUT_FILE="${WKED_OUTPUT:-WaniKani-ElementaryDark.css}"
UPDATE_URL="${WKED_UPDATE_URL:-https://everesh.github.io/WaniKani-ElementaryDark/WaniKani-ElementaryDark.user.css}"
VERSION="${WKED_VERSION:-}" # will try to recover on "" via $(cat version)
APP_NAME="${WKED_APP_NAME:-WaniKani Elementary Dark}"

# Guard clauses

if [[ -z "$VERSION" ]]; then
    if [[ -f version ]]; then
        VERSION=$(cat version)
    else
        echo -e "\x1b[1;31mError: No version provided and 'version' file not found.\x1b[0m" >&2
        exit 1
    fi
fi

if [[ ! -f "$ROOT_FILE" ]]; then
    echo -e "\x1b[1;31mError: ${ROOT_FILE} not found.\x1b[0m" >&2
    exit 1
fi

if [[ ! -f "$WKOF_FILE" ]]; then
    echo -e "\x1b[1;31mError: ${WKOF_FILE} not found.\x1b[0m" >&2
    exit 1
fi

if ! command -v sass &> /dev/null; then
    echo -e "\x1b[1;31mError: 'sass' is not installed.\x1b[0m" >&2
    exit 1
fi

# Compile

MAIN_CSS=$(sass "$ROOT_FILE" | sed 's/^/  /')

WKOF_ADAPTIVE=$(sass "$WKOF_FILE" | tail -n +2 | sed 's/^/  /')

WKOF_FORCE=$(echo "$WKOF_ADAPTIVE" | sed 's/\([^!]\);$/\1 !important;/')

cat <<EOF >"$OUTPUT_FILE"
/* ==UserStyle==
@name         ${APP_NAME}
@namespace    github.com/openstyles/stylus
@version      ${VERSION}
@license      MIT
@description  Dark theme for the WaniKani domain
@author       Everesh
@homepageURL  https://github.com/Everesh/WaniKani-ElementaryDark
@supportURL   https://github.com/Everesh/WaniKani-ElementaryDark/issues
@updateURL    ${UPDATE_URL}

@advanced     dropdown wkof_mode "Open Framework integration" {
  wkof_adaptive "Adaptive" <<<EOT
${WKOF_ADAPTIVE}
  EOT;
  wkof_force "Force" <<<EOT
${WKOF_FORCE}
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

# Clip logic

if [[ "${1:-}" == "--clip" || "${1:-}" == "-c" ]]; then
  COPIED=false

  if command -v wl-copy &> /dev/null; then
    wl-copy <"$OUTPUT_FILE" && COPIED=true
  elif command -v xsel &> /dev/null; then
    xsel --clipboard <"$OUTPUT_FILE" && COPIED=true
  elif command -v xclip &> /dev/null; then
    xclip -selection clipboard <"$OUTPUT_FILE" && COPIED=true
  fi

  if [ "$COPIED" = true ]; then
    MESSAGE="Stylesheet copied to the clipboard"
    notify-send "WaniKani Elementary Dark" "$MESSAGE" || echo "$MESSAGE"
  else
    MESSAGE="ERROR: Clipboard utility not found"
    notify-send -u critical "WaniKani Elementary Dark" "$MESSAGE" || echo -e "\x1b[1;31m${MESSAGE}\x1b[0m"
  fi
fi
