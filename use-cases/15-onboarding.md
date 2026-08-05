# New XSC Onboarding — Claude Code + Adobe MCP Environment Setup

**This is a REFERENCE scenario — not a customer demo. It onboards a new (or returning) XSC's own machine: Claude Code, Adobe MCP connectors, GitHub, and local AEM EDS dev tooling.**

```
I'm a new AEM XSC. Walk me through getting my Claude Code environment set up
for demo work — GitHub free org, Adobe MCP connectors, DA content root, and
local AEM EDS dev server. Then give me a readiness checklist.
```

Hand this file to anyone joining the XSC team. It's a mix of **UI steps** (do these in
claude.ai or your browser) and **paste-in prompts** (copy the block into Claude Code
and let it inspect and fix your own machine). Read §0 first — most of day-one is
hosted (Modernization Agent console + DA), so local dev tooling (§3) can wait until
you actually need it.

> Legend: 🖥️ = do it in a UI · 💬 = paste this prompt into Claude Code

---

## 0. Prereqs (🖥️ + 💬)

To get started you only need: **Claude Code installed** and an **Adobe account** with
access to the internal Claude connectors. Most of the day-one workflow is hosted
(Modernization Agent console + DA) — you don't need a local dev toolchain yet.
(Node comes later, in §3, only if you develop locally.)

**💬 Verify the basics — paste into Claude Code:**

```
Confirm my setup for AEM Edge Delivery onboarding and report a short table:
- Claude Code is working and which model/effort level I'm on
- git is installed (version)
- whether I'm currently inside a git repo
Tell me anything missing and the exact command to fix it.
```

---

## 1. Connect the Adobe MCP connectors (🖥️)

These are **not** set up with a prompt or `claude mcp add`. They are claude.ai
connectors authorized through Adobe SSO.

1. Go to **claude.ai → Settings → Connectors**.
2. Enable the ones you need and complete the Adobe SSO / OAuth flow for each:
   - **AEM DA (Document Authoring)** — read/write EDS content
   - **AEM Content / AEM Odin** (Dev / Stage / Prod) — AEM pages & fragments
   - **Adobe Analytics**, **Customer Journey Analytics (CJA)**, **Real-Time CDP**
   - **Adobe Target**, **Adobe Journey Optimizer (AJO)**, **Workfront**
   - **Firefly**, **Frame.io**, **Adobe Express**, **Acrobat**
   - **Slack** (for team hand-offs)
3. Back in Claude Code, confirm they're live:

**💬**
```
List the MCP servers/connectors currently available to you and mark which are
authenticated vs. still need auth. Group them by area (AEM authoring, AEM content,
analytics, creative, collaboration).
```

> If a connector shows "needs auth," finish its OAuth in claude.ai Connectors —
> Claude Code can't run that login flow itself.

---

## 2. GitHub setup (🖥️)

Every EDS site is a GitHub repo wired to **Code Sync / Code Connector**. Do this
before local dev — the repo has to exist first.

### 2a. GitHub account + your free org
1. Go to **github.com → Sign up** with your **Adobe email**; verify via the code
   GitHub emails you.
2. Avatar menu → **Organizations → New organization → Free** plan.
3. **Name the org `<username>-adobe`** (e.g. `ynaka-adobe`). This naming matters — it
   becomes the `{org}` in every preview URL.
4. Make sure your **Adobe email is in the org's contact email** — the EDS admin picks
   this up for provisioning.

> This free-org step is also the fix for the **DA admin privilege error**
> ("you do not have privileges to…"): creating a repo under your own `-adobe` org
> retroactively fixes existing repos.

### 2b. Create the customer repo from the demo template
Use **`ynaka-adobe/da-demo-kit`** — the template with demo functionality already
merged in (Target integration, Workfront integration, Send-to-Workfront for
approval/publish), so you can recreate the standard demos.

1. Open **https://github.com/ynaka-adobe/da-demo-kit**.
2. **Use this template → Create a new repository.**
3. Repository name = the **customer / site name**.
4. Owner = **your personal `-adobe` org**.
5. Visibility = **Public**.

> `author-kit`, `aem-boilerplate`, and `da-block-collection` are the generic
> alternatives — explore those *after* you're comfortable with GitHub, the DA content
> repo, and the Modernization Agent.

### 2c. Install AEM Code Sync + Code Connector
1. Open **https://github.com/apps/aem-code-sync → Configure**.
2. Select your **personal `-adobe` org**.
3. **Only select repositories** — pick the repo you just created — **Install & Authorize**.
   (This installs the code repo + the Edge Delivery microservices that do what the AEM
   Publish server used to.)
4. **Run Code Connector, then Code Sync** against the repo. Code Connector lets AI
   agents interact with your code + content repos; Code Sync attaches event listeners
   between them. Read the confirmation email carefully.

### 2d. Create the DA content root
1. Go to **https://da.live/start** (preferred wizard). (Manual root/delete: `https://da.live/#/{org}`.)
2. Enter your newly created repo — create the **DA Demo Kit** sample content library.
3. When prompted for the sample set, **select "AEM Block Collection" or "None" — do
   NOT select Author Kit** (you're on the da-demo-kit template).

### 2e. Open the Modernization Agent
Open **https://aemcoder.adobe.io/** — first-time users get a GitHub repo-connection
popup; returning users can reset the workspace (code/content connection + chat
history) in Settings.

> **Branch = environment.** Preview URL construct:
> `{branch}--{repo}--{org}.aem.page` — where `{org}` is your `<username>-adobe` org
> (e.g. `main--chevron--ynaka-adobe.aem.page`). Preview is always viewable; **publish
> is separate** — use the **Traverse** app to list URLs, then paste into **Bulk
> Operations** to publish.

---

## 3. Local EDS dev server (💬) — *only if you develop locally*

Skip this if you work entirely in the hosted Modernization Agent console + DA. You
need a local dev server only when you clone the repo and want to preview/edit code
on your machine.

**Prereq for this section: Node 20.x + the `aem` CLI.** These power `aem up`, which
serves the site at `localhost:3000` (content pulled from the preview, code from your
checked-out git branch).

**💬 Check/install the local toolchain — paste into Claude Code:**
```
I want to do local AEM Edge Delivery development. Report a table:
- node version (I want v20.x via nvm) and where it resolves from
- whether the `aem` CLI is installed and its version
For anything missing, give me the exact install command (nvm install 20,
npm install -g @adobe/aem-cli).
```

**💬 Create the launch config for a project:**
```
Create a .claude/launch.json in this project that starts the AEM Edge Delivery
dev server. Use my nvm node v20 to run `aem up` on port 3000. Then start it and
open the preview so I can confirm the site renders.
```

This produces the same `launch.json` we use across customer repos, e.g.:

```json
{
  "version": "0.0.1",
  "configurations": [
    { "name": "aem-up",
      "runtimeExecutable": "<path-to>/node",
      "runtimeArgs": ["<path-to>/aem", "up"],
      "port": 3000 }
  ]
}
```

---

## 4. Skills worth knowing (💬)

Skills ship with the official marketplace and Adobe plugins, plus this SuperSkills
pack. Point people at the ones we actually use:

- **`/aem-xsc`** — this skill pack, loaded via SKILL.md — demo plans, competitive intel, tech-depth
- **`/tps-opp-report`** — Tech Driver / Product Assessment reports for AEM opps
- **`adobe-security-suite`** — auto-applies secure-coding rules when building blocks/apps
- **`/dataviz`** — charts & dashboards for demos
- **`/run`** — launch and screenshot the app to prove a change works
- **`/init`** — generate a CLAUDE.md for a customer repo

**💬 Discover what's available to you:**
```
List the skills available to me with a one-line description of each, and highlight
which are most useful for AEM Edge Delivery demo work and TPS opportunity reports.
```

**💬 Try the TPS report skill:**
```
/tps-opp-report
Generate both a Tech Driver Report and Product Assessment for opportunity <DR number>,
customer <name>.
```

---

## 5. Reduce permission prompts (💬)

New users get prompted a lot until they allowlist common tools. Do this per-project
so it stays scoped.

**💬**
```
Set up this project's .claude/settings.local.json to allowlist the tools I use most
for AEM EDS work, so I stop getting repeat permission prompts. Include the AEM DA
MCP read/write tools, the local preview server, Claude-in-Chrome navigation, and the
EDS markdown fetch/classify tools. Show me the final file before writing it.
```

> There's also a `/fewer-permission-prompts` skill that scans your history and
> proposes an allowlist automatically.

---

## 6. Per-customer repo setup (💬)

When you clone or open a new customer EDS repo:

**💬**
```
This is a new AEM Edge Delivery customer repo. Do the following:
1. Run /init to create a CLAUDE.md describing the block structure and conventions.
2. Create .claude/launch.json to run `aem up` on port 3000.
3. Start the dev server and confirm the homepage renders, then screenshot it.
Report what you set up.
```

---

## 7. Sanity check the whole setup (💬)

**💬 Final verification — paste this last:**
```
Give me a readiness checklist for AEM Edge Delivery demo work and mark each ✅/❌:
- Claude Code working + git installed
- GitHub free org named `<username>-adobe` with my Adobe email on the contact
- customer repo created from `ynaka-adobe/da-demo-kit`
- AEM Code Sync installed on that repo; Code Connector + Code Sync run
- DA content root created via da.live/start (DA Demo Kit; Block Collection or None)
- AEM DA connector authenticated
- AEM Content/Odin connector authenticated
- Analytics / CJA / Target connectors authenticated (note which)
- (local dev only) node v20 + aem CLI present and `aem up` runs on :3000
- key skills available (tps-opp-report, adobe-security-suite, dataviz, run)
For every ❌, give me the exact next step (UI or command).
```

### Day-one priority

Ten items on the checklist, but four gate everything else — get **1, 2, 6, 9** working
first, then circle back to the rest once you're building something real:

| # | Item | Why it's day-one |
|---|---|---|
| 1 | Claude Code working + git installed | Nothing else in this file works without it |
| 2 | GitHub free org `<username>-adobe` | Every customer repo, preview URL, and Code Sync install depends on this existing |
| 6 | AEM DA connector authenticated | No DA MCP tools (`da_list_sources`, `da_update_source`, …) show up in-session without it |
| 9 | Local node v20 + `aem` CLI | Only needed if you develop locally — but when you do, a wrong active Node version (v22/v24 instead of v20) is the #1 silent `aem up` failure |

Items 4, 5, 7, 8 are per-repo or per-connector and can't be verified in general —
confirm them the first time you actually touch a specific customer repo or need that
specific analytics connector.

---

## Quick reference — what lives where

| Thing | Where it's configured |
|---|---|
| GitHub org | Free org named `<username>-adobe` (Adobe email on contact) |
| Customer repo | From template `ynaka-adobe/da-demo-kit` (Target + Workfront) |
| Code wiring | AEM Code Sync app + Code Connector / Code Sync on the repo |
| Content root | `https://da.live/start` — DA Demo Kit (Block Collection / None) |
| Preview URL | `{branch}--{repo}--{org}.aem.page` (org = `<username>-adobe`) |
| Modernization Agent console | https://aemcoder.adobe.io/ |
| Adobe MCP connectors | claude.ai → Settings → Connectors (OAuth via Adobe SSO) |
| Global permissions / effort level | `~/.claude/settings.json` |
| Per-project permissions | `<repo>/.claude/settings.local.json` |
| Local dev (optional) | Node 20 + `aem` CLI — `aem up` on :3000 (`.claude/launch.json`) |
| Plugin marketplace | `anthropics/claude-plugins-official` |
| Skills | official marketplace + Adobe plugins + this SuperSkills pack |
