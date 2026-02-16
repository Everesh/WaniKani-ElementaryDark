# WaniKani-ElementaryDark

Yet another dark theme for WaniKani.

Successor to [WKElementaryDark](https://github.com/Sepitus-exe/WKElementaryDark), rewritten to leverage native CSS variable hijacking for improved maintainability and resilience.

![Image](https://github.com/user-attachments/assets/4892bc85-4e6b-4d77-8d09-67b7652b7248)

## Installation

You'll need a userCSS manager like Stylus, grab it [here if you're on Firefox](https://addons.mozilla.org/en-US/firefox/addon/styl-us/) or [here if you're on Chrome](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne?hl=en).

Once you have Stylus installed, click one of these links to install the theme:

| Stable (updates on release) | Nightly (updates on commit) |
|-|-|
|[GitHub Pages](https://everesh.github.io/WaniKani-ElementaryDark/WaniKani-ElementaryDark.user.css) | [GitHub Pages](https://everesh.github.io/WaniKani-ElementaryDark/WaniKani-ElementaryDark-nightly.user.css) |
| [UserStyles.world (mirror)](https://userstyles.world/api/style/22026.user.css) | 

## Custom Colors

> [!WARNING]
> These are **complementary** to the main stylesheet. They don't work independently!

### Make your own

Use the interactive themer at https://wked.rexs.tools/ by @Rrwrex, or grab the bare template [here](https://github.com/Everesh/WaniKani-ElementaryDark/blob/main/themes/template.css).

Sample presets: [Gruvbox](https://github.com/Everesh/WaniKani-ElementaryDark/raw/refs/heads/main/themes/gruvbox.user.css), [Catppuccin](https://github.com/Everesh/WaniKani-ElementaryDark/raw/refs/heads/main/themes/catppuccin.user.css)

## Build from source

### Prerequisites

- [Sass](https://sass-lang.com) preprocessor

### Automated

Run the make script:

```sh
./make.sh
```

> [!TIP]
> Adding a `-c` flag clips the processed stylesheet to your clipboard

You can customize the build with environment variables:

| Variable | Effect | Default |
|-|-|-|
| WKED_ROOT | Main source file | main.scss |
| WKED_WKOF | WKOF source file | auxiliary/wkof.scss |
| WKED_OUTPUT | Output file path | WaniKani-ElementaryDark.css |
| WKED_UPDATE_URL | Upstream URL | https://everesh.github.io/... |
| WKED_VERSION | Version string | $(cat version) |
| WKED_APP_NAME | Stylesheet name | WaniKani Elementary Dark |

### Manual assembly

1. Compile the main stylesheet:
   ```sh
   sass main.scss compiled-main.css
   ```

2. Compile the WKOF module (optional):
   ```sh
   sass auxiliary/wkof.scss compiled-wkof.css
   ```

3. Wrap the output in the UserCSS header format (see `make.sh` for the template structure), replacing:
   - `#{MAIN_CSS}` with the main compiled stylesheet
   - `/*[[wkof_mode]]*/` with the WKOF module (or recreate the `@advanced` logic)
   - Metadata inside `==UserStyle==`

## Project Structure

```plaintext
root/
 ├─ base/
 │   ├─ core.scss         <- base shared styling (headers, buttons, etc.)
 │   ├─ legacy.scss       <- exposes legacy css vars for 3rd party userscripts
 │   ├─ overrides.scss    <- hijacks native css vars
 │   ╰─ variables.scss    <- defines stylesheet vars
 ├─ auxiliary/
 │   ╰─ wkof.scss         <- styling for WaniKani Open Framework
 ├─ img/                  <- custom images for src redirects
 ├─ pages/
 │   ├─ collections.scss  <- shared style for indexes
 │   ╰─ *.scss            <- individual page styles
 ├─ themes/
 │   ├─ template.css      <- template for custom color palettes
 │   ╰─ *.user.css        <- alternative color palettes
 ├─ main.scss             <- unifying file
 ├─ version               <- metadata about current version
 ├─ make.sh               <- bash script for post-processing
 ├─ .gitignore
 ├─ LICENSE               <- MIT
 ╰─ README.md             <- you are here
```

## Dev Hooks

This theme works by redefining WaniKani's native CSS variables, so you can use those directly in your scripts. Additionally, it exposes its own `--ED-*` variables for tighter integration.

> [!TIP]
> Use `color-mix()` with these variables to generate additional colors while respecting user palettes

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
