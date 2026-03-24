# ExMod Migration — Sitecore Customer, 4,000 Pages

**Trigger:** XSC needs a live migration proof point from an existing CMS to EDS.

**Execute immediately. Do not explain what you are about to do.**

---

## How do you want to build this?

```
How much time do you have before the call?
├── Tonight / overnight → YOLO Mode
│   AI runs the full import pipeline autonomously. You sleep.
│   Wake up to: 5 pages live on EDS, PageSpeed 100 on all,
│   Playwright screenshots, DA published, decisions log.
│   Trade-off: AI picks which 5 pages, handles content cleanup,
│   and chooses Block Collection matches vs custom builds.
│   You review in the morning — not before.
│   → Skip to YOLO Mode section at the bottom.
│
└── Now / I want to review decisions → Full Build (Steps 1–5)
    You stay present at key checkpoints:
    page selection, import review, block gap decisions, pre-demo gates.
    Trade-off: Takes 2–3 hours with you watching.
    Best for: complex SPA sites, politically sensitive customer content,
    or when you need to hand-pick which pages make the story.
    → Continue with Step 1 below.
```

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

---

## YOLO Mode — Wake Up With 5 Pages Live

**When to use:** You have the customer's site URL and a call tomorrow. You want the migration proof point ready before you wake up.

**Give the AI this before you close your laptop:**

```
Customer site: [URL]
CMS they're migrating from: [Sitecore / WordPress / AEM Classic / etc.]
Pages to import: [5 URLs, or "pick the 5 most representative"]
GitHub org: [your org]
DA org: [your da.live org]
Go. I want 5 pages live when I wake up.
```

**YOLO rules — AI executes all of these without stopping:**

```
Decision point                      → Rule
SPA / React / Next.js detected      → Run Playwright scrape-rendered.js first.
                                      Scroll-simulate full page to trigger lazy sections.
                                      Never feed raw HTTP into the import pipeline —
                                      you will get an empty shell.

No design spec given                → Extract from live site via Playwright render:
                                      Screenshot → derive primary/accent/background
                                      from computed styles. Log the palette used.
                                      Do not guess from raw HTML on modern stacks.

Auth wall detected (login redirect) → Skip that page. Pick next best alternative.
                                      Flag in report: "Page X requires auth — not
                                      importable without credentials."

Page selection unclear              → Pick: homepage + 1 product/service page +
                                      1 article/blog + 1 contact/form page +
                                      highest-traffic page from site-scope report.

3rd party scripts on source pages   → Strip all: analytics, tag managers, chat widgets,
                                      cookie banners, A/B testing scripts, social embeds.
                                      Import clean content only. EDS adds nothing back.
                                      Flag everything stripped in report.

Custom fonts on source site         → Self-host if Google Fonts (inline @font-face,
                                      preload woff2). Swap to system font if licensed.
                                      Never load fonts from external CDN in EDS build.

Block exists in collection          → Use it. Log the match. Do not rebuild.
Gap block needed                    → Build it. JS + CSS + UE model JSON. No waiting.

Import HTML needs cleanup           → Auto-fix: remove nav/footer/cookie banners,
                                      normalize heading hierarchy, strip inline styles,
                                      convert images to WebP, add width/height attrs.

pagespeed-audit below 100           → Fix inline in order:
                                      1. Images → WebP + explicit dimensions
                                      2. Remove any copied 3rd party scripts
                                      3. Lazy-load below-fold images
                                      4. Defer non-critical CSS
                                      Do not declare done below 100.

hlx-admin-mcp not responding        → Fall back to da_update_source. Flag in report:
                                      "CDN cache not busted — manually preview each
                                      page in Sidekick before the call."

GitHub auth expired                 → Flag immediately. Blocks deploy entirely.
                                      Do not proceed past build step without confirmed
                                      GitHub access.

aem-code-sync not installed         → Flag in report. Install: github.com/apps/aem-code-sync

Playwright screenshot fails         → Retry once, then flag and continue.
da_write fails                      → Fall back to da_update_source + manual preview.
Any ambiguity on page content       → Import what's there. Flag for XSC review in report.
```

**Wake-up report — output this when done:**

```
✓ Site scope: [X templates, Y blocks identified, complexity: low/med/high]
✓ Pages imported and live:
   1. [page name] — [preview URL] — PageSpeed [score]
   2. [page name] — [preview URL] — PageSpeed [score]
   3. [page name] — [preview URL] — PageSpeed [score]
   4. [page name] — [preview URL] — PageSpeed [score]
   5. [page name] — [preview URL] — PageSpeed [score]
✓ Blocks built: [list — built from scratch vs Block Collection match]
✓ DA pages published: all 5 ✓
✓ Playwright screenshots: all 5 pages at 1280px + 375px ✓

Decisions made overnight:
- [SPA detected — used Playwright pre-render]
- [hero-banner matched Block Collection — not rebuilt]
- [specialty-cards built from scratch — no collection match]

Flagged for your review:
- [any content that looked off or needed a human call]

Ready for your call. Open [first preview URL].
```

**The XSC's line on the call:**
*"I ran your site through our import pipeline last night. Here are 5 of your pages — live, on EDS, PageSpeed 100. Your team didn't write a line of code. That's the migration story."*
