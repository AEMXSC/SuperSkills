# "Our Authors Cannot Find Their Own Content" — Semantic Discovery

**Trigger:** Migration scoping, content audit, content sprawl discovery, or a customer complaining that search inside their CMS is useless.

**This is a BUILD scenario — runs live queries against real content.**

**Execute immediately. Do not explain what you are about to do.**

---

## The capability

`search-aem-fragments` supports **vector search**, not just keyword matching. Prefix the query with `?{}?` and omit `queryMode`:

```
fullText: { text: "?{}?espresso drinks with steamed milk" }
```

**Verified live** against the Frescopa content set in XSC Showcase — returned Latte, Cappuccino, Cortado, Café au Lait and Flat White.

**None of those words appear in the query.** There is no keyword index that produces that result. This is the single fastest "that is genuinely different" moment available in an AEM demo, and it takes about ten seconds.

---

## Environment check

```
1. get-all-aem-author-environments   → pick an env with real content
2. search-aem-fragments (no filters, limit=5)
   → confirms fragments exist and the endpoint responds
   → empty result set = wrong environment, not a broken feature
```

**Semantic search needs real content to be impressive.** Five fragments of lorem ipsum demos nothing. XSC Showcase carries the Frescopa set (beverages, coffee types, brew methods, articles) — use it if the customer's own content is not loaded.

---

## Three plays

### Play 1 — The discovery moment (any deal, 10 seconds)

Ask the customer for a concept in their business language — not a keyword, a *concept*. "Something about our returns policy." "Anything covering pediatric dosing." Then run it.

```
search-aem-fragments
  fullText: { text: "?{}?<their concept, in their words>" }
  responseFormat: summary
```

*"I did not search for a word. I searched for a meaning. Your authors do not remember what they titled things three years ago — they remember what it was about."*

### Play 2 — Migration scoping (pairs with use-case 02)

The Sitecore/AEM-classic customer does not know what they have. Neither does anyone else. Use semantic search to build the inventory:

```
For each content theme the customer names:
  search-aem-fragments
    fullText: { text: "?{}?<theme>" }
    status: ['PUBLISHED','MODIFIED']     ← what is actually live
    modifiedBefore: '<2 years ago ISO>'  ← what is quietly rotting
    responseFormat: summary
```

Cross-reference with `bulk-get-aem-fragments-referenced-by` to separate *stale but load-bearing* from *safe to drop*. Output a scoped inventory: keep / migrate / retire.

That inventory is a real migration artifact and it lands harder than an estimate.

### Play 3 — Content audit and duplication

Run the same semantic query repeatedly across themes and look at what clusters. Near-identical fragments under different names is content sprawl — the thing they are paying for and cannot see.

```
search-aem-fragments  ?{}?<theme>
  → several fragments, near-identical content, different owners
  → get-aem-fragment-referenced-by on each
  → the ones with zero references are dead weight
```

*"You are maintaining six versions of this. Two are referenced. Four are being kept alive by nobody."*

---

## Filters worth knowing

`search-aem-fragments` combines semantic search with real filters — this is what makes it an audit tool rather than a party trick:

| Filter | Use |
|---|---|
| `status` | `NEW` / `DRAFT` / `PUBLISHED` / `MODIFIED` / `UNPUBLISHED` |
| `modifiedBefore` / `modifiedAfter` | Find stale content |
| `modifiedOrCreatedBy` | "What did the team that left behind?" |
| `path` | Scope to a brand or region |
| `modelIds` / `modelTags` | Everything on a given model |
| `locale` | Translation coverage gaps |
| `responseFormat: summary` | id + path + eTag only — feed straight into a batch patch |

`responseFormat: summary` is the important one for BUILD work: it returns exactly the `id` + `eTag` pairs that `manage-aem-fragments-batch` op=`patch` needs. Search → patch → publish becomes three calls with no plumbing in between.

---

## Chain it — find, then fix

The reason this matters beyond the demo:

```
1. search-aem-fragments   ?{}?<theme>, responseFormat=summary
                          → ids + eTags
2. manage-aem-fragments-batch  op=patch, 50 per call
                          → rewrite, retag, correct
3. manage-aem-fragments-batch  op=publish, 500 per call
```

*"Find every piece of content about X — by meaning, not keyword — rewrite it, publish it. Three API calls."* That is the agentic content operations story, demonstrated rather than described.

---

## Honest limits — say these before the customer finds them

- Semantic search covers **Content Fragments**, not Sites pages. For pages use `search-aem-pages` (full-text) or `search-aem-pages-by-component`.
- Quality tracks content quality. Thin or templated content clusters badly.
- It is **not** a replacement for the customer's site search. It is authoring-side discovery.

---

**The XSC's line on the call:**
*"Your authors do not remember what they named it. They remember what it was about. That is the search I just ran — and it is the same API your applications can call."*
