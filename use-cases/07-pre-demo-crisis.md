# Pre-Demo Checklist + Crisis Playbook

**Primary trigger:** Run this 30 minutes before every demo call.
If everything passes, you never need the crisis section below.

**Crisis trigger:** Something is broken, call is imminent — skip to the failure mode table.

**Diagnose and output the fix immediately. Do not ask clarifying questions unless the symptom is completely ambiguous.**

---

## 30-Minute Pre-Call Checklist — run this before every demo

**Execute all checks in parallel. Flag any failure immediately.**

```
□ Open demo URL in incognito — confirm it loads without auth
□ Run PageSpeed on demo URL — confirm 95+ (100 preferred)
□ Open play.llmo.now in incognito — confirm it loads (fallback play)
□ If ASO demo: paste customer URL, confirm issues appear (not zero)
□ If EPA demo: confirm Author URL — NOT Publish URL
□ If COA demo: open AEM Assets → select asset → "Copy URL" →
               confirm format options visible (= DMwOA active)
□ If GenStudio demo: confirm Firefly sandbox is live with SE
□ If EDS/UE demo: open UE edit URL, confirm blocks load and are editable
□ If DA demo: open da.live, confirm pages are published and accessible
□ Open Frescopa as backup: main--frescopa--hlxsites.aem.live ✓
□ Record a 2-min walkthrough NOW if you do not have one on file
  (Loom or QuickTime — you will need it if anything breaks live)

If the demo involves Content Fragments (use-cases 04/08/12/13/14):
□ Confirm the ENVIRONMENT — get-all-aem-author-environments.
  The tier is NOT in the URL. author-p153659-e1614585 is Showcase PROD.
□ Confirm every fragment is actually live — NOT that publish returned OK:
  aem.get('<path>/jcr:content.json') → r.body['cq:lastReplicationAction']
  must equal 'Activate'. Check the ASSETS too, not just the fragments.
□ Open the rendered demo and look at the images. A published fragment
  pointing at an unpublished asset renders broken and publish reported success.
□ If demoing variations: confirm via ;variation=<name> on the persisted
  query, NOT the CF editor JSON preview (which always renders Main).
□ Search for duplicates: search-aem-fragments on your title.
  Two hits = someone retried a batch write that had already succeeded.
```

**If all pass → you are ready. Close this use-case.**
**If anything fails → continue to the fix section below.**

---

## ASO showing zero issues — check in this order

**1. URL behind auth wall (most common)**
Test: open in incognito, not signed in.
Fix: use public-facing URL, not authenticated preview or staging.

**2. CDN caching a clean state**
Test: add `?nocache=1` and re-run.
Fix: wait 5 minutes or switch to a URL with known issues.

**3. Wrong URL format**
ASO requires root domain or top-traffic page — not subdirectories.
Fix: run on `https://customersite.com` not `/en/us/products/`.

**4. Site is already clean (rare)**
If PageSpeed is 95+ and meta is clean, ASO has nothing to flag.
Pivot: *"Let me show you something more interesting — how your site appears in AI search."* → switch to LLMO.

## Fallback — switch to Frescopa in under 2 minutes

URL: `https://main--frescopa--hlxsites.aem.live/`
Has known ASO opportunities pre-loaded.
Narrative: *"Let me show you what this looks like on a site we already analyzed — then we run yours live in your trial."*

This is not a retreat. It is the trial close.

## Other failures — immediate fixes

| Symptom | Cause | Fix |
|---|---|---|
| EPA returning nothing | Publish URL — not Author URL | Switch to `author-<env>.adobeaemcloud.com` |
| COA images not generating | DMwOA not enabled | Switch to XSC Showcase, verify DMwOA in manifest |
| UE not loading blocks | Missing `component-definition.json` | Copy from ise-boilerplate, redeploy |
| DA preview not triggering | `aem-code-sync` not installed | Install at `github.com/apps/aem-code-sync`, re-push a commit |
| Agents not in Playground | Wrong org | Use XSC Showcase — Playground is personal folders only |

## Content Fragment / MCP failures — the ones that look like something else

**Most of these present as "it didn't work" when it did.** Diagnose before you act — the wrong reflex makes it worse.

| Symptom | Actual cause | Fix |
|---|---|---|
| `404 Job not found` on create/patch | **The write SUCCEEDED.** Batch ops are async; the result fetch lost the race | **Do not retry.** Verify with `search-aem-fragments` / `search-aem-fragment-models` / variations `action=list` |
| Duplicate fragments or models appeared | Someone retried on that 404 | Delete the extras. Check `referenced-by` on each before deleting — pick the one things point at |
| Published, but the site shows old content | `SUCCESS_TRIGGERED` is a **trigger, not a result** | `aem.get('<path>/jcr:content.json')` → `r.body['cq:lastReplicationAction']` must be `Activate`. Re-publish if not |
| `cq:lastReplicationAction` is `undefined` | `aem.get()` **envelopes** the response | Read `r.body[...]`, not `r[...]`. It is almost certainly published |
| Image broken in the rendered demo | Fragment published, **referenced asset did not** | Re-publish with `filterReferencesByStatus: ['DRAFT','UNPUBLISHED','MODIFIED']` |
| Image 403 from the brand CDN | Wrong URL pattern for that brand | Test ONE image before bulk-patching. Citizens: `www.citizensbank.com/dam/...` 403s; `p1.aprimocdn.net/citizensbank/...` works |
| Patch returns `412` / ETag conflict | Stale ETag — **publishing changes it** | Re-fetch: `search-aem-fragments` `responseFormat=summary` returns id + eTag together. Retry |
| Variation "missing" in the editor | CF editor JSON preview **always renders Main** | Not a bug. Verify with `;variation=<name>` on the persisted query |
| `No approval received` on a read | Intermittent gating on single-fragment / model-schema tools | Just retry. Prefer `manage-aem-fragments-batch` for all writes — it is not gated |
| Model delete says `deletedCount: 0` | Async; returns `QUEUED` then completes | Verify with `search-aem-fragment-models`. It probably worked |
| Wrote to the wrong environment | **Tier is not derivable from the URL** | See below — this is the serious one |

### You wrote to the wrong environment

The worst case, because it affects other people. `author-p153659-e1614585` is Showcase **prod** and nothing in the string says so.

```
1. Establish where you actually wrote:
   get-all-aem-author-environments → match your authorUrl → read `environment`
2. Find what you created:
   search-aem-fragments / search-aem-fragment-models, filter modifiedBy=you,
   modifiedAfter=<when you started>
3. Before deleting ANYTHING:
   bulk-get-aem-fragments-referenced-by → is someone else's demo pointing at it?
   Referenced → leave it, tell the owner. Not referenced → delete.
4. Do not "clean up" content you did not create. If you cannot tell,
   say so and leave it.
```

**Then tell whoever owns that environment.** A stray model in `/conf/global` is everyone's problem, and silence costs a colleague their demo.

### If a CF demo is unrecoverable

Fall back to a **read-only** CF story on content that already works — Frescopa in XSC Showcase has real reference depth. Semantic search (`?{}?`) and `get-aem-fragment-references-tree` both demo in seconds, need no writes, and land harder than a fragment edit:

*"Let me show you something more interesting than an edit — watch me find content by meaning, and then show you everything that would break if we changed it."*

Reads are safe on any environment. That is why they are the fallback.

## If nothing fixes in 30 minutes

Run the recorded walkthrough. *"I want to show you the live version on your site — I'll send you that recording plus a trial link so you can run it yourself before our next call."*

A controlled recorded walkthrough beats a broken live demo.
