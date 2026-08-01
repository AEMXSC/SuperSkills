# Redesign-Led Migration — Stardust + Snowflake

**Trigger:** Customer is leaving a CMS (WordPress, Contentful, Sitecore) **and** the site is off-brand, dated, or inconsistent with their flagship property. Or: a forcing function (license expiry, contract end) means they must move fast and want more than a like-for-like port.

**This is a BUILD scenario — produces a live, redesigned, EDS-hosted site.**

---

## This is NOT use-case 02

The two migration plays answer different customer questions. Pick deliberately — the tooling forks here and the `snowflake` skill enforces it.

| | **UC02 — ExMod / faithful** | **UC15 — redesign-led (this one)** |
|---|---|---|
| Customer question | *"Can you move our 4,000 pages?"* | *"Can you move us AND make it look like our flagship brand?"* |
| Output | Canonical EDS blocks, content re-authored | Original or improved design preserved, made authorable in DA |
| Pipeline | `/page-import` chain | `/stardust:*` → `/snowflake` |
| Sells on | Volume, cost, timeline | Brand consolidation, value, speed |
| Scale | Hundreds to thousands of pages | One site or section, then repeat |

> The `snowflake` skill states it directly: *"Do NOT use for canonical EDS block-rewrite migrations — that's the page-import skill."* If the customer wants their existing design rebuilt as native EDS blocks, you are in UC02. If they want a **better** site fast, you are here.

**Mixed asks are common.** "Move everything, and make the top 20 pages look like our new brand" = UC15 for the 20, UC02 for the rest. Say that out loud — it shows you understand the difference.

---

## The proof point — lead with this

**Fiserv / Clover, July 2026. Real, dated, and closed.**

```
Jul 14  Customer flags WordPress license expiry — 2 weeks to move blog.clover.com
+48 hrs Adobe returns with the site REDESIGNED to clover.com's design and
        migrated to EDS
Jul 30  Customer switches DNS. Live.
```

What it produced beyond the site:

- A **value-driven migration report** handed to the customer — see *The switch report* below
- **Executive meetings** between Adobe and Fiserv that did not exist before
- A **land-and-expand pipeline**: `blog.clover.com` (done) → `clover.com` (off Contentful) → `fiserv.com` → satellite sites
- A separate POC already proving the pattern generalizes: `cardvalet.com` rebuilt in **Fiserv's** design → `main--uplift-cardvalet-eds--paolomoz.aem.page`

**Why this lands harder than a migration story.** Cardvalet was not redesigned to look like a better Cardvalet. It was redesigned to look like **Fiserv**. That is brand consolidation delivered as a migration — one motion that solves an infrastructure problem and a brand-fragmentation problem the customer had probably scoped as a separate multi-quarter project.

**The line:** *"Your WordPress license expires in two weeks. We can have you off it — and on-brand — before then. We did exactly that for Clover's blog in 48 hours."*

---

## Environment check

```
1. Source site publicly reachable?
   → Must load in incognito. Auth walls break extraction.
2. Target EDS org + repo ready? (or a scratch org for a POC)
3. Brand reference available?
   → The flagship site whose design you are aligning TO.
     For Fiserv/Clover that was clover.com, not blog.clover.com.
     Without this you are doing a generic redesign — much weaker.
4. DA org confirmed at da.live (Snowflake output is DA-authorable)
```

---

## Pick your mode

```
How much time, and what is the ask?
├── Presales / POC — "show me what it could look like"
│   → FAST PATH. One command, three variants, hours not days.
│   → This is how cardvalet.com was produced.
│
└── Go-live — "we are actually moving, there is a deadline"
    → FULL PATH. Extract → direct → prototype → migrate → snowflake → deploy.
    → This is how blog.clover.com shipped.
```

---

## Fast path — presales POC

```
/stardust:uplift <URL>
```

One shot. Give it only the URL. It extracts the brand surface, identifies the design tension, and produces **three differentiated variants** (one deliberately cinematic) with validation — no need to coordinate the extract / direct / prototype chain yourself.

Then convert the chosen variant:

```
/snowflake
```

Static HTML → EDS, design preserved, content authorable in DA. Two modes:
- **Page-level** — overlay template with slot markers. Faster, good for a single hero page.
- **Block-level** — each section becomes an independent EDS block. Better when the customer will extend it.

For a POC, page-level is usually enough. Do not over-engineer a throwaway.

**Aim the uplift at the brand you are consolidating TO**, not at the source site. That is the whole point.

---

## Full path — go-live

```
1. /stardust:extract <URL>
   → crawls the site, seeds stardust/current/ with PRODUCT.md, DESIGN.md,
     DESIGN.json, a per-page inventory and the consolidated brand surface
   → this inventory IS your migration scope artifact — show it to the customer

2. /stardust:direct
   → sets the redesign direction against the brand reference, writes the
     target spec plus a reasoning trace at stardust/direction.md
   → the reasoning trace is reviewable. Walk the customer through it rather
     than presenting a finished design with no rationale.

3. /stardust:prototype
   → builds the pages against the target spec

4. /stardust:prepare-migration  →  /stardust:migrate
   → moves content into the new structure

5. /snowflake
   → static → EDS, authorable in DA
   → block-level mode for a go-live: the customer's team will extend this

6. /stardust:deploy   →   /stardust:diff
   → deploy, then diff to confirm nothing was lost against the source
```

Run `/stardust:diff` **before** the customer sees it. It is the "did we drop anything" check and it is cheaper to answer yourself than in a review meeting.

---

## The switch report — the artifact that closes it

Paolo's Clover report is the model:
`paolomoz.github.io/stardust-site/audit/clover-blog/switch-report.html`

Shape, and why it works:

- **Framed as a delivery, not a proposal.** Headline: *"Your new website is ready. It's already live."* Not "here is what we could do."
- **Addressed to the customer** — "Prepared for Clover", dated.
- **Both versions measured the same day**, described as an independent audit. Same-day matters: it removes "you tested ours on a bad day."
- **Before/after with real screenshots**, labelled "Today's site" so the contrast is unarguable.

**Build this for every redesign-led migration.** The site convinces the practitioner; the report is what the champion forwards to the executive who was not on the call. That is how the Clover work turned into Fiserv exec meetings.

> **Tooling status — be accurate here.** The field references `/stardust:audit <URL>` for generating this report, and the before/after comparison is described as a further prompt on top. **`audit` is not in the installed Stardust 0.12.0** (which ships: `extract`, `direct`, `prototype`, `migrate`, `prepare-migration`, `uplift`, `deploy`, `diff`). If you need the report, check with Paolo (`paolomoz`) for the current skill or prompt rather than assuming the command exists. Do not promise a customer an artifact you have not generated.

---

## Land and expand — script this from day one

The Fiserv sequence is the template, and it is deliberate:

```
1. Smallest urgent property first   blog.clover.com (WP license expiry)
   → real deadline, low risk, fast win
2. Flagship next                     clover.com (off Contentful)
   → credibility earned, bigger platform decision
3. Parent brand                      fiserv.com
4. Satellites                        cardvalet.com and others
   → POC each in the parent's design to make the brand argument concrete
```

**Take the small urgent one first.** A blog with a two-week license deadline is a better opening than the flagship: the customer feels the pain, the blast radius is small, and success buys the conversation about everything else.

**Discovery questions that surface this play:**

- *"Which of your properties are on a different CMS from your main site?"*
- *"Are any licenses or contracts up for renewal in the next quarter?"*
- *"If I showed you one of your satellite sites in your flagship's design, who would need to see it?"*

That last one finds the executive before you need them.

---

## Objection handling

**"We just want a like-for-like move — do not redesign anything."**
Then this is UC02. Say so plainly and switch. Do not push a redesign on a customer who asked for a port; you will lose the migration too.

**"How is a 48-hour redesign not slop?"**
Stardust extracts the **actual brand surface** from the reference site and works within it — it is not generating a look from a prompt. `/stardust:direct` writes a reviewable reasoning trace, and `/stardust:diff` proves nothing was lost. Show the trace. The answer to "did a machine just make this up" is a document you can read.

**"Our brand team will never accept it."**
Get them in early and aim at their reference site. The output is brand-faithful *to a property they already own and approved*. This lands very differently from a redesign proposal.

**"What happens after you leave?"**
Snowflake output is authorable in DA. Their team edits pages without a developer. Pair with `use-cases/11` for the authoring story.

---

## Time comparison

- **Traditional:** redesign engagement (6–12 weeks) **plus** a separate migration project. Most customers never start because the combined cost needs two budget approvals.
- **This play:** POC in hours, go-live in days. blog.clover.com went from ask to DNS switch in roughly two weeks, with the redesigned site delivered inside 48 hours.

---

**The XSC's line on the call:**
*"You have two problems — you are on the wrong CMS and this site does not look like your brand. Most vendors will scope those as separate projects. We did both for Clover's blog in 48 hours, and they switched DNS today."*
