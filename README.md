# AEM XSC Super Soldier Skill Pack

> Encode master level XSC field and product experience into your AI assistant.
> Works in Claude, GitHub Copilot, Gemini, Cursor, Windsurf, or any AI assistant.

---

## What Is This?

Think of it as a team of the most experienced AEM XSC's — available at 11pm the night before a CMO call, instantly current on every product, every competitive situation, and every environment constraint in the portfolio.

XSCs do two things: they **advise** (position, script, strategize) and they **build** (custom demos, POCs, block code, imported pages). This skill does both. That is the job.

**As an advisor**, it does what a 10-year senior XSC does when you walk in and say "I have a CSC deal with a retail CMO on Tuesday, they're on Wrike and Canva, what's my play?" — reads the deal signals, resets the narrative to the current play, flags the environment traps, gives you the discovery questions, scripts the executive arc, and hands you the objection responses. In 10 seconds, for any XSC on the team regardless of tenure.

**As a builder**, it executes. With the 17 EDS dev skills loaded alongside it:
- Imports a customer's site for a migration demo (`/page-import`)
- Builds custom blocks for a vertical POC (`/content-driven-development`)
- Validates the demo site hits PageSpeed 100 before the call (`/testing-blocks`)
- Finds the right reference block implementation (`/block-collection-and-party`)

With MCP tools connected (`hlx-admin-mcp`, Adobe DA MCP):
- Pushes content, triggers preview, publishes — without opening a browser
- Updates demo pages programmatically before a call
- Creates and manages DA content at the API level

One skill that covers the full XSC role — strategic preparation and hands-on execution.

---

## File Structure

```
SuperSkills/
├── README.md               ← You are here. Install guide + use cases + contribution guide.
├── SKILL.md                ← Master orchestrator. Load this file to activate the skill.
│                             Contains: XSC persona, routing tables, Demo Brief template,
│                             4-stage demo lifecycle, DA vs UE guide, MCP toolbox,
│                             quick reference plays, top 5 differentiators, instant URLs.
│
├── demo-plays.md           ← Full demo scripts + exact AI prompts for every play
│                             ExMod, ASO, COA, EPA, Governance Agent, Developer Agent,
│                             Content Advisor Agent, LLMO, CSC, EDS/XWalk, DMwOA,
│                             Cross-play objection handling
│
├── environment-matrix.md   ← What works where — capability x environment grid
│                             XSC Showcase / Ref Demo Shared / Trial / Playground / Customer Org
│                             Pre-demo setup checklist, 9 failure modes + fixes
│
├── tech-depth.md           ← Build mode: repos, boilerplates, MCP tools, dev skills
│                             AEMXSC org repos, AdobeDevXSC 30+ vertical demos,
│                             17 EDS dev skills bridged to XSC use cases,
│                             DA + UE dual authoring setup, CLI tools, aem.live docs
│
└── competitive-intel.md    ← Win the room when a competitor comes up
                              Full breakdowns: Sitecore, Contentful, Optimizely,
                              WordPress VIP, Drupal, Next.js/Vercel
                              Gartner 2025 MQ counter-narrative, ASO vs BrightEdge/Conductor/Semrush,
                              Firefly indemnification play, LLMO first-mover, 20+ stats with sources
```

---

## How the Skill Is Grounded

Every scenario in this skill covers all six dimensions of the XSC role:

| Dimension | What it means in practice |
|---|---|
| **Intent** | What is the customer actually trying to solve — not what product they asked about |
| **Discovery** | The exact questions that surface pain before you show a single screen |
| **Advisory** | The narrative, the competitive angle, the objection responses |
| **Key Tech Concepts** | What the XSC needs to understand to demo it credibly |
| **Development** | What gets built — repos, blocks, models, imports, content — with real execution |
| **AI** | Where AI augments the work: generating code, analyzing sites, optimizing content, pushing via MCP |

The build scenarios (1, 2, 4, 8) are not walkthroughs — they execute. The advisory scenarios (3, 5, 6, 7, 9, 10) prepare you for the room. Both are the XSC job.

---

## What This Skill Actually Does

Real scenarios. Copy any of these into your AI assistant after loading the skill.

---

### 1. Build a Custom Healthcare POC Before Tomorrow
**This is a BUILD scenario — the skill executes, not just advises.**

```
I have a discovery call with Memorial Health System tomorrow — CMO + digital VP.
They want to see a healthcare-branded demo site with DA authoring for the content team
and Universal Editor for the IT team, plus the AI content optimization agent workflow.
Build it. Base on ise-boilerplate. Deploy to a new GitHub repo.
```

**What the skill actually does:**

First scans every org for existing healthcare assets before building anything new:
- `AdobeDevXSC`: `blue-shield-ca`, `hillrom-baxter`, `baxter`, `stryker`, `stryker-da`
- `AEMXSC`: `poc-cr-nationwide` (CLAUDE.md + AGENTS.md pre-wired), `poc-cr-nationwide-mutual`
- `aemdemos`: summit series with health-adjacent blocks

If a match exists — clones it and adapts branding. If not — scaffolds from `ise-boilerplate` and executes the full build sequence:

1. `fstab.yaml` configured for DA content mount
2. Custom blocks built for the healthcare demo narrative (`/content-driven-development`)
3. DA authoring configured — content structure, table format, Sidekick setup
4. Universal Editor wired — `component-definition.json`, `component-filters.json`, `component-models.json`, per-block UE model files for every block
5. Demo content pages created in DA table structure
6. GitHub repo created, `aem-code-sync` app installed, code live on CDN
7. PageSpeed validated at 100 before you walk into the call (`/testing-blocks`)

Flags the one constraint that bites every XSC: COA requires DMwOA enabled — verify your Showcase environment has it before you promise it live.

**Time comparison:**
- Last year without AI: 2–3 developer days minimum. XSC either waited for SE support or showed a generic demo
- With SuperSkills: 4–6 hours to first live preview. Run it overnight, walk in with a branded healthcare site the customer has never seen before

---

### 2. ExMod Migration — Sitecore Customer, 4,000 Pages
**This is a BUILD scenario — produces real migration artifacts, not slides.**

```
The customer is on Sitecore 9, roughly 4,000 pages, healthcare vertical.
I have a 2-hour technical demo in 3 days. I need:
1. Site scope analysis of their public site showing AI-analyzed complexity
2. Migration report — page templates identified, block patterns, effort estimate
3. First 5 pages imported and running as EDS as proof they can see live
Script the demo AND execute phases 1 and 2.
```

**What the skill actually builds:**

Runs the full import pipeline — not a walkthrough, actual execution:

1. **Site Scope Analyzer** (`main--site-scope--aemsites.aem.live`) — paste the customer URL, AI maps every page template, identifies repeating block patterns, scores migration complexity. Output is a real artifact you show in the demo
2. **`/page-import` orchestrator** — scrapes the 5 representative pages the customer chose
3. **`/identify-page-structure`** — analyzes each page's section boundaries and content types
4. **`/page-decomposition`** — breaks sections into named block candidates
5. **`/authoring-analysis`** — recommends DA vs UE per section based on content type
6. **`/generate-import-html`** — produces EDS-ready HTML for each imported page
7. **`/preview-import`** — validates first preview is live before the demo call
8. **Block spec PRD auto-generated** from the block inventory — each identified pattern (hero-banner, specialty-cards, stats-grid, tabs, etc.) becomes a structured spec with fields, DA table input format, and UE model requirements. `/building-blocks` generates the working JS + CSS + UE model JSON for each block directly — same output as aemcoder.adobe.io but via API, no browser required

The customer watches their own pages appear as a live EDS site during the demo. That is not a slide.

The line that always lands: *"Your developers review AI-generated code — they do not write it. That is the difference between 18 months and 6 weeks."*

**Time comparison:**
- Last year without AI: Migration scoping alone = 2–4 weeks. A page-by-page import proof point required a full developer sprint. Most XSCs showed PowerPoint
- With SuperSkills: Site analyzed in 30 minutes. 5 pages imported, converted, and previewing in 2–3 hours. Show it live in the demo

---

### 3. Skeptical IT/AI Architect — Product Truth Wins the Room

```
The customer IT architect pushed back hard: "We evaluated AEM AI agents 6 months ago
and half of them were not GA. What has actually shipped, what still requires workarounds,
and what is the realistic infrastructure ask to run this in production?"
Give me the honest answer that wins this person over.
```

This is where most XSCs lose architects — by overselling. The skill does the opposite.
It gives the **complete product truth table**: GA vs Limited Availability vs Preview,
exact infrastructure requirement per agent, what breaks in trial orgs, and what the
real onboarding path looks like.

The skill frames every limitation as a proof of enterprise readiness:
- "Developer Agent requires Cloud Manager — that is not a limitation, that is a guardrail
  so it cannot deploy untested code to production."
- "Content Advisor Agent needs approval workflow pre-configured — that is the governance
  story, not a constraint."

Architects respect candor. The skill gives you the talking points that make a skeptic
say *"finally, someone who knows the product"* — and that is when the deal opens up.

Outputs a full agent truth table: availability status, infrastructure requirements,
trial vs Showcase behavior, and the honest pilot recommendation for each.

---

### 4. Omni-Channel Content Activation — Content Fragments + GraphQL
**This is a BUILD scenario — sets up a working headless demo with live queries.**

```
The customer is a healthcare system: patient portal, mobile app, clinical staff intranet,
and public marketing site — all need the same core clinical content, structured differently
per channel. Build a demo showing one Content Fragment authored in AEM delivered to
3 channel renditions via GraphQL. Include DMwOA for adaptive asset delivery.
Set up the CF model, sample content, and the GraphQL queries I can run live in the demo.
```

**What the skill actually builds:**

1. **Content Fragment model** — defines the schema (headline, body, CTA, channel overrides, compliance fields). Configuration files written and committed
2. **Sample content** — 3 representative healthcare Content Fragments created with real content (patient-facing, clinical staff, marketing tone variants)
3. **GraphQL persisted queries** — one query per channel, each returning only the fields that channel needs. Ready to execute live in AEM's GraphQL Explorer during the demo
4. **Channel preview pages** — simple renditions showing the same CF displayed as patient portal card, mobile app tile, and clinical staff alert — same source, three outputs, visible simultaneously
5. **DMwOA delivery** — single asset URL configured to serve web crop, mobile crop, and thumbnail automatically with no rendition management

The demo moment: update one field in the Content Fragment, save, all three channel previews refresh. One author, zero ops tickets.

Closes with the governance angle: one approval workflow controls what goes live everywhere — patient-safe content cannot ship without compliance sign-off regardless of channel.

**Time comparison:**
- Last year without AI: AEM architect + developer + 3–5 days to define CF schema, write GraphQL queries, build channel renditions, populate sample content
- With SuperSkills: Full working demo with live queries in 1–2 hours

---

### 5. Competitive RFP — Three-Way Bake-Off

```
We are in a 3-way bake-off: Adobe vs Sitecore vs Contentful.
The customer is a global pharma company — marketing + IT both in the room.
Deal stage: technical validation. They want a 60-minute deep-dive.
I have access to my XSC Showcase. What is my full demo strategy?
```

The skill builds a complete demo brief, selects plays (EDS performance + AI Agents + CSC),
routes to the exact competitive counters for both Sitecore AND Contentful simultaneously,
flags every environment constraint for the plays selected, and outputs a scripted
60-minute narrative arc with exact agent prompts and fallback options.

---

### 6. LLMO — Customer Watching Their Organic Traffic Disappear

```
The customer said: "We are seeing our organic traffic drop because ChatGPT is
answering questions that used to send people to our site. What does Adobe do about this?"
Script me a 20-minute LLMO demo. They have never heard of GEO.
```

Opens with the AI citation problem, walks through LLMO "Optimize at Edge" at CDN layer,
uses the external-safe `play.llmo.now` demo URL, cites the adobe.com customer zero stats,
and closes with the Semrush $1.9B acquisition as proof Adobe is making the biggest
structural bet in the market on AI search being the future of SEO.

---

### 7. Pre-Demo Crisis: 30 Minutes to Call Time

```
I am running ASO on the customer URL and getting zero issues found on everything.
The call is in 30 minutes. What is wrong and how do I fix it fast?
```

Routes to the environment-matrix troubleshooting guide, identifies the most likely causes
(URL behind auth wall, CDN caching a clean state, wrong URL format),
gives the fastest fallback (switch to Frescopa demo URL in under 5 minutes),
and arms you with the backup narrative: *"Let me show you what this looks like on a site
we already analyzed — then we will run yours live in the trial."*

---

### 8. Personalize the Demo Site via MCP — No Browser Required
**This is a BUILD scenario — the skill executes API calls, not instructions.**

```
My demo at main--refdemo--adobe-demopoc.aem.live needs these updates before the 2pm call:
- Hero headline: "Transform Patient Engagement with AI-Powered Content"
- Homepage sub-headline: "Purpose-built for Memorial Health System"
- Products page: rewrite all 3 product descriptions for healthcare context
Do it now. Do not open a browser.
```

**What the skill actually executes** (with `hlx-admin-mcp` connected):

1. `da_login` → checks token, re-authenticates via OAuth if expired
2. `da_whoami` → confirms identity before writing
3. `da_write` → updates hero headline → CDN preview triggered → published ✓
4. `da_write` → updates sub-headline → CDN preview triggered → published ✓
5. `da_get_source` → reads current products page to preserve structure
6. `da_write` × 3 → rewrites each product description with healthcare context → preview → published ✓
7. Returns confirmation: all 5 changes live, preview URLs for each

The customer sees a site that looks like it was built for them. It took one prompt.

**Time comparison:**
- Last year without MCP: Open da.live, navigate to each page, edit manually, click Sidekick preview, click publish — 15–20 minutes per page, over an hour for a full personalization pass
- With SuperSkills + MCP: One prompt, all pages updated and published in under 5 minutes. Run it while you review your notes for the call

---

### 9. CSC Deal — The Expert Advisor in Action

This scenario shows exactly what the skill is built for. Not execution — expert preparation.

```
I have a CSC discovery call with a retail CMO on Tuesday.
They mentioned they use Wrike for project management and Canva for creative.
What is my play and what do I actually demo?
```

A junior XSC pulls the product brief and builds a feature tour.
This skill does what a senior XSC does — reads the deal and reframes everything:

**Reads the signals.** Wrike + Canva = mid-market creative team trying to scale.
CMO title = lead with velocity and brand risk, not infrastructure or product names.

**Resets the narrative.** GenStudio for Performance Marketing is the 2026 play for this
audience — not "AEM as anchor, Workfront as orchestrator." For a CMO, the story is one
place to brief, generate, review, activate, and measure. They do not need to know which
product is which layer.

**Gives the competitive displacement angle.** Do not open with "Workfront replaces Wrike."
Open with: *"How many campaigns did you delay last quarter because creative was the
bottleneck?"* That question reframes the conversation before you show a single screen.

**Flags the environment trap before you hit it.** This demo requires the Firefly-enabled
Showcase sandbox with GenStudio pre-configured — XSC Showcase only, not available in
trial orgs. Confirm with your SE that it is live before Tuesday. If it is not ready,
run the recorded walkthrough and position the hands-on as their trial milestone.

**Outputs the 3-beat CMO demo arc** — not a feature tour, three business moments:
- Beat 1: Brief enters → Firefly generates on-brand variants in 2 minutes → CMO approves in one click
- Beat 2: Asset live in AEM → same asset reformatted for web, email, social via DMwOA automatically
- Beat 3: Analytics shows which variant drove conversion → feeds the next brief

**Hands you the discovery questions** that surface the pain the demo answers:
- "What happens between a campaign brief being approved and the first asset going live — how many handoffs?"
- "How do you enforce brand guidelines when creative is distributed across agencies?"
- "What percentage of your Canva output gets flagged for brand review before it ships?"

**Gives you the Canva objection response** before they raise it:
*"Canva is great for individuals. What it does not solve is brand governance at scale —
who approves before it goes live, where is the audit trail, and how does it connect to
your analytics?"*

That is the difference between a product brief and an expert advisor. The skill does
not script the demo. It prepares you for the room.

---

### 10. Gartner MQ Objection — "Optimizely Is Number One"

```
The prospect said: "Optimizely was rated number one in the Gartner DXP Magic Quadrant.
Why would we choose Adobe?" What do I say?
```

Pulls the Gartner 2025 counter-narrative: Adobe is number two but has been a consecutive
Leader for 8 years. The MQ scores today's DXP — it does not score Lighthouse 100 by
architecture, LLMO for AI search, the Semrush $1.9B acquisition, or the AI agent layer.
Pivots with: *"Gartner measures where the market is today. The question is where your
content strategy needs to be in 2027 — and that is a different conversation."*

---

## Install in 60 Seconds

### Claude Code
```bash
# One-line install
npx skills add https://github.com/AEMXSC/SuperSkills

# Or clone manually
git clone https://github.com/AEMXSC/SuperSkills
cp -r SuperSkills/ ~/.claude/skills/aem-xsc/
```
Invoke with `/aem-xsc` or just start asking — the skill is auto-discovered.

### GitHub Copilot (VS Code)
Clone this repo into your project — `.github/copilot-instructions.md` auto-activates
the XSC persona in Copilot Chat. No setup required.

### Cursor
Open this folder in Cursor — `.cursor/rules` activates automatically.

### Windsurf
Open this folder in Windsurf — `.windsurfrules` activates automatically.

### Gemini / ChatGPT / Any other LLM
Open `SKILL.md`, paste its full contents as your first message:
*"These are your working instructions for this session:"*
For deep scripts or competitive details, paste the relevant companion file.

### Agentic / n8n / API
Reference `SKILL.md` as a system prompt. Pure markdown — no tool-calling required.

---

## LLM Plugin Support

| AI Assistant | File | Activation |
|---|---|---|
| **Claude Code** | `.claude-plugin/plugin.json` | Auto-discovered. `npx skills add https://github.com/AEMXSC/SuperSkills` |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Auto-loads in any repo that clones SuperSkills |
| **Cursor** | `.cursor/rules` | Auto-applied when you open this folder |
| **Windsurf** | `.windsurfrules` | Auto-applied when you open this folder |
| **Gemini / ChatGPT** | `SKILL.md` | Paste as system prompt — no plugin format yet |

---

## How to Update This Skill

**Rule:** Each file has a clear scope. Add to the right file.

| If you want to add... | Edit this file |
|---|---|
| A new demo script or AI prompt | `demo-plays.md` |
| Environment constraint or capability flag | `environment-matrix.md` |
| A new repo, boilerplate, or build pattern | `tech-depth.md` |
| A competitive fact, stat, or objection response | `competitive-intel.md` |
| A new routing entry or demo play category | `SKILL.md` — Intent Detection table |
| A new instant demo URL | `SKILL.md` — Instant Demo URLs table |

### Contribution Steps

1. Branch off main
2. Edit the relevant file — plain markdown, no special syntax
3. Mark outdated content with `LEGACY:` prefix rather than deleting
4. Source competitive stats — include where you got the number
5. PR with a one-line description of what changed and why

### What Makes a Good Update

- Verified in a real demo — if you ran it and it worked or broke, document it
- Concrete — "ASO shows top 10 issues for Frescopa" beats "ASO shows issues"
- Honest about limitations — this skill is trusted because it does not oversell
- Time-stamped for anything that might expire: beta features, pricing, release dates

---

## Current Status

| File | Coverage | Last Verified |
|---|---|---|
| `SKILL.md` | Full demo lifecycle, all plays, DA/UE guide, MCP toolbox | Mar 2026 |
| `demo-plays.md` | 10 plays + objection handling | Mar 2026 |
| `environment-matrix.md` | 5 environments, 9 failure modes | Mar 2026 |
| `tech-depth.md` | AEMXSC + AdobeDevXSC orgs, 17 dev skills, MCP tools | Mar 2026 |
| `competitive-intel.md` | 6 competitors, ASO vs 3 SEO tools, 20+ stats | Mar 2026 |

---

## Questions / Feedback

Open an issue or ping the XSC team. If a demo play worked especially well or a competitive
response landed in a real deal, add it here — the whole team benefits.
