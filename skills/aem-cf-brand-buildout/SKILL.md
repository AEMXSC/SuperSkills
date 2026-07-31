---
name: aem-cf-brand-buildout
description: >-
  End-to-end workflow for standing up a fully branded Content Fragment demo
  environment in AEM as a Cloud Service by copying an existing brand's fragments,
  rebranding the copy, swapping imagery to the brand CDN, publishing with
  references, proving replication landed, and renaming to clean brand slugs.
  Use this whenever someone asks to build a demo for a new brand from an existing
  one, rebrand fragments, swap demo imagery, clean up a half-converted brand tree,
  or verify that fragments actually published. Trigger it for phrases like
  "build me a <brand> demo", "rebrand these fragments for <customer>", "copy the
  SecurBank articles to <brand>", "swap the hero images to their CDN", "did these
  actually publish", or "clean up the leftover fragments". Built for the AEM XSC
  Showcase using the AEM Content MCP.
---

# AEM Content Fragment Brand Buildout

One repeatable motion: **copy → rebrand → image swap → publish → verify → rename → audit.**

This is how the NYL and Citizens Bank demos were built. It generalizes to any brand layered on top of existing demo scaffolding (SecurBank, WKND, Frescopa).

The audit phase exists because it is the one that gets skipped. Both prior buildouts left dead published duplicates behind in the source brand's tree. Phase 7 is not optional.

---

## Prerequisites

Confirm these are present. Do not try to install them.

- **AEM Content MCP** (`aem-content`) — fragments, models, variations, publish
- **AEM MCP** (`aem`) — QueryBuilder reads, raw JCR, Sling POST operations
- Author base URL. XSC Showcase default: `https://author-p153659-e1614585.adobeaemcloud.com`

Fill in before running:

| Variable | Meaning | Example |
|---|---|---|
| `AUTHOR_URL` | Target author instance | `https://author-p153659-e1614585.adobeaemcloud.com` |
| `SOURCE_ROOT` | Brand tree being copied FROM | `/content/dam/securbank/en` |
| `TARGET_ROOT` | Brand tree being built | `/content/dam/citizens/en` |
| `BRAND_PREFIX` | Slug prefix for renames | `citizens-` |
| `IMAGE_CDN` | Brand image source | `https://p1.aprimocdn.net/citizensbank/` |
| `BRAND_BRIEF` | Voice, positioning, non-negotiables | see below |

---

## Phase 0 — Environment gate (do not skip)

**Environment selection is the one decision you must not infer.** See `environment-matrix.md` → *Environment selection*.

```
1. Person named an environment      → use it, even prod. Their call.
2. Did not name one                 → get-all-aem-author-environments
                                      filter environment==='dev' AND
                                      solutions[] has aemassets
                                      → one+ match: use it, NAME IT in the report
                                      → zero match: STOP AND ASK
3. Never auto-select a shared prod env for writes.
```

**The tier is not derivable from the URL.** `author-p153659-e1614585` is Showcase *prod* and nothing in the string says so. Resolve every URL through `get-all-aem-author-environments`, including one the person handed you.

---

## Phase 1 — Survey the source

Never copy blind. Know what exists before you write anything.

```
search-aem-fragments  path=SOURCE_ROOT  responseFormat=summary  limit=50
  → the inventory: id + path + eTag for every candidate

search-aem-fragment-models  enabledForFolder=TARGET_ROOT  detail=SUMMARY
  → which models are available in the target tree
```

**Reuse the source model where possible.** Creating a parallel model per brand multiplies maintenance and pollutes shared config folders. The NYL and Citizens offers both run on the shared SecurBank Offer model — that is correct, not a shortcut.

Read one fragment in full to learn the field layout:

```
get-aem-fragment  fragmentId=<one of them>
```

**Locate fields by NAME, never by hardcoded index.** Index order differs per model and per fragment. On the shared Offer model `heroImage` currently sits at index 5 — confirm it every run. Patch paths are zero-indexed array notation (`/fields/5/values`), so a wrong index silently writes into the wrong field.

Report the inventory as a table before proceeding. This is checkpoint one.

---

## Phase 2 — Copy into the target tree

```
manage-aem-fragments-batch  target=fragments  operation=copy
  copies: [{ fragmentId, parentPath: TARGET_ROOT/<subfolder>, name }]
  → max 50 per call
```

**The destination folder must already exist.** Copy and asset import cannot create one, and the Content MCP has no folder tool:

```js
aem.form('<dam-path>', { 'jcr:primaryType': 'sling:OrderedFolder', 'jcr:title': '<Title>' })
```

Do **not** use the `POST /folders` MCP operation — it lands a stray node at the repo root.

---

## Phase 3 — Rebrand the copy

```
manage-aem-fragments-batch  target=fragments  operation=patch
  edits: [{ fragmentId, eTag, operations: [JSON Patch] }]
  → max 50 per call
```

Rules that save a rerun:

- **Values are always an ARRAY.** Single-value field → one-element array.
- **`headline` takes a plain string. Long-text / `main` requires HTML-wrapped values** (`<p>…</p>`), or `detail.plaintext` will not resolve cleanly in GraphQL. Set `mimeType: "text/html"` on create.
- **ETag comes from `search-aem-fragments` `responseFormat=summary`** (id + eTag together) or a list with `projection=FULL`. Fetch it immediately before the patch — **publishing changes the ETag**, so an ETag from before a publish fails the next patch with 412. Re-read and retry on conflict.
- `/title` updates the console title. The rendered heading is the `headline` field — they are different, and patching one does not change the other. This is why prior buildouts shipped with stale console titles: cosmetic, but it shows on screen if anyone opens the console during a demo.

**Brand voice is a constraint, not a suggestion.** Apply `BRAND_BRIEF` literally. For NYL: mutual company since 1845, policyholder-owned, warm and protection-first, "Be Good At Life" — **no em dashes, no invented statistics, no AI-tell phrasing.**

**Flag every substitution explicitly.** If you invented, approximated, or adapted content because the source had no equivalent, say so in the report. Never let fabricated copy pass as sourced.

---

## Phase 4 — Swap imagery

Point `content-reference` fields at the brand CDN. The value is the **path or URL string**, not a UUID.

**Verify the CDN pattern before bulk-applying it.** For Citizens, `www.citizensbank.com/dam/{uuid}/{file}` returns **403**; the working form is `https://p1.aprimocdn.net/citizensbank/{uuid}/{file}`. Fetch one image and confirm a 200 before patching fifty fragments to a dead host.

To roll a **new version** of an existing asset rather than add a second file, re-import over the **same folder + filename** with `import-aem-asset`, then poll `get-aem-asset-import-status` until `COMPLETED`. Same path = new version = existing references stay valid.

---

## Phase 5 — Publish with references

```
manage-aem-fragments-batch  target=fragments  operation=publish
  ids: [...]                                        ← up to 500
  filterReferencesByStatus: ['DRAFT','UNPUBLISHED','MODIFIED']
```

`filterReferencesByStatus` is what pulls unpublished assets along with the fragment. Omit it and the fragment goes live pointing at an unpublished image — a broken render in front of the customer.

---

## Phase 6 — Prove it published

**`publish` returns `SUCCESS_TRIGGERED`. That is a trigger, not a result.** Never report "published" off that response.

```js
const r = await aem.get('<fragment-path>/jcr:content.json');
return r.body['cq:lastReplicationAction'];   // === 'Activate' when live
```

**The response is enveloped** — `aem.get()` returns `{status, body, etag, location}`. Reading `r['cq:lastReplicationAction']` returns `undefined` and looks exactly like "not published."

Verified property set: `cq:lastReplicationAction`, `cq:lastReplicated`, `cq:lastReplicatedBy`, plus per-agent variants like `cq:lastReplicatedBy_publish`.

**Delivery-tier GraphQL is not reachable from Claude's network** (scoped to `adobe.io`). Verify author-side with `cq:lastReplicationAction`, then confirm delivery in-app or in a browser. Do not claim end-to-end delivery you could not observe.

> **Batch writes report failure on success.** `manage-aem-fragments-batch` and `manage-aem-fragment-variations` queue async jobs and routinely return `404 Job not found` on writes that **landed**. **Never retry on error — verify first** with `search-aem-fragments` / `search-aem-fragment-models` / variations `action=list`. Retrying creates duplicates. Model delete mirrors this: returns `deletedCount: 0` + `QUEUED`, then completes.

---

## Phase 7 — Rename to brand slugs

Clean, product/topic-based slugs with `BRAND_PREFIX`. Do this **after** publish so you rename a known-good state.

```js
aem.form('<srcPath>', { ':operation': 'move', ':dest': '<destPath>', ':replace': 'false' })  // → 201
```

This **preserves the UUID**, so existing references keep resolving. Do **not** use `/api/assets/*.move` — returns 409 and is unreliable.

---

## Phase 8 — Audit for leakage (the step that gets skipped)

Both prior buildouts left dead published duplicates in the source tree. Run this every time.

```
1. Source-tree residue
   search-aem-fragments  path=SOURCE_ROOT  status=['PUBLISHED','MODIFIED']
   → any half-converted fragments still published? They are live dead weight.
   → before deleting, check nothing points at them:
     bulk-get-aem-fragments-referenced-by  paths=[...]
     zero references = safe to unpublish + delete

2. Cross-brand references
   get-aem-fragment-references-tree on the new fragments
   → does anything still reach into SOURCE_ROOT (a shared banner, a model
     under another config folder)? FLAG it — do not silently rewrite it.
     A shared model is usually correct. A shared image usually is not.

3. Source-brand text
   search-aem-fragments  path=TARGET_ROOT  fullText: "<source brand name>"
   → catches copy that survived the rebrand pass

4. Semantic sweep for missed concepts
   search-aem-fragments  fullText: { text: "?{}?<source brand positioning>" }
   → vector search catches rebrand misses that keyword search does not
```

Canonical-path discipline: decide which tree is canonical and say so. For NYL, `/content/dam/nyl/en/articles` is canonical; the `/content/dam/securbank/en/articles` copies are dead duplicates.

---

## Operational notes learned the hard way

- **Prefer `manage-aem-fragments-batch` for all writes.** Single-fragment create/patch tools and model-schema reads are intermittently gated with *"No approval received."* The batch tool is not. Retry a gated read; it usually clears.
- **`get-aem-fragment-model` does not return an ETag** despite its description. Model patch/delete need one — get it from `search-aem-fragment-models` with `ids=[...]` `detail=FULL`.
- **`FT_AEMAGT-1271=false` does not block CF writes.** Verified: model create, fragment create, batch variation create, and both deletes all succeed with the flag off. It gates the `aem` server's skill library only.
- **The CF editor JSON preview always renders Main.** Variations do not appear there. They resolve only via `;variation=<name>` on a GraphQL persisted query. Do not debug a "missing" variation in the preview tab.
- **Never assume a folder exists** before a copy or asset import. Confirm or create it first.
- **Name throwaway artefacts with a `ZZ ` prefix** so they sort last and are obviously disposable. Delete them in the same session. If you cannot delete something, say so.

---

## Definition of done

- Every target fragment exists under `TARGET_ROOT` with brand-correct copy and clean `BRAND_PREFIX` slugs
- Imagery resolves from `IMAGE_CDN` — confirmed 200, not assumed
- Every fragment reports `cq:lastReplicationAction === 'Activate'` on the author instance
- Referenced assets published in the same pass — no broken renders
- Zero source-brand text in the target tree, verified by keyword **and** semantic sweep
- Source-tree residue either cleaned up or explicitly listed as known-open with a reason
- Cross-brand references flagged, not silently rewritten
- Every substitution or invented value called out in the report

Report as a table. Flag anything you could not verify rather than asserting it.
