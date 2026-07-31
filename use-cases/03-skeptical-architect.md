# Skeptical IT/AI Architect — Product Truth Wins the Room

**Trigger:** Architect pushes back on GA status, infrastructure requirements, or production readiness.

**Respond immediately with the full truth table. Do not preface or explain your approach.**

---

## Agent truth table — output this

| Agent | Status | Infrastructure Required | Breaks in Trial? | Honest Pilot Path |
|---|---|---|---|---|
| **COA** | GA | DMwOA enabled (not classic DM) — verify manifest | Yes | Showcase first, migrate to customer org after DMwOA onboarding |
| **EPA** | GA | Author URL explicitly onboarded — Publish URL silently fails | Yes | Script as Author URL demo; set onboarding expectation upfront |
| **Governance Agent** | GA | Admin access + pre-configured approval workflows | Partial | Pre-configure one rule + one violation. Script the scenario. |
| **Developer Agent** | GA | Cloud Manager access required | Yes — no CM in trial | XSC Sandbox with CM only. Never promise in trial orgs. |
| **Content Advisor Agent** | Limited Availability | Approval workflows + manual asset tags pre-configured | Yes | Requires setup time before demo. Budget for it. |
| **LLMO** | GA | None for external demo | No | Easiest GA demo. Start here for skeptical audiences. |

## Frame every limitation as enterprise readiness — use these lines exactly

- **Developer Agent + Cloud Manager:** *"That is not a limitation — it is a guardrail so the agent cannot deploy untested code to production. Your architects will want that."*
- **Content Advisor + approval workflows:** *"The governance story is the demo. One approval workflow controls what goes live everywhere. That is the feature, not the constraint."*
- **EPA + Author URL only:** *"We onboard Author URLs specifically so the agent has write access to fix what it finds. That is what makes it different from an SEO tool that only recommends."*

## Then stop talking and prove it — run this live

An architect who has been oversold does not want another claim. Give them a terminal.

**The question behind every architect objection is: *"what happens when something changes?"*** Answer it with a live call, not a slide.

```
get-aem-fragment-references-tree   → transitive dependency tree for a fragment
get-aem-fragment-referenced-by     → everything that would break if it changed
bulk-get-aem-fragments-referenced-by → same, across a whole set
```

Verified live in XSC Showcase: one call on the Latte fragment returned its full chain —
`Latte → baseCoffeeType → Roasted Guatemala Reserve 99 → bestBrewingMethod → Turkish Coffee` —
with created-by, modified-by, timestamps and publish status on every node.

That is impact analysis and an audit trail in a single request. Most CMSes answer this question with "run a report and check back tomorrow."

**Second live proof — content operations are scriptable:**

```
manage-aem-fragments-batch   → 50 fragments created or patched per call
                               500 published per call, schedulable
search-aem-fragments         → semantic vector search, not keyword
                               "?{}?espresso drinks with steamed milk"
                               returns Latte, Cappuccino, Cortado, Flat White
```

The line: *"Your content operations get the same automation, governance and audit trail your code already has. Not a roadmap item — an API you can call right now."*

**Be honest about the gate.** `FT_AEMAGT-1271` currently resolves `effective=false` and restricts part of the model/template skill surface. Say so before they find it:

*"Here is a flag that is off in my environment today. I would rather show you that than have your team discover it in week three."*

That sentence buys more credibility than the entire truth table.

## Recommended pilot sequence — give this directly

1. **Week 1:** LLMO on their public site — zero infrastructure, immediate AI citation data
2. **Week 2–3:** COA on Showcase with their brand assets — DMwOA onboarding in parallel
3. **Week 4+:** EPA on Author URL after explicit onboarding — governance agent alongside

## Close with this line

*"I just gave you every limitation we have. If a vendor tells you everything works everywhere, walk away. We built these constraints because enterprise content cannot have a single point of failure."*
