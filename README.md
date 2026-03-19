# AEM XSC Super Soldier Skill Pack

> Turn any XSC into a Captain America-level AEM technical presales hero.
> Works in Claude, GitHub Copilot, Gemini, Cursor, Windsurf, or any AI assistant.

---

## What Is This?

A portable, LLM-agnostic skill package that encodes everything a senior AEM XSC knows:
- Every demo play (ASO, AI Agents, LLMO, CSC, EDS, DMwOA, ExMod)
- Every environment constraint (what breaks in trial vs. sandbox vs. showcase)
- Every competitive angle (Sitecore, Contentful, Optimizely, WordPress, Drupal, Vercel)
- Every repo in the AdobeDevXSC / AEMXSC / adobe-demopoc org
- Every MCP tool, EDS dev skill, and authoring mode
- A full 4-stage demo lifecycle with output templates

Drop it into your AI assistant of choice. From that point on, when you ask "how do I demo AI agents to a healthcare CIO?" or "what do I say when they ask about Optimizely?" — your AI knows.

---

## File Structure

```
aem-xsc/
├── README.md               ← You are here. Install guide + contribution guide.
├── SKILL.md                ← Master orchestrator. Load this file first (or only this file).
│                             Contains: persona, routing tables, Demo Brief template,
│                             DA vs UE guide, quick reference plays, top 5 differentiators,
│                             instant demo URLs.
│
├── demo-plays.md           ← Full demo scripts + exact AI prompts
│                             Covers: ExMod, ASO, COA, EPA, Governance Agent,
│                             Developer Agent, Content Advisor Agent, LLMO, CSC, EDS, DMwOA,
│                             Cross-play objection handling
│
├── environment-matrix.md   ← What works where
│                             Covers: capability × environment grid, pre-demo setup checklist,
│                             9 failure modes + fixes, decision flowchart
│
├── tech-depth.md           ← Repos, build mode, MCP tools, EDS dev skills
│                             Covers: which boilerplate to use, AEMXSC org repos,
│                             AdobeDevXSC vertical demo library (30+ brands),
│                             all 17 EDS dev skills bridged to XSC use cases,
│                             DA + UE dual authoring setup, MCP tool reference,
│                             CLI tools, aem.live docs, GitHub apps, AI coding tools
│
└── competitive-intel.md    ← Win the room when competitors come up
                              Covers: Top 5 differentiators, Gartner 2025 MQ counter-narrative,
                              full breakdowns vs. Sitecore/Contentful/Optimizely/WP VIP/Drupal/Vercel,
                              ASO vs BrightEdge/Conductor/Semrush ($1.9B acquisition),
                              LLMO first-mover advantage, Firefly indemnification play,
                              win/loss patterns, 20+ quick-fire stats with sources
```

---

## Install in 60 Seconds

### Claude Code (this repo)
The skill is already installed. Invoke with:
```
/aem-xsc
```
Or just reference it in any prompt: *"Using the aem-xsc skill, design a demo plan for..."*

### Claude Code (another machine / new XSC)
```bash
# 1. Clone or download the aem-xsc/ folder
# 2. Drop it into your Claude skills directory
cp -r aem-xsc/ ~/.claude/skills/

# 3. For project-level install (shared with team via git)
cp -r aem-xsc/ /your-project/.agents/skills/
```
Skills are auto-discovered. Invoke with `/aem-xsc`.

### GitHub Copilot (VS Code)
```
# Add to your workspace instructions (.github/copilot-instructions.md):
@workspace Read .agents/skills/aem-xsc/SKILL.md and act as an AEM XSC for this session.
```
Or use Copilot Chat custom instructions to paste SKILL.md as your system prompt addition.

### Cursor / Windsurf / Cody
1. Open **Rules** or **System Prompt** settings
2. Paste the contents of `SKILL.md`
3. For deeper topics (demo scripts, competitive), reference the companion files: *"Read demo-plays.md and give me the ASO script"*

### Gemini / ChatGPT / Other
1. Start a new conversation
2. Paste `SKILL.md` content as your first message with: *"Here are my working instructions for this session:"*
3. When you need deep scripts or competitive details, paste the relevant companion file

### Agentic / n8n / Make / API
Reference `SKILL.md` as a system prompt in your AI node. The file is self-contained and works without any tool-calling — pure markdown reasoning.

---

## Example Use Cases

Copy these prompts directly into your AI assistant:

**Design a demo plan:**
```
Design a 30-minute demo plan for a mid-market insurance company (IT architect + marketing director).
Deal stage: competitive RFP vs. Sitecore. I have access to my XSC Showcase environment.
```

**Get a script:**
```
Give me the full LLMO demo script. The customer is a B2B tech company asking
"why should we care about AI search optimization?"
```

**Handle an objection:**
```
The prospect just said "Optimizely was rated #1 in the Gartner MQ. Why would we choose Adobe?"
What do I say?
```

**Pick an environment:**
```
I want to show the Developer Agent and EPA to a technical architect.
What environment do I use and what are the constraints?
```

**Build a custom demo:**
```
I need a custom demo site for a luxury apparel brand. They want to see DA authoring
and the AI image variant workflow. What repo do I start from and what blocks do I build?
```

**Prep for a call:**
```
I have a 60-minute technical deep-dive with a financial services architect tomorrow.
Walk me through the pre-demo checklist and the right environment setup.
```

---

## How to Update This Skill

**The golden rule:** Each file has a clear scope. Add to the right file.

| If you want to add... | Edit this file |
|---|---|
| A new demo script or AI prompt | `demo-plays.md` |
| Environment constraint / capability flag | `environment-matrix.md` |
| A new repo, boilerplate, or build pattern | `tech-depth.md` |
| A competitive fact, stat, or objection response | `competitive-intel.md` |
| A new routing entry / demo play category | `SKILL.md` (Intent Detection table) |
| A new instant demo URL | `SKILL.md` (Instant Demo URLs table) |

### Contribution Steps

1. **Fork or branch** the repo
2. **Edit the relevant file** — files use plain markdown, no special syntax
3. **Mark outdated content** with `⚠ LEGACY:` prefix rather than deleting, unless you're sure it's gone
4. **Add your name or a date comment** if the change is time-sensitive: `<!-- Updated: 2026-03 -->`
5. **Submit a PR** with a one-line description of what changed and why

### What Makes a Good Update

- **Verified in a real demo** — if you ran the script and it worked (or broke), document it
- **Concrete** — "ASO shows top 10 issues for Frescopa" beats "ASO shows issues"
- **Current** — flag anything that might expire (beta features, pricing, release dates)
- **Source it** — for competitive stats, include where you got the number

### Naming Conventions

- Section headers use `##` and `###`
- Demo scripts use the standard format: `Scenario → Step → Result → Value → Constraint`
- Tables preferred over bullet lists for lookup content
- Use `⚠` for guardrails, `→` for routing, `✅/❌/⚠` for capability matrix

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

Open an issue in this repo or ping the XSC team directly. If a demo play worked especially well or a competitive response landed, add it here so the whole team benefits.

---

## LLM Plugin Support

This repo includes native plugin/integration files for every major AI assistant — no manual setup required.

| AI Assistant | Plugin File | How It Works |
|---|---|---|
| **Claude Code** | `.claude-plugin/plugin.json` | Auto-discovered by Claude Code. Install with `npx skills add https://github.com/AEMXSC/SuperSkills` |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Auto-loaded in any repo that clones SuperSkills. Activates XSC persona in Copilot Chat. |
| **Cursor** | `.cursor/rules` | Auto-applied as Cursor rules when you open this folder. |
| **Windsurf** | `.windsurfrules` | Auto-applied as Windsurf rules when you open this folder. |
| **Gemini / ChatGPT** | `SKILL.md` | Paste content as system prompt. No plugin format yet — SKILL.md is the install. |

### Install via Claude Code skills CLI
```bash
npx skills add https://github.com/AEMXSC/SuperSkills
```

### Clone and open (Cursor / Windsurf / Copilot)
```bash
git clone https://github.com/AEMXSC/SuperSkills
# Open the folder — rules activate automatically
```
