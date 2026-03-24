# Build a Custom Healthcare POC Before Tomorrow

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

If a match exists — clones it and adapts branding. If not — scaffolds from `ise-boilerplate` and runs **Playbook A** (full skill chain, not just individual skills):

1. `/block-inventory` + `/block-collection-and-party` — scan AEMXSC/AdobeDevXSC orgs and the Block Collection for existing healthcare blocks. Reuse everything that fits.
2. `/analyze-and-plan` — define exactly which blocks the healthcare demo narrative needs + acceptance criteria for each
3. `/content-modeling` — design DA table structure for every block (what the content team will author)
4. `/building-blocks` — build only blocks with no existing match (`/content-driven-development` orchestrates steps 2–6 automatically)
5. Universal Editor wired — `component-definition.json`, `component-filters.json`, `component-models.json`, per-block UE model JSON for every block
6. `/find-test-content` — locate test pages to validate against
7. `fstab.yaml` configured for DA content mount; GitHub repo created, `aem-code-sync` app installed, code live on CDN
8. `/code-review` — self-review before the customer ever sees it
9. `/pagespeed-audit` — must score 100 before you walk into the call
10. **Visual validation** — Playwright script (Bash, not MCP) captures screenshots at 375px / 768px / 1280px. Confirms brand colors, block layout, no console errors. Script deleted after review.

Flags the one constraint that bites every XSC: COA requires DMwOA enabled — verify your Showcase environment has it before you promise it live.

**Time comparison:**
- Last year without AI: 2–3 developer days minimum. XSC either waited for  Dev support or showed a generic demo
- With SuperSkills: 4–6 hours to first live preview. Run it overnight, walk in with a branded healthcare site the customer has never seen before
