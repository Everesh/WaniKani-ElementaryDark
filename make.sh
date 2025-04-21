#!/bin/bash
sass WaniKani-ElementaryDark-Reborn.scss test.css
cat test.css | xclip -sel clip
