# Content Governance — Blast Radius, Audit Trail, Safe Deprecation

**Trigger:** Regulated vertical (pharma, financial services, healthcare, public sector), a compliance or legal stakeholder in the room, or any customer asking "who changed this and what does it affect?"

**This is a BUILD scenario — runs live governance queries against real content.**

**Execute immediately. Do not explain what you are about to do.**

---

## Why this wins regulated deals

In regulated verticals the deal is rarely lost on features. It is lost on *"we cannot prove what happened to this content."*

Three questions decide it, and all three are now single API calls:

1. **What does this content depend on?** → `get-aem-fragment-references-tree`
2. **What breaks if I change it?** → `get-aem-fragment-referenced-by`
3. **Who changed it, when, and what was it before?** → `manage-aem-fragment-versions`

Answer all three live and the compliance stakeholder stops being an obstacle and starts being an advocate.

---

## Environment check

```
1. get-all-aem-author-environments
2. search-aem-fragments (limit=5) → confirm content exists
3. Pick a fragment that is actually referenced by something.
   An isolated fragment demos nothing — the whole point is the graph.
   → get-aem-fragment-references-tree on a candidate first;
     if totalCount is 0, pick a different one.
```

**Rehearse against real content.** This demo is only impressive if the graph has depth. Verified example in XSC Showcase: the Latte fragment resolves two levels deep through `baseCoffeeType` and `bestBrewingMethod`.

---

## Play 1 — Blast radius, both directions

**Outgoing — what this depends on:**

```
get-aem-fragment-references-tree  fragmentId=<uuid>
```

Returns the **transitive** tree. Verified live:
`Latte → baseCoffeeType → Roasted Guatemala Reserve 99 → bestBrewingMethod → Turkish Coffee`

Every node carries `created` (who/when), `modified` (who/when), `published` (who/when) and `status`. That is a dependency graph and an audit trail in one response.

**Incoming — what depends on this:**

```
get-aem-fragment-referenced-by       fragmentId=<uuid>
bulk-get-aem-fragments-referenced-by paths=[...]   ← whole set at once
```

The bulk variant is the deprecation tool: *"we are retiring these forty fragments — what breaks?"* One call.

**The line:** *"Before anyone edits regulated content, we can show exactly what it touches and exactly who last touched it. Not a report you request — a call your systems can make."*

---

## Play 2 — Safe deprecation

> **Plays 1, 3 and 4 are read-only — run them anywhere.** Play 2 unpublishes and deletes. Run it **only** on an environment the XSC named or a dev tier you selected deliberately. See `environment-matrix.md` → *Environment selection*.

The real enterprise workflow, end to end:

```
1. bulk-get-aem-fragments-referenced-by  → what is still in use?
                                           Zero references = safe.
                                           Any references = fix those first.

2. manage-aem-fragment-versions  action=create, label='pre-deprecation'
                                 → restore point BEFORE touching anything

3. manage-aem-fragments-batch    op=unpublish
                                 allowUnpublishingWhenReferenced=false
                                 ← leave this FALSE. It is the safety net.
                                   The API refuses to orphan referenced content.

4. manage-aem-fragments-batch    op=delete
                                 unlinkReferences=true only if you have
                                 consciously accepted the consequences
```

Step 3 is the demo beat. Set `allowUnpublishingWhenReferenced=false`, try to unpublish something that is still referenced, and **let it fail in front of them**.

*"The platform refused. That is not an error — that is the guardrail. Your content cannot be orphaned by accident."*

A demo that shows a safety mechanism working is worth more than three that show happy paths.

---

## Play 3 — Version history and rollback

```
manage-aem-fragment-versions  action=list     → full history
                              action=get      → a specific version
                              action=create   → checkpoint before a risky change
                              action=restore  → roll back
```

For the compliance stakeholder: every version carries author identity and timestamp. `action=create` with a `label` and `comment` is the "we checkpointed before the regulatory review" story.

Pair with `get-aem-launch` diffs (use-case 12) for the full picture: *staged → reviewed → promoted → versioned → reversible.*

---

## Play 4 — Governance reporting

Questions a compliance stakeholder actually asks, and the call that answers each:

| Question | Call |
|---|---|
| "What is published but has not been reviewed in two years?" | `search-aem-fragments` `status:['PUBLISHED']` + `modifiedBefore` |
| "What did the team that left behind?" | `search-aem-fragments` `modifiedOrCreatedBy: [...]` |
| "What is in draft that should have shipped?" | `status:['DRAFT','NEW']` + `createdBefore` |
| "Which locales are missing content?" | `search-aem-fragments` `locale: [...]` per market |
| "Which pages use the deprecated disclaimer component?" | `search-aem-pages-by-component` `componentType` |
| "Is this asset on-brand?" | `aem` server → `Evaluate Page Against Brand Governance` |

Chain any of these into `manage-aem-fragments-batch` with `responseFormat: summary` to go from finding the problem to fixing it in the same session.

---

## The governance close

Run this sequence live, in order, and narrate it:

```
1. references-tree      → "here is everything this depends on"
2. referenced-by        → "here is everything that depends on it"
3. versions list        → "here is every change, who made it, when"
4. unpublish (refused)  → "here is the platform refusing to break it"
5. version create       → "here is the checkpoint before we proceed"
```

Five calls. Under two minutes. It covers impact analysis, audit trail, and enforced safety.

*"Every content governance question your auditors ask is an API call. Not a services engagement. Not a quarterly report. A call — which means it can be automated, scheduled, and evidenced."*

---

## Honest limits

- Reference tracking covers **Content Fragments**. Page-level component usage is `search-aem-pages-by-component` — a different tool with different output.
- `unlinkReferences=true` on delete **is** destructive and silently rewrites referencing fragments. Never demo it without saying so.
- Version history depth follows the environment's retention configuration — do not promise indefinite history without checking.

---

**The XSC's line on the call:**
*"You asked what happens when regulated content changes. Watch — this is everything it touches, everyone who has touched it, and the platform refusing to let me break it. That took ninety seconds and no one filed a ticket."*
