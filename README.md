# AEM XSC Super Soldier Skill Pack

> Encode 10 years of XSC field experience into your AI assistant.
> Works in Claude, GitHub Copilot, Gemini, Cursor, Windsurf, or any AI assistant.

---

## What Is This?

A portable, LLM-agnostic skill package that turns any AI assistant into a senior AEM XSC. One skill file loaded and your AI can:

- Design a full 4-stage demo plan tailored to deal stage, audience, and available environment
- Script exact AI agent prompts with constraints, fallbacks, and business value hooks
- Navigate 30+ pre-built enterprise demo repos by vertical and pick the right one instantly
- Run competitive positioning live — Sitecore, Contentful, Optimizely, WordPress VIP, Vercel
- Counter "Optimizely is #1 in Gartner" or "Midjourney is good enough" with data
- Select and set up the right environment (Showcase vs Trial vs Playground vs Customer Org)
- Build a custom demo site from scratch using the right boilerplate and EDS dev skills
- Push content programmatically via MCP tools without ever opening da.live
- Bridge DA vs Universal Editor authoring for any audience, any use case
- Quote the $1.9B Semrush acquisition, the Firefly indemnification play, and the Volvo 60→100 stat cold

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

### Competitive RFP — Three-Way Bake-Off

```
We are in a 3-way bake-off: Adobe vs Sitecore vs Contentful.
The customer is a global pharma company — marketing + IT both in the room.
Deal stage: technical validation. They want a 60-minute deep-dive.
I have access to my XSC Showcase. What is my full demo strategy?
```

The skill builds a complete demo brief, selects the right plays (EDS performance + AI Agents + CSC),
routes to the exact competitive counters for both Sitecore AND Contentful, flags every environment
constraint, and outputs a scripted 60-minute narrative arc with exact agent prompts.

---

### Skeptical IT Architect — The Honest AI Agent Breakdown

```
The customer IT architect said: "These AI agents sound like marketing.
What do they actually do, what infrastructure do they require, and what breaks in a trial?"
Give me the full honest technical answer.
```

The skill walks through every agent (COA, EPA, Governance, Developer, Content Advisor),
maps each to its exact infrastructure requirement, flags what is broken in trial orgs vs Showcase,
and frames the limitations as proof points — "we tell you this because we want your pilot to succeed."

---

### LLMO — Customer Asking About AI Search Traffic Loss

```
The customer said: "We are seeing our organic traffic drop because ChatGPT is
answering questions that used to send people to our site. What does Adobe do about this?"
Script me a 20-minute LLMO demo. They have never heard of GEO.
```

Opens with the AI citation problem, walks through the LLMO "Optimize at Edge" mechanism,
uses the external-safe play.llmo.now demo URL, cites the adobe.com customer zero stats
(traffic indexed, structured data automatically enriched, CDN-level delivery),
and closes with the Semrush $1.9B acquisition as proof Adobe is making the biggest
bet in the market on this being the future of SEO.

---

### Build a Custom Healthcare POC Before Tomorrow

```
I have a discovery call tomorrow with a health system — CMO + digital VP.
I want to show a custom demo with their industry look and feel, DA authoring,
and the AI content optimization agent workflow. What do I build and how?
```

Checks AdobeDevXSC for existing healthcare repos (blue-shield-ca, hillrom-baxter, stryker),
picks ise-boilerplate for DA + UE dual authoring, routes to content-driven-development
and building-blocks skills, maps the full build sequence, and flags the one constraint:
"Content Advisor Agent needs approval workflow configured in Showcase — not possible in trial."

---

### Pre-Demo Crisis: 30 Minutes to Call Time

```
I am running ASO on the customer URL and getting zero issues found on everything.
The call is in 30 minutes. What is wrong and how do I fix it fast?
```

Routes to the environment-matrix troubleshooting guide, identifies the most likely causes
(URL behind auth wall, CDN caching clean state, wrong URL format),
gives the fastest fallback sequence (switch to Frescopa demo URL in under 5 minutes),
and has a backup narrative ready: "Let me show you what this looks like on a site
we already analyzed — then we will run yours in the trial."

---

### ExMod Migration Demo — Sitecore Customer, 4,000 Pages

```
The customer is on Sitecore 9 with roughly 4,000 pages.
They want to see what AEM migration actually looks like end to end.
Script the Experience Modernization demo from site analysis to first deployed page.
```

Pulls the full ExMod script including the Site Scope Analyzer at
main--site-scope--aemsites.aem.live, walks the three-phase story
(analyze with AI → generate EDS blocks → validate and publish),
gives exact prompts for the aemcoder.adobe.io demo session,
and includes the line that always lands:
"The AI does not just help migrate — it writes the block code. Your developers review, not author."

---

### Push Demo Content via MCP Before a Call

```
I need to update the hero headline and two product pages on my demo site
at main--refdemo--adobe-demopoc.aem.live before a call in 90 minutes.
Use the MCP tools to make the changes without me touching da.live.
```

Uses hlx-admin-mcp da_write to write content + trigger preview + publish in one call.
No browser, no Sidekick click. Reads the MCP tool reference for the exact call sequence,
handles auth via da_login if the token has expired, and confirms with da_whoami.
The demo is ready before you finish your coffee.

---

### Firefly Objection — "We Already Use Midjourney"

```
The customer said: "We are already using Midjourney for all our image generation.
Why would we switch to Firefly?" How do I respond?
```

Leads with the commercial indemnification angle: Adobe absorbs the legal liability
for every Firefly-generated image. With Midjourney, that liability sits with your company.
Adds the workflow integration story (Firefly inside Express, GenStudio, and AEM —
not a separate tab you switch to). Closes with the question that stops the conversation:
"Has your legal team reviewed your Midjourney commercial use policy?"

---

### CSC Deal — CMO Wants the Full Content Supply Chain

```
This is a Content Supply Chain deal. The CMO wants to see how AEM, Workfront,
and Firefly work together from campaign brief to published content to measurement.
45-minute executive demo. Script it.
```

Builds the full arc: campaign brief in Workfront → content generation in Firefly/Express →
review and approval workflow → publish via AEM → measurement in Analytics.
Assigns each product its supporting role, not a feature tour.
AEM is the anchor, Workfront is the orchestrator, Firefly is the content engine.
Closes with the ROI story: content cycle from 3 weeks to 3 days.

---

### Gartner MQ Objection — "Optimizely Is Number One"

```
The prospect said: "Optimizely was rated number one in the Gartner DXP Magic Quadrant.
Why would we choose Adobe?" What do I say?
```

Pulls the full Gartner 2025 counter-narrative: Adobe is number two but has been a
consecutive Leader for 8 years. The MQ scores narrow DXP capability — it does not
measure Lighthouse 100 by architecture, LLMO for AI search, the Semrush acquisition,
or Firefly indemnification. Then pivots: "Gartner measures where the market is today.
The question for you is where your content strategy needs to be in 2027."

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
