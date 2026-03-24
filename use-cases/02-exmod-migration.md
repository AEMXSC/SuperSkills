# ExMod Migration — Sitecore Customer, 4,000 Pages

**Trigger:** XSC needs a live migration proof point from an existing CMS to EDS.

**Execute immediately. Do not explain what you are about to do.**

---

## Step 1 — Run site scope analysis

Open `main--site-scope--aemsites.aem.live`, paste the customer URL. This produces the migration report artifact — page template inventory, block pattern frequency, complexity scoring. This is what you show first in the demo.

## Step 2 — Run the full import pipeline on the 5 representative pages

Execute `/page-import` which chains automatically:
```
/scrape-webpage → /identify-page-structure → /page-decomposition
→ /authoring-analysis → /generate-import-html
```

For React/SPA sites: run Playwright Bash script first to render the DOM before scraping:
```
node scrape-rendered.js <url> → full-dom.html + screenshots
```
Feed `full-dom.html` into `/identify-page-structure`, not the raw HTTP response.

Scroll-simulate before capturing: lazy-loaded sections won't appear otherwise.

## Step 3 — Check block inventory before building anything

Run in parallel:
- `/block-inventory` — does this project already have matching blocks?
- `/block-collection-and-party` — does the Block Collection have implementations for identified patterns (hero-banner, specialty-cards, stats-grid, tabs)?

Build only blocks with no existing match.

## Step 4 — Build gap blocks with GSD parallel waves

```
Wave 1 (parallel): /analyze-and-plan for each gap block
Wave 2 (parallel): /building-blocks → JS + CSS + UE model JSON per block
```

## Step 5 — Validate before the demo

- `/preview-import` — first page live before the call
- `/code-review` — all generated blocks reviewed
- Playwright Bash: screenshots of all 5 imported pages at 1280px + 375px
- `/pagespeed-audit` — 100 on all imported pages

**The demo line that always lands:**
*"Your developers review AI-generated code — they do not write it. That is the difference between 18 months and 6 weeks."*

**Time target:** Site analyzed in 30 min. 5 pages imported, converted, previewing in 2–3 hours.
