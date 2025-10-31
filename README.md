# WaniKani-ElementaryDark

Yet another dark theme for WaniKani.

Successor to [WKElementaryDark](https://github.com/Sepitus-exe/WKElementaryDark), rewritten to leverage native CSS variable hijacking for improved maintainability and resilience.

![Image](https://github.com/user-attachments/assets/4892bc85-4e6b-4d77-8d09-67b7652b7248)

## Installation

### Install directly to Stylus [here](https://userstyles.world/api/style/22026.user.css)

*Grab Stylus [here if you're on Firefox](https://addons.mozilla.org/en-US/firefox/addon/styl-us/) or [here if you're on Chrome](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne?hl=en)*

## Build from source

1. Raw CSS
```sh
sass main.scss
```

2. Postprocessed, Stylus compatible CSS
```sh
make.sh
```
> ***!*** For conviniences sake while prototyping, the make script not only exports to a file called "WaniKani-ElementaryDark.css", but also to your clipboard

## Why the Rewrite?

The original project was a single monolithic CSS file. As WaniKani evolved, large chunks became obsolete, but there was no easy way to identify them, leading to continuous bloat. This new implementation leverages Sass to compartmentalize code sections, making maintenance actually manageable.

## Custom Colors
> ___!___ *These are **complementary** to the main stylesheet, they do not work independently!*

### Make your own

Use the interactive themer at https://wked.rexs.tools/ by @Rrwrex

Or grab the bare template [here](https://github.com/Everesh/WaniKani-ElementaryDark/blob/main/themes/template.css)

### Grab a preset

#### [Gruvbox](https://github.com/Everesh/WaniKani-ElementaryDark/raw/refs/heads/main/themes/gruvbox.user.css)

#### [Catppuccin](https://github.com/Everesh/WaniKani-ElementaryDark/raw/refs/heads/main/themes/catppuccin.user.css)

## Project Structure

```plaintext
root/
 ├─ base/
 │   ├─ core.scss         <- base shared styling (headers, buttons, etc.)
 │   ├─ legacy.scss       <- exposes legacy css vars for 3rd party userscripts
 │   ├─ overrides.scss    <- hijacks native css vars
 │   ╰─ variables.scss    <- defines stylesheet vars
 ├─ img/                  <- custom images for src redirects
 ├─ pages/
 │   ├─ collections.scss  <- shared style for indexes
 │   ╰─ *.scss            <- individual page styles
 ├─ themes/
 │   ├─ template.css      <- template for custom color palettes
 │   ╰─ *.user.css        <- alternative color palettes
 ├─ main.scss             <- unifying file
 ├─ version               <- metadata about current version
 ├─ make.sh               <- bash script for sass post-processing
 ├─ .gitignore
 ├─ LICENSE               <- MIT
 ╰─ README.md             <- you are here
```

## Dev Hooks

This theme exposes a bunch of CSS variables so other scripts and addons can match the look:

```css
/* Comprehensive list with default values */
:root {
    /* Static colors */
    --ED-surface-1: var(--USER-surface-1, #151515);
    --ED-surface-2: var(--USER-surface-2, #282828);
    --ED-surface-3: var(--USER-surface-3, #303030);
    --ED-surface-4: var(--USER-surface-4, #535353);
    --ED-surface-inv: var(--USER-surface-inv, #bababa);

    --ED-text: var(--USER-text, #eeeeee);
    --ED-text-inv: var(--USER-text-inv, #151515);
    --ED-text-hl: var(--USER-text-hl, #c29354);
    --ED-text-grayed: var(--USER-text-grayed, #aaaaaa);

    --ED-radical: var(--USER-radical, #56638a);
    --ED-kanji: var(--USER-kanji, #9c4644);
    --ED-vocab: var(--USER-vocab, #58896f);

    --ED-apprentice: var(--USER-apprentice, #47454e);
    --ED-guru: var(--USER-guru, #605c74);
    --ED-master: var(--USER-master, #9A815d);
    --ED-enlightened: var(--USER-enlightened, #934c3f);
    --ED-burned: var(--USER-burned, #303030);

    --ED-lesson: var(--USER-lesson, #9c4644);
    --ED-review: var(--USER-review, #56638a);
    --ED-correct: var(--USER-correct, #58896f);
    --ED-incorrect: var(--USER-incorrect, #9c4644);

    --ED-brand: var(--USER-brand, #9c4644);
    --ED-progress: var(--USER-progress, #a97e42);
    --ED-alert: var(--USER-alert, #9c4644);

    /* CSS filters */
    --ED-logo-filter: var(--USER-logo-filter, invert(1) saturate(0) brightness(1.6));
    --ED-kotoba-odd-row-filter: var(--USER-kotoba-odd-row-filter, brightness(0.95));
    --ED-footer-filter: var(--USER-footer-filter, invert(1));
    --ED-loading-filter: var(--USER-loading-filter, grayscale(100%) invert(1) hue-rotate(180deg) contrast(0.68));
    --ED-days-studied-filter: var(--USER-days-studied-filter, invert(0.85));
}
```
