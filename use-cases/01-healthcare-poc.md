# Build a Custom Healthcare POC Before Tomorrow

**Trigger:** XSC needs a branded demo site built for a healthcare customer call.

**Execute immediately. Do not explain what you are about to do.**

---

## Step 1 — Scan existing assets in parallel before writing any code

Check all three simultaneously:
- `AdobeDevXSC` org: `blue-shield-ca`, `hillrom-baxter`, `baxter`, `stryker`, `stryker-da`
- `AEMXSC` org: `poc-cr-nationwide`, `poc-cr-nationwide-mutual`
- `aemdemos`: summit series with health-adjacent blocks

If a vertical match exists — clone it, adapt branding, skip to Step 4.
If no match — scaffold from `aemdemos/ise-boilerplate` and continue.

## Step 2 — Generate the GSD wave plan for all blocks

Identify the blocks needed for the healthcare narrative. For 3+ blocks, generate a parallel wave plan internally and execute it:

```
Wave 0 (parallel): /block-inventory + /block-collection-and-party
Wave 1 (parallel): /analyze-and-plan for every block simultaneously
Wave 2 (parallel): /building-blocks for every block simultaneously
  — Each block gets: JS + CSS + ue/models/blocks/<name>.json
Wave 3 (parallel): /code-review + /testing-blocks + /pagespeed-audit
```

## Step 3 — Wire DA + Universal Editor (dual authoring, no exceptions)

- `fstab.yaml` → DA content mount at `content.da.live/<org>/<repo>/`
- `component-definition.json`, `component-filters.json`, `component-models.json`
- Per-block UE model JSON for every block built in Wave 2
- DA content pages created in block table format
- Sidekick config in `tools/sidekick/config.json`

## Step 4 — Deploy

- Create GitHub repo, install `aem-code-sync` app, push code
- `da_write` all content pages → CDN preview triggered → published

## Step 5 — Pre-demo gates (all required before declaring done)

- [ ] `/pagespeed-audit` scores 100 on mobile and desktop
- [ ] Playwright Bash script: screenshots at 375px / 768px / 1280px — brand colors, layout, no console errors. Delete script after.
- [ ] All DA pages live and accessible via preview URL
- [ ] UE edit URL opens and annotations are visible on every block

**Constraint:** COA requires DMwOA enabled — verify Showcase environment has it before promising it live.

**Time target:** 4–6 hours to first live preview with parallel wave execution.
