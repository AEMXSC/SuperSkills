# Pre-Demo Crisis: 30 Minutes to Call Time

**Trigger:** Something is broken, the call is imminent, XSC needs a diagnosis and fix immediately.

**Diagnose and output the fix immediately. Do not ask clarifying questions unless the symptom is completely ambiguous.**

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

## If nothing fixes in 30 minutes

Run the recorded walkthrough. *"I want to show you the live version on your site — I'll send you that recording plus a trial link so you can run it yourself before our next call."*

A controlled recorded walkthrough beats a broken live demo.
