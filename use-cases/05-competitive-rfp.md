# Competitive RFP — Three-Way Bake-Off

**Trigger:** XSC is in a multi-vendor bake-off and needs a full demo strategy and scripted arc.

**Output the complete demo brief and 60-minute script immediately. Do not preface.**

---

## Demo Brief

```
Objective: Win technical validation against competitors for [customer vertical]
Audience: Marketing leader + IT architect — address both simultaneously
Deal stage: Technical validation
Environment: XSC Showcase (required for AI Agents + CSC)
Plays: EDS performance + AI Agents + CSC
Time: 60 minutes
Custom build: No — run from XSC Showcase
```

## Competitive positioning — run both simultaneously

**vs Sitecore** — lead with performance architecture:
- Lighthouse 100 by structure, not tuning. Volvo: 60→100.
- *"Sitecore requires ongoing performance effort. EDS delivers 100 by default."*
- Developer Agent: AI-assisted deployment with Cloud Manager guardrails

**vs Contentful** — lead with unified platform:
- Contentful is API-first headless only. Adobe is headless + visual + edge-delivered.
- One data model: AEP + Analytics + Target + AEM. Contentful has no analytics layer.
- *"Contentful gives you flexibility. Adobe gives you the system those flexible pieces plug into."*

**Both competitors** — close with LLMO:
- Neither has an AI search optimization layer.
- $1.9B Semrush acquisition (H1 2026): *"Adobe is the only vendor building traditional SEO + AI SEO + CMS as one platform."*

## 60-minute narrative arc

**0–10 min — Speed story (EDS)**
Run PageSpeed on their site live. Show the gap. Show Lighthouse 100 on Showcase. Architecture, not tuning.

**10–30 min — AI Agents**
- COA: image variants in 2 minutes, Firefly-indemnified — *"Has your legal team cleared your current AI image tools?"*
- EPA: multi-page content transformation on Author URL
- Governance: one rule, one violation caught — compliance story for pharma

**30–50 min — CSC cross-solution**
Campaign brief → GenStudio → Firefly variants → AEM publish → Analytics closes the loop.
*"This is the only platform where the brief and the measurement live in the same data model."*

**50–60 min — Proof path**
LLMO trial ($0) → EDS pilot → full CSC engagement.
Leave-behind: ASO issues report on their actual site.

## Environment constraints — verify before the call

- COA: DMwOA must be enabled in Showcase — check manifest
- GenStudio: Firefly-enabled Showcase sandbox — confirm with SE
- EPA: Author URL only — never demo on Publish URL
- LLMO external: `play.llmo.now` only, never share Showcase URL externally
