# Redesign-Led Migration — Off the Old CMS AND Onto the Brand

**Trigger:** Customer is leaving a CMS (WordPress, Contentful, Sitecore, AEM Classic) — especially against a license or contract deadline — and the site is off-brand, dated, or inconsistent with their flagship property.

**This is a BUILD scenario.** The runbook is [`skills/eds-redesign-migration`](../skills/eds-redesign-migration/SKILL.md). This file is the deal narrative: when to use it, what to say, how to handle the room.

---

## The proof point — lead with this

**Fiserv / Clover, July 2026. Real, dated, closed.**

```
Jul 14   Customer flags WordPress license expiry — 2 weeks to move blog.clover.com
+48 hrs  Adobe returns with the site REDESIGNED to clover.com's design and on EDS
Jul 30   Customer switches DNS. Live.
```

What it produced beyond the site:

- A **value-driven switch report** handed to the customer
- **Executive meetings** between Adobe and Fiserv that did not previously exist
- A **land-and-expand pipeline**: `blog.clover.com` (done) → `clover.com` (off Contentful) → `fiserv.com` → satellites
- A satellite POC proving it generalizes: `cardvalet.com` rebuilt in **Fiserv's** design → `main--uplift-cardvalet-eds--paolomoz.aem.page`

**The detail that makes it land.** Cardvalet was not redesigned to look like a better Cardvalet. It was rebuilt to look like **Fiserv**. That is brand consolidation delivered as a migration — one motion solving an infrastructure problem and a brand-fragmentation problem the customer had almost certainly scoped as separate multi-quarter projects with separate budget approvals.

**The line:** *"Your WordPress license expires in two weeks. We can have you off it — and on-brand — before then. We did exactly that for Clover's blog in 48 hours, and they switched DNS today."*

---

## Route in — three flows, not one

**The most important decision in the engagement.** Stardust has three distinct migration flavors with different fidelity gates. Picking wrong wastes the run.

```
What does the customer want to KEEP?
├── The DESIGN — change only the platform
│   → /stardust:replica
│     Pixel-perfect replatform, clean re-authored HTML/CSS (never DOM copies).
│     Gated on measured source fidelity: structural + visual + pixel diff
│     per breakpoint. Design changes only via an explicit inconsistency register.
│     Sells on: volume, cost, timeline, zero brand risk.
│
├── The CONTENT — apply someone else's design      ← THE FISERV PLAY
│   → /stardust:reskin
│     Content byte-faithful (text, ordered images, SEO metadata gated at byte
│     level). Design from a DONOR — another live site or static prototypes.
│     Sells on: brand consolidation delivered as a migration.
│
└── NEITHER — new design from intent
    → extract → direct → prototype   (or /stardust:uplift for a presales POC)
      Sells on: modernization, performance, differentiation.
```

**Cardvalet-on-Fiserv is `reskin`.** Cardvalet's content, Fiserv's design system. Naming it correctly gets you a **byte-level content-fidelity gate** for free — exactly the guarantee a nervous customer wants when you tell them a machine rebuilt their site.

The skills state their own boundaries: `replica` is *"NOT for redesigns"*; `reskin` is *"NOT for keeping the current design while migrating (that's the replica flow)."* Respect them.

**Mixed asks are normal** — "keep most of it, make the top 20 on-brand" is `replica` for the bulk and `reskin` for the 20. Name the split explicitly; it shows you understand the difference rather than selling one hammer.

> **`/page-import` is still the right tool** when the customer wants a canonical EDS block rewrite outside the Stardust pipeline — see *Faithful port* below. Stardust's `replica` is the better answer when design fidelity is the priority and you want a measured gate proving it.

---

## Set expectations honestly — this is human-in-the-loop

The 48-hour number is real. It is also a **redesigned, migrated site** — not a finished replacement for every interactive feature. Overselling this loses architects, and it is the easiest place to lose them.

Two reasons a human stays in the loop, per the field:

1. **Taste** — iterating on the design. You *can* accept the first output; the good ones are iterated.
2. **Completing it end to end** — identifying and covering unique cases, validating, QA, fixing AI inaccuracies.

**Dynamic capabilities are their own workstream** — item lists, search, API integrations, widgets. Budget **at least a day**, separately. This is where migrations actually stall, and surfacing it early is a credibility win, not a concession.

Say which you are promising: *"48 hours to a redesigned, migrated, on-brand site. Your search and product feeds are a separate conversation and I will scope them honestly."*

---

## The demo / delivery arc

Full runbook in [`skills/eds-redesign-migration`](../skills/eds-redesign-migration/SKILL.md). The shape the customer experiences:

| Beat | What they see |
|---|---|
| **1. Baseline** | Their current site audited — the "before" column, captured before anything changes |
| **2. Plan** | Full URL list, page types, required blocks, and the **dynamic capabilities inventory**. This is a real deliverable, not a byproduct |
| **3. Direction** | A reviewable **reasoning trace** for the design — not a finished design with no rationale |
| **4. Home page** | Iterated live until right. This is the moment they realize it is *their brand*, not a template |
| **5. At scale** | The rest of the site generated against the locked design |
| **6. Live** | Deployed, PageSpeed 100, editable in DA by their own team |
| **7. Report** | The switch report — addressed, dated, before/after, same-day audit |

**Beat 4 is the one that sells it.** Iterating the home page in front of them, against their flagship's design, is when the room stops evaluating a tool and starts planning a rollout.

---

## The switch report — the artifact that closes it

Model: `paolomoz.github.io/stardust-site/audit/clover-blog/switch-report.html`

Confirmed shape:

- **Framed as a delivery, not a proposal** — *"Your new website is ready. It's already live."*
- **Addressed and dated to the customer** — "Prepared for Clover", 29 July 2026
- **"Independent site audit, run on both versions the same day"** — stated explicitly. Same-day removes "you tested ours on a bad day," and that sentence is doing real work
- **Before/after with real screenshots**, the old one labelled "Today's site" so the contrast is unarguable

**Build one for every redesign-led migration.** The site convinces the practitioner. The report is what the champion forwards to the executive who was not on the call — which is precisely how the Clover work turned into Fiserv exec meetings.

---

## Land and expand — script this from day one

The Fiserv sequence is deliberate, and it is the template:

```
1. Smallest urgent property first   blog.clover.com — real deadline, low blast radius
2. Flagship next                     clover.com — off Contentful, credibility earned
3. Parent brand                      fiserv.com
4. Satellites                        cardvalet.com and others
   → POC each in the PARENT's design to make the brand argument concrete
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
Then it is a faithful port. Say so plainly and switch. Pushing a redesign on a customer who asked for a port loses the migration too.

**"How is a 48-hour redesign not slop?"**
Stardust extracts the **actual brand surface** from the reference site and works within it — it is not generating a look from a prompt. `/stardust:direct` writes a reviewable reasoning trace, the home page is iterated by a human, and `/stardust:diff` proves nothing was lost. Show the trace. The answer to "did a machine make this up" is a document they can read.

**"Our brand team will never accept it."**
Get them in early and aim at their reference site. The output is brand-faithful *to a property they already own and approved* — a very different conversation from a redesign proposal.

**"What about our search / product feed / integrations?"**
Separate workstream, at least a day, scoped honestly in the migration plan. Never bundle it into the 48-hour number.

**"What happens after you leave?"**
Snowflake output is authorable in DA — their team edits pages without a developer. Pair with `use-cases/11` for the authoring story.

---

## Faithful port — when the answer is /page-import

Some deals genuinely want the existing design rebuilt as canonical EDS blocks: an approved design, a recent rebrand, or a pure volume-and-cost play across thousands of pages.

That path is the `/page-import` chain — `/scrape-webpage` → `/identify-page-structure` → `/page-decomposition` → `/authoring-analysis` → `/generate-import-html` → `/preview-import` — with `main--site-scope--aemsites.aem.live` for scope analysis.

**Two traps at 4,000-page scale:**

- **A batch write returning `404 Job not found` has usually SUCCEEDED.** Never retry — verify with `search-aem-fragments` first. Retrying a bulk find-replace duplicates across the whole scope, which at that size is not recoverable in the time you have.
- **Promotion is async, and publish reports a trigger, not a result.** Poll `get-aem-launch-job-status`, then confirm `r.body['cq:lastReplicationAction'] === 'Activate'` on a sample before telling the customer it shipped.

**Staging bulk change safely** — launch, edit inside it, review the diff, promote:

```
create-aem-page-launch      → srcPathList (multiple sites = multisite), liveDate
bulk-find-replace-aem-pages → launchPath set; pass ORIGINAL paths in authorPaths
compute-aem-launch-differences → THE demo artifact; poll job status
promote-aem-page-launch     → promotionScope='smart'
```

For Content Fragments: `create-aem-launch` (CF **UUIDs**, not paths) → `manage-aem-fragments-batch` op=`findReplace` with `dryRun=true` **first** → diff → `promote-aem-launch`.

**Never skip the dry run in front of a customer.** `dryRun` and the launch diff exist so you can show *review before commit*. Running a destructive bulk edit live, even successfully, teaches the room the wrong lesson about the platform.

---

**The XSC's line on the call:**
*"You have two problems — you are on the wrong CMS and this site does not look like your brand. Most vendors will scope those as separate projects. We did both for Clover's blog in 48 hours, and they switched DNS today."*
