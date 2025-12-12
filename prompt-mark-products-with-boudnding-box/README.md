# Product Card Copier — Spec

## What is this?

A browser userscript that lets you quickly grab product data from grocery and retail websites. Hold down a key, click a product card, and its HTML + URL gets copied to your clipboard as JSON.

## Why?

When building shopping lists, doing price comparisons, or scraping product info, you often need to capture product cards from various sites. This tool makes that fast and consistent across a bunch of different retailers.

## How it works

1. **Detection**: On page load, figures out which site you're on by hostname
2. **Discovery**: Finds all product cards on the page using site-specific CSS selectors
3. **Trigger**: Hold `x` + click a product card
4. **Capture**: Copies a JSON payload to clipboard containing:
   - `html` — the card's full outerHTML
   - `url` — direct product link (extracted per-site logic)
   - `site` — label like "TARGET" or "SAFEWAY"
   - `index` — position in the list
5. **Feedback**: Card flashes green, message logs to console

## Architecture

Three decoupled pieces:

- **Site configs** — hostname matching + CSS selectors (pure data)
- **URL extractors** — functions that pull product URLs from card HTML (pure functions)
- **Actions** — what to do when triggered (clipboard, console, extensible)

The core engine composes these via dependency injection, making it easy to add new sites or swap behaviors.

## Extending

**Add a new site:**

1. Add entry to `siteConfigs` with hostnames, selector, label
2. Add matching extractor function to `urlExtractors`

**Add new actions:**
Pass custom `actions` array to `createProductCardCopier()` options. Each action has `name` and `onTrigger(card, payload)`.
