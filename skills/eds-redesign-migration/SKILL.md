---
name: eds-redesign-migration
description: >-
  End-to-end runbook for migrating a site to AEM Edge Delivery Services with
  Stardust — whether keeping the current design, applying the customer's flagship
  brand, or redesigning from intent — then proving it with a before/after switch
  report. Covers routing between replica, reskin and the redesign pipeline;
  baseline audit; migration planning including the prototype set and dynamic
  capabilities; iterating the home page to lock the design; incremental deploy
  then full rollout; automated QA; and the customer-facing value report. Use
  whenever someone asks to migrate a site off WordPress, Contentful, Sitecore or
  AEM Classic — especially against a license or contract deadline — or to make a
  satellite site look like the parent brand. Trigger for "migrate this site",
  "their WordPress license expires", "move them off Contentful", "make it look
  like our main site", "rebrand this satellite", "same-design migration",
  "switch report", or "before/after migration report".
  Flow per Paolo Mozzicato; modeled on the Fiserv/Clover go-live, July 2026.
---

# EDS Migration with Stardust

**One motion: off the old CMS and onto the right design.** Most vendors scope platform migration and rebrand as two projects needing two budget approvals. That is the wedge.

Proven: `blog.clover.com` — WordPress license expiry flagged 14 July 2026, redesigned to clover.com's design and migrated to EDS inside 48 hours, DNS switched 30 July. It produced exec meetings that did not previously exist and opened a pipeline to clover.com, fiserv.com and satellites.

---

## Phase 0 — Install dependencies FIRST

**Do not start until these are present.** Prompt the XSC and wait; half this flow fails silently otherwise.

```bash
claude plugin marketplace add adobe/skills
claude plugin install stardust@adobe-skills

claude plugin marketplace add pbakaus/impeccable
claude plugin install impeccable@impeccable
```

**Both are required** — Stardust soft-depends on Impeccable and will not run properly without it.

**Already installed? Update anyway.** Stardust moves fast and older builds are missing whole commands:

```bash
claude plugin marketplace update adobe-skills
```

Verify you have the full set:

```bash
ls ~/.claude/plugins/marketplaces/adobe-skills/plugins/stardust/skills/
# expect: audit  deploy  diff  direct  extract  migrate  prepare-migration
#         prototype  qa  replica  reskin  rollout  stardust  uplift
```

If `audit`, `qa`, `rollout`, `replica` or `reskin` are missing, you are on an old build — update before continuing. Docs: **https://stardust.style/docs/**

Also required: **Playwright**, an **EDS org + repo** with `aem-code-sync` installed and `blocks/ styles/ scripts/ head.html` present (`deploy` requires them), and a **DA org** at `da.live`.

---

## Phase 1 — Route to the right flow

**This is the most important decision in the engagement.** Stardust has three distinct migration flavors and picking wrong wastes the run.

```
What does the customer want to keep?
├── KEEP THE DESIGN, change the platform
│   → /stardust:replica
│     Pixel-perfect replatform. Clean re-authored HTML/CSS — never DOM copies.
│     Gated on measured source fidelity: structural + visual + stitched pixel
│     diff per breakpoint. Only permitted design changes are entries in an
│     explicit inconsistency register.
│     Sells on: volume, cost, timeline, zero brand risk.
│
├── KEEP THE CONTENT, apply someone else's design   ← THE FISERV PLAY
│   → /stardust:reskin
│     Content stays byte-faithful (text, ordered images, SEO metadata gated at
│     byte level). Design comes from a DONOR — another live site or local static
│     prototypes. Content is re-laid-out onto donor modules.
│     Sells on: brand consolidation delivered as a migration.
│
└── NEW DESIGN from intent
    → core pipeline: extract → direct → prototype
    → or /stardust:uplift for a one-shot presales POC
      Sells on: modernization, performance, differentiation.
```

**Cardvalet-on-Fiserv is `reskin`.** Cardvalet's content, Fiserv's design system. That is the motion, and naming it correctly gets you a byte-level content-fidelity gate for free — which is exactly the guarantee a nervous customer wants when you tell them a machine rebuilt their site.

`replica` and `reskin` both state their boundaries explicitly: `replica` is *"NOT for redesigns"*, `reskin` is *"NOT for keeping the current design while migrating (that's the replica flow)"*. Respect them.

**Mixed asks are normal** — "keep most of it, make the top 20 on-brand" is `replica` for the bulk and `reskin` for the 20. Name the split out loud.

---

## Set expectations honestly — this is human-in-the-loop

The 48-hour number is real. It is also a **redesigned, migrated site** — not a finished replacement for every interactive feature. Overselling this loses architects, and it is the easiest place to lose them.

Two reasons a human stays in the loop, per the field:

1. **Taste** — iterating on the design. You *can* accept the first output; the good ones are iterated.
2. **Completing it end to end** — identifying and covering unique cases, validating, QA, fixing AI inaccuracies.

**Dynamic capabilities are their own workstream** — item lists, search, API integrations, widgets. Budget **at least a day**, separately. This is where migrations actually stall, and surfacing it early is a credibility win, not a concession.

Say which you are promising: *"48 hours to a migrated, on-brand site. Your search and product feeds are a separate conversation and I will scope them honestly."*

> This flow is **actively evolving** from real engagements. Treat it as current best practice, not a frozen spec.

---

## Phase 2 — Baseline audit

```
/stardust:audit <SOURCE_URL>
```

Three perspectives plus vitals, synthesized into a scored, evidence-bound report:

| Perspective | Covers |
|---|---|
| **Design** | Tensions + concrete improvement opportunities |
| **SEO / technical** | Standard technical audit |
| **LLM / AI-search visibility** | How the site appears to AI engines |
| **Core Web Vitals** | Performance baseline |

**Run this before you change anything** — once DNS moves you cannot recreate the "before" column.

**The LLM-visibility perspective is a free second play.** If it scores badly, you have an LLMO conversation on top of the migration — see `use-cases/06`. Do not leave it on the table.

Source URLs must return **HTTP 200 in incognito**; auth walls break extraction. Swap the page rather than fighting it.

---

## Phase 3 — Extract and plan

```
/stardust:extract <URL>
```

Crawls five pages by default (`--cap`, `--all`, `--pages` to control). For a `reskin`, extract the **donor** design site as well — design comes from the donor, content from the source.

**Then follow up with a full analysis and migration plan.** Do not go straight to prototyping; this is what makes the rest converge.

```
1. Full list of URLs               → separate file; it gets long
2. Page types + required content blocks
3. PROTOTYPE SET recommendation    → which pages to prototype in order to
                                     TRAIN Stardust on the new design
4. Dynamic capabilities inventory  → item lists, search, API integrations,
                                     widgets, forms, personalization
```

**The prototype set is the core mechanic and the step people miss.** You do not prototype every page. You pick a representative set that teaches Stardust the design, then apply it at scale. Choose for **coverage of page types**, not traffic: home, a listing/index page, a content/detail page, and anything structurally unusual.

**The dynamic capabilities inventory is the honesty artifact.** It separates a demo from a migration and it is the workstream that takes at least a day. Surface it now so nobody discovers search or a product feed the week of go-live.

---

## Phase 4 — Prep and direction

```
/stardust:prepare-migration
```

Runs the prerequisite cascade with gates between phases — chains `extract --prep`, `direct --prep`, `prototype --prep` and an assets phase. Use this rather than driving each `--prep` by hand for anything at scale.

```
/stardust:direct "<phrase>"
```

Turns a freeform phrase into a target spec, plus a **reviewable reasoning trace**. `--rebrand` for a brand change; `--re-direct` to change course.

**Walk the customer through the trace.** It is the answer to "did a machine just make this up" — a document they can read rather than a finished design with no rationale. Changing direction is cheap here and expensive later.

---

## Phase 5 — Prototype the home page and iterate

```
/stardust:prototype index
```

Renders redesign HTML plus a **before/after viewer**. Flags: `--cinematic`, `--no-iterate`, `--no-critique`, `--refresh-stale`.

**Iterate on the home page until it is right.** This is where human taste goes. The home page is the design anchor for everything downstream — do not move on while it is "close enough."

**When it is right, update the DESIGN definition.** This is the step that makes iteration stick: your refinements become the spec the rest of the site is generated against. Skip it and every other page regresses to the pre-iteration design.

```
/stardust:prototype --all        ← the full prototype set, against the updated DESIGN
```

---

## Phase 6 — Migrate

```
/stardust:migrate --all
```

Emits deployable static HTML from approved prototypes. `--require-approved` and `--strict-canon` to tighten the gate.

---

## Phase 7 — Deploy one page, verify, then roll out

```
/stardust:deploy index
```

`deploy` ships **one page** and converts it to EDS blocks — each prototype section becomes one independent EDS block. It requires an EDS project with `blocks/`, `styles/`, `scripts/`, `head.html`.

**Stop and verify before deploying anything else:**

- [ ] `.page` renders correctly
- [ ] **DA content structure is correct** — open it in DA and look
- [ ] Structure follows **David's model** (canonical EDS content-structure convention). You may have to tell it explicitly to follow David's model — *known skill gap; verify by opening DA*
- [ ] Content is actually editable — change a heading, publish, confirm live

```
/stardust:rollout
```

`rollout` is the **full-site sibling of `deploy`**. It inventories the migrated tree into a delivery ledger, dedups blocks, drives `deploy` per page, verifies, and tracks what is done versus outstanding.

**Archetypes-only mode:** when only template archetype pages are migrated, `rollout` deploys all block code immediately and registers the rest as content-pending. That is the right shape for a large site — ship the blocks, backfill the content.

Verifying one page before rolling out twenty is the difference between one fix and twenty.

---

## Phase 8 — Dynamic capabilities

**This is the day of work. Budget it; do not compress it.**

```
1. Define the migration plan from the Phase 3 analysis
2. Deploy all pages per template (rollout handles the mechanics)
3. Define an implementation plan for the DYNAMIC CAPABILITIES
4. Implement them
```

Item lists, search, API integrations, widgets — not covered by prototype-and-deploy, and where migrations actually stall. This is also where the human-in-the-loop work lands: unique cases, validation, QA, fixing AI inaccuracies.

---

## Phase 9 — Verify

```
/stardust:qa <live-url>
```

Read-only automated QA sweep of the deployed EDS site. **Finds issues; never fixes them.** Validates routing, content fidelity vs the source capture, template conformance, rendered integrity (geometry, JS errors, broken images), visual regression vs baselines, metadata/SEO/JSON-LD, link integrity, accessibility via axe, and performance budgets. Emits a findings report with an allowlist for documented non-defects.

```
/stardust:diff <prototypeURL> <buildURL>
```

Two probes — pixel/layout and structural content + typography. **Run both.** The docs warn that either alone gives a false "looks fine."

Gates before you call it done:

- [ ] `/stardust:qa` clean, or every finding triaged into the allowlist with a reason
- [ ] `/stardust:diff` clean on both probes
- [ ] PageSpeed **100** mobile and desktop
- [ ] Every in-scope page loads on the EDS preview URL
- [ ] Content editable in DA — verified by actually editing and publishing
- [ ] Dynamic capabilities working, or explicitly scoped out in writing

**Verify, never assert.** A deploy that returned success is not a page that renders. Open it.

---

## Phase 10 — Re-audit and the switch report

```
/stardust:audit <NEW_SITE_URL>     ← published pages
```

This is the "after" column, on the same three perspectives as Phase 2.

**Run both audits the same day where you can.** The Clover report states it was an *"independent site audit, run on both versions the same day"* — that sentence removes "you tested ours on a bad day," and it is doing real work.

**The switch report is what closes it.** The site convinces the practitioner; the report is what the champion forwards to the executive who was not on the call. That is how Clover's blog turned into Fiserv exec meetings.

Model: `paolomoz.github.io/stardust-site/audit/clover-blog/switch-report.html`

Confirmed shape:

- **Framed as a delivery, not a proposal** — *"Your new website is ready. It's already live."*
- **Addressed and dated to the customer** — "Prepared for Clover", 29 July 2026
- **"Independent site audit, run on both versions the same day"**, stated explicitly
- **Before/after with real screenshots**, the old one labelled "Today's site" so the contrast is unarguable
- **Phase 2 vs Phase 10 numbers side by side**

Generating the before/after comparison is currently **a further prompt on top of `/stardust:audit`**, not a single command. Budget a few minutes.

---

## Phase 11 — Go-live and expand

Hand off the DNS switch with a rollback path stated in writing. The customer flips it; you do not.

Then name the next target on the same call, while the win is fresh:

```
1. Smallest urgent property first   blog.clover.com — real deadline, low blast radius
2. Flagship next                     clover.com — off Contentful, credibility earned
3. Parent brand                      fiserv.com
4. Satellites                        cardvalet.com and others
   → reskin each onto the PARENT's design to make the brand argument concrete
```

**Discovery questions that find the next one:**

- *"Which properties are on a different CMS from your main site?"*
- *"Any licenses or contracts up for renewal next quarter?"*
- *"If I showed you a satellite site in your flagship's design, who would need to see it?"*

That last question finds the executive before you need them.

---

## Presales shortcut — POC only

```
/stardust:uplift <URL>
```

Collapses extract → direct → prototype ×3 into one opinionated command. Three variants; `--two-variants`, `--cinematic-register`, `--page` to steer. This is how `cardvalet.com` was produced.

Do not run the full flow for a POC, and do not ship a go-live from the shortcut.

---

## Where Snowflake fits

`/stardust:deploy` converts prototypes to EDS blocks natively, so **the Stardust path does not need Snowflake.**

Use `/snowflake` when the static HTML came from somewhere else — Mobirise, Relume, Lovable, v0, hand-coded Figma exports. It is the general static-to-EDS converter; Stardust has its own.

---

## Operational notes

- **Route first.** `replica` / `reskin` / redesign are different flows with different fidelity gates. Picking wrong wastes the run.
- **Audit before you touch anything.** Once DNS moves the "before" column is gone.
- **The prototype set trains the design.** Pick for page-type coverage, not traffic.
- **Update the DESIGN definition after iterating index**, or every other page regresses.
- **`deploy` is one page, `rollout` is the site.** Deploy index, verify, then roll out.
- **Tell it to follow David's model** for DA content structure — known gap; verify by opening DA.
- **Run both `/stardust:diff` probes.** Either alone gives a false "looks fine."
- **Dynamic capabilities are a separate day.** Never fold them into the redesign estimate.
- **Check the audit's LLM-visibility score.** A bad one is a second play, not a footnote.
- **Take the small urgent property first.** A blog with a two-week deadline beats the flagship as an opener.

---

## Definition of done

- Site live on EDS, PageSpeed 100 mobile and desktop
- Correct flow used for the ask — `replica`, `reskin`, or redesign — and its fidelity gate passed
- DA content structure verified, following David's model
- Content editable in DA, verified by actually editing and publishing a page
- `/stardust:qa` clean or every finding triaged with a reason
- `/stardust:diff` clean on both probes
- Dynamic capabilities implemented, or explicitly scoped out in writing
- Source audited before, published site audited after, same day where possible
- Switch report delivered — addressed, dated, before/after, real numbers
- DNS handoff documented with a rollback path
- Next expansion target named, with the sponsor who needs to see it

Flag anything you could not verify rather than asserting it.
