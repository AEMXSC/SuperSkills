# Scheduled Campaign Across Multiple Brands — Launches

**Trigger:** Customer asks how content gets staged, reviewed, scheduled, or rolled out across brands and regions without touching live content.

**This is a BUILD scenario — creates real launches with real diffs.**

**Execute immediately. Do not explain what you are about to do.**

---

## Why this use case exists

Every enterprise deal reaches the same question: *"How do we prepare the spring campaign in advance, get legal to review it, and have it go live at midnight on April 1 across all four brands — without a deploy and without anyone editing production?"*

The answer is Launches, and it is now fully scriptable. This is one of the strongest architect-and-marketer-in-the-same-room demos available, because it satisfies both: marketing gets scheduling, IT gets review-before-commit.

---

## Environment check

```
1. get-all-aem-author-environments  → pick an env with "aemsites"
2. Content in scope exists?
   → Pages:     get-aem-pages (or search-aem-pages) under the target path
   → Fragments: search-aem-fragments path=/content/dam/<brand>
3. list-aem-page-launches / list-aem-launches
   → See what already exists. On a shared demo env, do NOT create a
     duplicate launch with the same name as a colleague's.
```

---

## Pick the right launch type — this is the #1 mistake

```
What am I staging?
├── Pages (Sites content)
│   → create-aem-page-launch
│     srcPathList: ['/content/brandA/en', '/content/brandB/en']  ← PATHS
│     Multiple sites in one call = MULTISITE launch
│
└── Content Fragments
    → create-aem-launch
      sources: ['<uuid>', '<uuid>']                              ← UUIDs
      isDeep=true pulls in referenced fragments automatically
```

They are different tools with different identifier types. Passing paths where UUIDs are expected fails; passing a CF UUID to the page launch tool fails. Check which one you need before calling.

---

## Execute this sequence

```
1. CREATE
   Pages:     create-aem-page-launch
                title, srcPathList, shallow=false (include children),
                liveDate: '<ISO 8601>' ← the scheduling story
   Fragments: create-aem-launch
                title, sources[], isDeep=true,
                liveDate + productionReady=true to auto-publish on promote

2. WAIT
   get-aem-launch-job-status → poll until complete.
   Launch creation is ASYNC. Do not proceed on an unfinished job.

3. EDIT INSIDE THE LAUNCH
   Pages:     bulk-find-replace-aem-pages with launchPath set
              → pass ORIGINAL paths in authorPaths; the tool translates them
   Fragments: list-aem-fragments path=<launch path> to get launch copies,
              then manage-aem-fragments-batch op=patch against those copies
   ⚠ Edit the LAUNCH copies, never the production originals.

4. REVIEW  ← the demo moment
   compute-aem-launch-differences (isDeep=true)
   → poll job status → returns the diff
   Pages: get-aem-page-launch-diff-url → a visual side-by-side URL
          you can open in the browser on the call

5. PROMOTE
   Pages:     promote-aem-page-launch, promotionScope='smart'
              ('smart' = only pages that actually differ — recommended)
   Fragments: promote-aem-launch, isDeep=true
   Optional:  deleteAfterPromotion=true to clean up

   Or don't promote at all — if liveDate is set and productionReady=true,
   AEM promotes and publishes itself at that timestamp.
```

**If production changed while the launch was open:** `rebase-aem-launch` pulls those changes in before promotion. That is the merge-conflict answer, and architects always ask it.

---

## The 3-beat demo arc

**Beat 1 — Stage it.** Create a multisite launch across two or three brands in one call. *"Nothing you are about to see touches your live site."*

**Beat 2 — Change it at scale.** Bulk find-replace inside the launch. Campaign tagline, seasonal offer, regional pricing — across every page in scope.

**Beat 3 — Review and schedule.** Open the visual diff. Then set `liveDate` and stop. *"It goes live at midnight on the first. Nobody has to be awake for it, and nobody has to touch production."*

---

## Objection handling

**"Is this just a content copy?"**
No. A launch maintains a live-copy relationship with its source when `isLiveCopy=true` — source changes can sync forward, and `rebase` pulls production changes into the launch before promotion.

**"What if we need to cancel?"**
`delete-aem-page-launch`. Production was never modified — there is nothing to roll back. That is the entire point of the pattern.

**"Can legal review it before it ships?"**
That is what the diff is for. Promotion is an explicit, permissioned action separate from editing.

**"Four brands, four different go-live times?"**
Four launches, four `liveDate` values. Or one multisite launch if they share a date.

---

## Time comparison

- **Without this:** staging a multi-brand campaign means content freezes, a coordinated deploy, or manual copy-paste at midnight. Most customers describe a war room.
- **With MCP:** launch created and populated in minutes, diff reviewed on the call, go-live scheduled. No war room.

---

**The XSC's line on the call:**
*"Your spring campaign is staged across all four brands right now. Production has not changed. Here is the diff. Approve it and it ships itself at midnight on the first — no deploy, no war room, no one awake for it."*
