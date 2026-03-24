# ExMod Migration — Sitecore Customer, 4,000 Pages

**This is a BUILD scenario — produces real migration artifacts, not slides.**

```
The customer is on Sitecore 9, roughly 4,000 pages, healthcare vertical.
I have a 2-hour technical demo in 3 days. I need:
1. Site scope analysis of their public site showing AI-analyzed complexity
2. Migration report — page templates identified, block patterns, effort estimate
3. First 5 pages imported and running as EDS as proof they can see live
Script the demo AND execute phases 1 and 2.
```

**What the skill actually builds:**

Runs **Playbook B** (full migration skill chain) — not a walkthrough, actual execution:

1. **Site Scope Analyzer** (`main--site-scope--aemsites.aem.live`) — paste the customer URL, AI maps every page template, identifies repeating block patterns, scores migration complexity. Output is a real artifact you show in the demo
2. **`/page-import` orchestrator** — scrapes the 5 representative pages the customer chose (runs `/scrape-webpage` → `/identify-page-structure` → `/page-decomposition` → `/authoring-analysis` → `/generate-import-html` automatically)
3. **`/block-inventory` + `/block-collection-and-party`** — cross-reference identified block patterns (hero-banner, specialty-cards, stats-grid, tabs) against existing implementations. Reuse what exists — only build the gaps.
4. **`/building-blocks`** — generates working JS + CSS + UE model JSON for any block with no existing match. Same output as aemcoder.adobe.io but via API, no browser required.
5. **`/docs-search`** — look up EDS patterns inline if any block implementation needs clarification
6. **`/preview-import`** — validates first preview is live before the demo call
7. **`/code-review`** — review all generated blocks before showing a customer
8. **Visual validation** — Playwright script (Bash, not MCP) screenshots each of the 5 imported pages at 1280px and 375px. Confirms imported layout matches source fidelity and no blocks are broken.
9. **`/pagespeed-audit`** — score 100 on all imported pages before the demo.

The customer watches their own pages appear as a live EDS site during the demo. That is not a slide.

The line that always lands: *“Your developers review AI-generated code — they do not write it. That is the difference between 18 months and 6 weeks.”*

**Time comparison:**
- Last year without AI: Migration scoping alone = 2–4 weeks. A page-by-page import proof point required a full developer sprint. Most XSCs showed PowerPoint
- With SuperSkills: Site analyzed in 30 minutes. 5 pages imported, converted, and previewing in 2–3 hours. Show it live in the demo