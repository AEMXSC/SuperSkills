# Omni-Channel Content Activation — Content Fragments + GraphQL

**Trigger:** XSC needs a live headless demo showing one CF delivered to multiple channels via GraphQL.

**Execute immediately. Do not explain what you are about to do.**

> **This use case is MCP-native.** Content Fragment models, fragments, variations, templates and publishing are all live API calls via the `aem-content` MCP server — no config commits, no deploy, no browser. See `tech-depth.md` → *AEM Cloud Service MCP*.

---

## Environment check — do this before anything else

**These must be true before a single call is made. Check them now — all four are MCP calls, not UI clicks.**

```
1. Which author environments can I reach?
   → get-all-aem-author-environments
   → Returns every author URL + solution flags. Pick one with
     "aemassets" or "aemassetsultimate". Note the authorUrl —
     every call below needs it.

2. Content Fragments enabled on that environment?
   → search-aem-fragment-models (detail=SUMMARY, limit=5)
   → Returns models → CF is enabled. Errors or empty on a
     supposedly-configured env → stop, raise with your SE.
   → This replaces the old "click Tools → Assets → CF Models" check.

3. Write path actually works?
   → feature-flag-listing FT_AEMAGT-1271
   → If effective=false, part of the `aem` server's model/template
     skills are gated. The aem-content write path may still work —
     PROVE IT with one throwaway fragment in a dev tier before you
     promise anything. Do not assume either way.

4. GraphQL Explorer accessible (only if demoing GraphQL live)
   → https://author-<env>.adobeaemcloud.com/content/graphiql.html
   → 404 or access denied → endpoint not provisioned. You can still
     run Steps 1–2 and 4–7; drop the GraphQL beat from the narrative.

5. DMwOA enabled (for Step 6 asset delivery)
   → AEM Author → Assets → select any asset → "Copy URL"
   → Single URL (not format options) = DMwOA NOT active.
     Skip Step 6. Do not promise live DMwOA asset delivery.
```

**Never build on a shared environment without checking what is already there.** `search-aem-fragment-models` first — XSC Showcase already carries Frescopa (Article, Beverage, Brew Method, Coffee Type, Offer, Quiz), Air Canada (Flight Offer) and FormsDemo models. Reusing an existing model is faster than creating one and avoids polluting a shared env.

---

## How do you want to build this?

```
How much time do you have before the call?
├── Tonight / overnight → YOLO Mode
│   AI creates the CF model, fragments, 3 channel variations,
│   3 render templates, GraphQL queries, publishes, validates.
│   Wake up to: live fragments, rendered channel previews,
│   working GraphQL endpoints.
│   Trade-off: AI picks field names and tone variants.
│   You review in the morning — not before.
│   → Skip to YOLO Mode section at the bottom.
│
└── Now / I want to review decisions → Full Build (Steps 1–8)
    You stay present at: CF model schema, tone variant copy,
    GraphQL query structure, governance rule configuration.
    Trade-off: 20–30 minutes with you watching.
    Best for: technical architect audience, compliance-sensitive
    verticals (pharma, healthcare), or first CF demo.
    → Continue with Step 1 below.
```

---

## Step 1 — Create the Content Fragment model

**Tool:** `manage-aem-fragments-batch` target=`models` operation=`create`

Fields:

| Field | Type | Purpose |
|---|---|---|
| `headline` | text | Channel-varied |
| `body` | long-text | Channel-varied |
| `cta` | text | Channel-varied |
| `complianceApproved` | boolean | Blocks publish if false — the governance close |
| `channelNotes` | text | Optional author guidance |

This is a live call. The model exists in AEM the moment it returns — **no config commit, no deploy, no CI wait.**

That is itself a demo beat for the architect audience: *"I just created a content model in production authoring in about a second, from a prompt."*

## Step 2 — Create the fragment, then add channel variations

**This is the step most people get wrong.** Do not create three fragments. Create **one fragment with three variations** — that is what proves "one source of truth."

```
1. get-aem-fragment-model        → read the schema + ETag (required first)
2. manage-aem-fragments-batch    → target=fragments, op=create
                                   (up to 50 per call if you want a
                                    full content set, not just one)
3. manage-aem-fragment-variations → action=create, up to 50 in one call
                                    - patient-facing  (plain language, empathy-first)
                                    - clinical-staff  (precise, abbreviated, protocol-aligned)
                                    - marketing       (benefit-led, conversion-oriented)
4. manage-aem-fragment-variations → action=patch, edits[] with JSON Patch
                                    per variation to set the tone copy
                                    (ETag is fetched internally — do not pre-fetch)
```

Three separate fragments would be three sources. Three variations of one fragment is **one source, three renditions** — which is the entire argument of the demo.

## Step 3 — Write GraphQL persisted queries (one per channel)

Generate the queries **from the schema**, not from memory — `get-aem-fragment-model` returns exact field names and types, so the queries are correct on the first try.

```graphql
# patient-portal  → headline + body + complianceApproved
# mobile-app      → headline + cta only (card format)
# clinical-staff  → headline + body (dense, no CTA)
```

Each query returns only what that channel needs. Never return all fields to all channels — that is the point being demonstrated.

Test all three in AEM GraphQL Explorer before the demo.

## Step 4 — Render the channel previews

**Two paths. Pick based on audience.**

**Fast path (recommended — minutes, no repo):**

```
create-aem-cf-template      → one Handlebars HTML template per channel
                              {{ fields.headline }} for text
                              {{{ fields.body }}} for HTML (unescaped)
                              Use dryRun=true to validate first
render-aem-fragment-preview → render the fragment through each template,
                              passing the variation name
```

Three renders of one fragment. No repo, no blocks, no build. This is enough for the "one edit → three refreshes" moment and it is dramatically faster to stand up.

**Rich path (when the customer needs to see real EDS pages):**

Scaffold from `aemdemos/ise-boilerplate`. Read `AGENTS.md` before building any blocks. Each channel block produces 4 files: `{block}.js` + `{block}.css` + `{block}-tokens.css` + `ue/models/blocks/{block}.json`.

Use the rich path only when the deal needs the EDS delivery story too. Otherwise the fast path wins on time and has fewer failure modes.

## Step 5 — Publish

**Tool:** `manage-aem-fragments-batch` operation=`publish`

Up to 500 fragment IDs per call. Accepts `scheduledTime` (epoch ms) if the demo needs a future go-live.

## Step 6 — Configure DMwOA asset delivery

Single asset URL → web crop, mobile crop, thumbnail served automatically. No rendition management.

Skip if the Step 5 env check showed DMwOA inactive.

## Step 7 — Wire the governance close

Set `complianceApproved = false` on the fragment and show that delivery is blocked across every channel simultaneously.

**Then go one better — prove the blast radius:**

```
get-aem-fragment-references-tree  → what this fragment depends on
get-aem-fragment-referenced-by    → everything that would break if it changed
```

Both return author names, modification dates and publish status per node. Run it live.

The close: *"One approval controls what goes live everywhere — patient-safe content cannot ship without compliance sign-off regardless of channel. And before anyone changes it, we can show exactly what it touches."*

## Step 8 — Build campaign pages (EPA demo setup)

Create `/campaign/` subfolder with 5 pages on the channel preview site:
- `/campaign/index` — campaign hub
- `/campaign/patient-portal` — patient-facing content
- `/campaign/mobile-app` — mobile-optimized content
- `/campaign/clinical-staff` — clinical staff content
- `/campaign/contact` — CTA/conversion

Content tone: **formal US English** — EPA "before" state.

`da_write` all 5 pages. This extends the demo: CF → 3 channels → EPA regional variants, all on the same call.

**EPA prompt for the call (save this now):**
```
Update hero headlines and product descriptions across all pages
under /campaign/ to reflect [EMEA / APAC / LatAm] regional tone.
Show me a preview before applying.
```

**Time target:** Fast path — live fragments, variations and rendered channel previews in **under 30 minutes**. Add 30–60 min for the rich EDS path.

---

## YOLO Mode — Wake Up With a Live CF Demo

**When to use:** Environment checks passed. You have AEM CS access. Call is tomorrow.

**Give the AI this before you close your laptop:**

```
AEM Author URL: https://author-<env>.adobeaemcloud.com
Vertical / industry: [healthcare / pharma / financial / etc.]
Key governance story: [e.g. "compliance blocks patient content"]
Rich EDS pages needed? [yes / no — no = fast path, templates only]
Go. Wake me up when the fragments are live.
```

**YOLO rules — AI executes all of these without stopping:**

```
Decision point                      → Rule
Author URL blank in the handoff     → get-all-aem-author-environments,
                                      filter environment==='dev' AND
                                      solutions[] has aemassets.
                                      One+ match → use it, NAME IT in the report.
                                      Zero match → STOP. Do not fall back to
                                      stage or prod. This is the ONE thing you
                                      escalate instead of deciding.
                                      → environment-matrix.md → Environment selection
Tempted to write to Showcase prod   → Don't. Reads yes, writes no.
                                      It carries other people's demo content.
Existing model already fits         → REUSE IT. search-aem-fragment-models first.
                                      Never create a duplicate model on a shared env.
CF model field names unclear        → Use standard set: headline, body, cta,
                                      complianceApproved, channelNotes. Always.
Tone variants unclear               → Default 3 VARIATIONS (not 3 fragments):
                                      patient-facing / clinical / marketing.
                                      Adapt labels to vertical.
Tempted to create 3 fragments       → Don't. One fragment, three variations.
                                      Three fragments breaks the demo argument.
Need >1 fragment of content         → Batch it. manage-aem-fragments-batch takes
                                      50 per call. Never loop single creates.
ETag needed for patch/delete        → Fragments/models: fetch it first.
                                      Variations: do NOT pre-fetch — handled internally.
GraphQL query structure unclear     → Generate from get-aem-fragment-model schema.
                                      Minimum fields per channel. Never all-to-all.
GraphQL Explorer 404                → Drop the GraphQL beat. Build everything else.
                                      Flag it. Do not block the whole build on it.
FT_AEMAGT-1271 effective=false      → Test one throwaway write in a dev tier.
                                      Works  → proceed, note it in the report.
                                      Fails  → STOP. Flag as blocked. Do not fake it.
DMwOA not enabled                   → Skip Step 6. Flag in report.
"One edit → three renders" broken   → Debug before declaring done. This is the
                                      demo moment — do not skip it.
Publishing many fragments           → One publish call, up to 500 ids.
                                      Not one call per fragment.
5+ EDS pages to publish             → Use helix-mcp bulk preview API —
                                      not individual da_write calls.
                                      POST /preview/{org}/{site}/main/*
                                      with all paths in one payload.
                                      Poll job status before declaring done.
                                      Fall back to individual da_write if
                                      HELIX_ADMIN_API_TOKEN not configured.

Campaign pages (EPA demo setup)    → Build 5 EDS pages in /campaign/ on the
                                      channel preview site from Step 4:
                                        /campaign/index
                                        /campaign/[channel-1]   ← patient portal
                                        /campaign/[channel-2]   ← mobile app
                                        /campaign/[channel-3]   ← clinical staff
                                        /campaign/contact
                                      Formal US English (EPA "before" state).
                                      Publish all 5. EPA prompt for the call:
                                      "Update all pages under /campaign/ to reflect
                                      [EMEA / APAC] regional tone. Preview first."
Any ambiguity                       → Make a decision. Log it. Keep going.
                                      EXCEPT environment selection — see the
                                      first rule. That one you escalate.
```

**Wake-up report — output this when done:**

```
✓ Environment: [authorUrl]
✓ CF Model: [name] — [created / REUSED existing at <path>]
   fields: [list]
✓ Fragment: [title] — [path] — id [uuid]
✓ Variations (3): patient-facing ✓  clinical-staff ✓  marketing ✓
✓ Render templates (3): [template ids]
✓ Channel renders validated — one edit → three renders ✓
✓ GraphQL endpoints live:
   patient-portal: [query URL] ✓
   mobile-app:     [query URL] ✓
   clinical-staff: [query URL] ✓
✓ Published: [n] fragments
✓ Governance: complianceApproved=false blocks all delivery ✓
✓ Blast radius: references-tree + referenced-by captured ✓
⚠ DMwOA: [enabled / not enabled — skipped]
⚠ FT_AEMAGT-1271: [effective=true / false — write path VERIFIED by test write]

✓ EPA demo ready:
  Campaign pages (5): [preview URLs for /campaign/ pages]
  Author URL: https://author-<env>.adobeaemcloud.com
  EPA prompt (copy-paste on the call):
  "Update hero headlines and product descriptions across all pages
  under /campaign/ to reflect [EMEA / APAC / LatAm] regional tone.
  Show me a preview before applying."

Ready for your call.
Demo sequence: model → fragment → 3 variations → 3 renders →
GraphQL per channel → governance block → blast radius → EPA regional variants.
```

**The XSC's line on the call:**
*"Watch this — I change one field in the content fragment and all three channels update. Patient portal, mobile app, clinical staff alert. One source. One approval. Everywhere."*

**And for the architect in the room:**
*"Everything you just watched was an API call. No console clicking, no deploy. Which means your content operations can be automated, governed and audited the same way your code already is."*
