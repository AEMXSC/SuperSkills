# Personalize the Demo Site via MCP — No Browser Required

**Trigger:** XSC needs demo site content updated before a call, without opening a browser.

**Execute the MCP calls immediately. Do not explain what you are about to do.**

---

## First — which content backend is this?

```
What am I updating?
├── EDS site (DA-authored, *.aem.page / *.aem.live)
│   → DA path. Continue to Pre-flight below.
│
└── AEM Cloud Service (Content Fragments, Sites pages)
    → Cloud Service path. Skip to that section.
    → Different MCP server, different tools, no hlx-admin-mcp needed.
```

Do not run `da_write` against a Cloud Service environment or `manage-aem-fragments-batch` against a DA site. They are separate content stores.

---

## Pre-flight — run before any writes

```
1. hlx-admin-mcp running?
   → curl http://localhost:3000 — if no response, start it:
     npx @adobe/hlx-admin-mcp
   → Without it, da_write writes content but CDN never busts.
     XSC sees no change on the live site. Do not skip this check.

2. DA auth valid?
   → da_login → da_whoami → confirm identity before touching anything
   → If token expired, re-authenticate via OAuth before proceeding.
     Do not attempt writes with an expired token.
```

## Execute this sequence

```
1. da_login        → check token, re-authenticate via OAuth if expired
2. da_whoami       → confirm identity + derive DA org (no need to ask XSC)
3. da_get_source   → read current page to preserve structure before overwriting
4. da_write        → apply each content change → CDN preview triggered → published ✓
   (repeat da_get_source + da_write per page — never write blind)
   If 5+ pages: use helix-mcp bulk preview instead — one API call, poll job status
5. /campaign/ check → does /campaign/ exist on this site?
   No  → create 5 campaign pages (vertical-appropriate, formal US English tone)
         da_write all 5 → CDN preview triggered → published ✓
   Yes → da_get_source each /campaign/ page → update content to match
         new vertical/regional tone → da_write → published ✓
6. Playwright Bash → screenshot homepage + /campaign/ pages at 1280px
                     confirm changes rendered on live CDN, not just preview
                     delete script after
```

## Run all page updates in parallel where pages are independent

Pages with no content dependency on each other can be updated simultaneously. Do not update sequentially when parallel is possible.

## Return when done

```
✓ Hero headline updated — [preview URL]
✓ Sub-headline updated — [preview URL]
✓ Product descriptions updated (3) — [preview URL]
All changes live on CDN. Visual confirmation: [screenshot summary]

✓ EPA demo ready:
  Campaign pages (5): [preview URLs for /campaign/ pages]
  EPA prompt (copy-paste on the call):
  "Update hero headlines and product descriptions across all pages
  under /campaign/ to reflect [EMEA / APAC / LatAm] regional tone.
  Show me a preview before applying."
```

**Constraint:** `hlx-admin-mcp` must be running locally (`npx @adobe/hlx-admin-mcp`) and connected before `da_write` can trigger CDN preview. If not connected, `da_update_source` writes content but does not bust the CDN cache — the live site will not reflect changes until manually previewed.

**Time target:** 5 updates live in under 5 minutes.

---

## Cloud Service path — personalize CF content via `aem-content`

**Use when the demo runs on AEM CS, not EDS.** No `hlx-admin-mcp`, no DA auth — IMS handles it.

### Pre-flight

```
1. get-all-aem-author-environments  → confirm the authorUrl is reachable
2. feature-flag-listing FT_AEMAGT-1271
   → effective=false means part of the `aem` skill library is gated.
     Verify the aem-content write path with one throwaway patch
     before touching demo content.
```

### Execute this sequence

```
1. search-aem-fragments        → find the fragments to personalize.
                                 Use semantic search when you don't know
                                 the exact naming:
                                   fullText: { text: "?{}?hero headline" }
                                 responseFormat=summary → returns id + eTag
                                 for every hit, which is exactly what
                                 the patch call needs next.

2. get-aem-fragment-referenced-by → BEFORE writing, check what else uses
                                 these fragments. On a shared demo env you
                                 can break someone else's demo. Do not skip.

3. manage-aem-fragments-batch  → target=fragments, op=patch
                                 up to 50 edits in ONE call
                                 each edit: { fragmentId, eTag, operations[] }
                                 JSON Patch paths: /title, /fields/0/values/0

4. manage-aem-fragments-batch  → op=publish, up to 500 ids in one call
                                 add scheduledTime (epoch ms) for timed go-live

5. render-aem-fragment-preview → visual confirmation the content rendered,
                                 per variation if the demo uses them
```

### Bulk rebrand variant

Personalizing for a named customer across a whole content set:

```
manage-aem-fragments-batch  → op=findReplace
                              paths[] (max 200, auto-chunked)
                              dryRun=true FIRST — always
                              review the diff, then dryRun=false
```

For **pages** rather than fragments, use `bulk-find-replace-aem-pages`. Scope it with `launchPath` to stage the change in a launch instead of touching live content — see `use-cases/12`.

### Return when done

```
✓ Fragments patched: [n] — [paths]
✓ Published: [n] fragments
✓ Rendered previews confirmed: [variation names]
⚠ Referenced elsewhere: [list — or "none, safe to change"]
⚠ FT_AEMAGT-1271: [effective — write path verified by test patch]
```

**Time target:** 20 fragments patched and published in under 3 minutes — one batch call each way.

---

## YOLO Mode — Wake Up With a Personalized Demo Site

**When to use:** You have a demo site. You need content updated for a specific customer, vertical, or regional market before tomorrow's call.

**Give the AI this before you close your laptop:**

```
Demo site: [preview URL or DA org/repo]
AEM Author URL: [REQUIRED if this is Cloud Service, not EDS —
                 blank means dev-tier auto-select or a hard stop.
                 See environment-matrix.md → Environment selection]
Customer / vertical: [name + industry]
Regional market: [e.g. EMEA / APAC / LatAm — or "keep US English"]
Updates needed: [e.g. "hero headline to emphasize patient outcomes" or "all product descriptions to financial services tone"]
Go. Wake me up when it's live.
```

**YOLO rules — AI executes all of these without stopping:**

```
Decision point                      → Rule
hlx-admin-mcp not running          → Start it. If start fails, fall back to
                                      da_update_source. Flag: CDN not busted —
                                      XSC must preview in Sidekick before the call.
DA token expired                    → Re-authenticate via OAuth. Do not attempt
                                      writes with expired token.
Pages unclear                       → da_whoami → read site structure →
                                      identify home + key campaign pages.
                                      Never ask the XSC.
Page order unclear                  → Update home first, then /campaign/ pages,
                                      then supporting pages. Parallel where independent.
Content tone unclear                → Default to benefit-led, conversational,
                                      customer-outcome focused. Adapt to vertical.
Regional variant unclear            → Keep US English. Flag in report.
5+ pages to publish                → Use helix-mcp bulk preview API —
                                      not individual da_write calls.
                                      POST /preview/{org}/{site}/main/*
                                      with all paths in one payload.
                                      Poll job status before declaring done.
                                      Fall back to individual da_write if
                                      HELIX_ADMIN_API_TOKEN not configured.

Campaign pages missing              → Create /campaign/ subfolder with 5 pages.
                                      Vertical-appropriate content, formal US English.
                                      This makes EPA demo runnable on the call.
Playwright screenshot fails         → Retry once. Skip and flag if still failing.
Any ambiguity                       → Make a decision. Log it. Keep going.
```

**Wake-up report — output this when done:**

```
✓ Pages updated: [list with preview URLs]
✓ Content changes: [summary of what was updated]
✓ All changes live on CDN. Visual confirmation: [screenshot summary]

✓ EPA demo ready:
  Campaign pages (5): [preview URLs for /campaign/ pages]
  Content: [vertical]-appropriate, formal US English tone
  Author URL: https://author-<env>.adobeaemcloud.com
  EPA prompt (copy-paste on the call):
  "Update hero headlines and product descriptions across all pages
  under /campaign/ to reflect [EMEA / APAC / LatAm] regional tone.
  Show me a preview before applying."

Ready for your call. Open [preview URL].
```
