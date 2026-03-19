# AEM XSC Super Soldier Skill Pack

> Encode 10 years of XSC field experience into your AI assistant.
> Works in Claude, GitHub Copilot, Gemini, Cursor, Windsurf, or any AI assistant.

---

## What Is This?

Think of it as the most experienced AEM XSC on your team — available at 11pm the night before a CMO call, instantly current on every product, every competitive situation, and every environment constraint in the portfolio.

**This is an expert advisor, not an executor.** It does not run the demo for you. What it does is what a 10-year senior XSC does when you walk into their office and say "I have a CSC deal with a retail CMO on Tuesday, they're on Wrike and Canva, what's my play?" — except it does it in 10 seconds, at any hour, for any XSC on the team regardless of their tenure.

One skill file loaded and your AI:

- Reads the deal signals you give it (audience, stage, stack, vertical) and tailors the approach
- Tells you the current play — not the 3-year-old product brief, the 2026 GenStudio-first narrative
- Flags the competitive displacement angle before you walk in blind
- Gives you the exact discovery questions that surface the pain your demo answers
- Scripts the 3-beat executive narrative, not a feature tour
- Tells you which environment you need and what will break if it is not pre-configured
- Hands you the objection responses before the objections come
- Routes you to the right repo, the right boilerplate, the right dev skill when you need to build

When MCP tools are connected (`hlx-admin-mcp`, Adobe DA MCP), it goes further — actually pushing content, triggering preview and publish, updating demo pages without touching a browser. But the core value is the advisor layer every XSC gets regardless of MCP setup.

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

## What This Skill Actually Does

Real scenarios. Copy any of these into your AI assistant after loading the skill.

---

### 1. Build a Custom Healthcare POC Before Tomorrow

```
I have a discovery call tomorrow with a health system — CMO + digital VP.
I want to show a custom demo with their industry look and feel, DA authoring,
and the AI content optimization agent workflow. What do I build and how?
```

The skill scans every org we have — AEMXSC, AdobeDevXSC, aemdemos — for existing
healthcare assets before suggesting you build anything from scratch:

- **AdobeDevXSC**: `blue-shield-ca`, `hillrom-baxter`, `baxter`, `stryker`, `stryker-da`
- **AEMXSC**: `poc-cr-nationwide` (insurance/health adjacent, has CLAUDE.md + AGENTS.md pre-wired),
  `poc-cr-nationwide-mutual`
- **aemdemos**: summit series demos with health-adjacent content blocks

If a match exists, you clone it and customize. If not, it picks `ise-boilerplate`
for DA + UE dual authoring, routes to `content-driven-development` and `building-blocks`
skills, and maps the exact build sequence to get to first preview before the call.

Flags the one constraint that will bite you in demo: COA (Content Optimization Agent)
requires DMwOA enabled in your environment — verify before you promise it live.

---

### 2. ExMod Migration — Sitecore Customer, 4,000 Pages

```
The customer is on Sitecore 9 with roughly 4,000 pages.
They want to see what AEM migration actually looks like end to end — not a slide.
Script the Experience Modernization demo from site analysis to first deployed page.
```

Pulls the full ExMod playbook: opens with the Site Scope Analyzer at
`main--site-scope--aemsites.aem.live` — paste their URL, AI analyzes block patterns
and complexity in real time. Then walks the three-phase story:

1. **Analyze** — AI maps page templates, identifies reusable block patterns, estimates effort
2. **Generate** — `aemcoder.adobe.io` writes EDS block code from the analysis; no manual dev
3. **Validate + Publish** — developer reviews, not authors; Lighthouse 100 on first deploy

The line that always lands: *"Your developers review AI-generated code — they do not write it.
That is the difference between 18 months and 6 weeks."*

Includes the talk track for turning a Sitecore migration anxiety conversation into
an AEM modernization excitement conversation.

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

```
The customer is a healthcare system with a patient portal, a mobile app,
a clinical staff intranet, and a public marketing site — all needing the same
core content structured differently per channel. They asked:
"Can AEM be our single source of truth and push to all four channels automatically?"
Show me the architecture and demo this end to end.
```

This is the AEM headless story at its best. The skill maps the full architecture:

1. **Author once** — structured Content Fragments in AEM Sites (fields: headline, body,
   CTA, channel-specific overrides)
2. **Expose everywhere** — GraphQL Persisted Queries serve the same fragment to web
   (EDS), mobile app (React Native), kiosk, and partner portal — each channel
   queries only the fields it needs
3. **Assets adapt automatically** — DMwOA delivers the same asset at the right format,
   crop, and resolution per channel from one URL; no rendition management
4. **AI optimizes per channel** — COA rewrites content for reading level and tone
   per destination (patient-facing vs clinical staff vs marketing)

The skill walks through a live demo using AEM's built-in GraphQL explorer,
shows a Content Fragment being updated once and rendered differently in two
channel previews simultaneously, and closes with the governance angle:
one approval workflow controls what goes live everywhere.

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

### 8. Push Demo Content via MCP Before a Call

```
I need to update the hero headline and two product pages on my demo site
at main--refdemo--adobe-demopoc.aem.live before a call in 90 minutes.
Use the MCP tools to make the changes without me touching da.live.
```

Uses `hlx-admin-mcp da_write` to write content + trigger preview + publish in one call.
No browser, no Sidekick click. Handles auth via `da_login` if the token has expired,
confirms identity with `da_whoami`, then executes. Demo is updated before your next coffee.

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
