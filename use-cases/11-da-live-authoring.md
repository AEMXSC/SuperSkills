# DA (Document Authoring) — The Authoring Story That Closes EDS Deals

**This is a REFERENCE scenario — the skill provides expert positioning, demo guidance, and objection handling for DA authoring conversations.**

```
The customer keeps asking: "If we move from SharePoint to AEM EDS,
do our authors have to learn a completely new tool? And is it enterprise-ready?
We're not deploying something that's just a Google Docs clone."
Walk me through how to answer this and what to show them.
```

This is the question that stalls more EDS deals than any technical objection. The skill does not recite feature names. It reads the real concern — **authors will resist, IT will doubt, and the CMS team will ask why they should change** — and reframes DA as the answer to all three.

---

## What DA Actually Is (The XSC Framing)

DA is not a replacement for SharePoint or Google Docs. It is the authoring layer Adobe built specifically for EDS customers who need enterprise content governance without legacy CMS complexity — and in 2026 it is two authoring surfaces on one backend: the classic document editor (GA) and **Experience Workspace** (Early Access), the AI-native canvas where humans and agents author together.

The positioning statement that lands in executive rooms:

> "DA merges the simplicity of document-based authoring with the power of Adobe Experience Manager. It is the fastest CMS on the planet — built on edge infrastructure, authenticated with Adobe Identity, and designed so authors publish content without ever touching a developer. And with Experience Workspace, it becomes the hub where your authors and your AI agents build experiences together."

Three things that matter when you say this:
- **"Fastest CMS on the planet"** — backed by the 1,000 documents/minute API throughput benchmark. Use it.
- **"Built on edge infrastructure"** — DA runs on Cloudflare Workers and R2 storage, the same infrastructure as EDS itself. No separate system to fail.
- **"Authors publish without touching a developer"** — this is the CMO's dream and the IT team's nightmare made safe. Sidekick handles preview and publish from inside the editor.

---

## Experience Workspace — The Agentic Authoring Surface

> **Docs:** https://docs.da.live/about/early-access/experience-workspace
> **Status:** Early Access — opt-in via config flag. Features and APIs may change; confirm eligibility before demoing.

Experience Workspace is the intelligent authoring surface layered on the same DA backend: a WYSIWYG canvas with a built-in AI Assistant, where content from any origin — human authors, agents, LLM pipelines, AEM — is reviewed, collaborated on, approved, and deployed in one place. It replaces the classic DA editor as the front door for configured sites; the DA → EDS → CDN pipeline underneath is unchanged.

Adobe frames it as three pillars — use them as your demo arc:

| Pillar | What to show |
|---|---|
| **Authoring** | Visual WYSIWYG canvas, AI Assistant with prompts and skills, multi-user + agent collaboration, AEM Assets integration |
| **Intelligence** | Enterprise context (brand identity, marketing signals), author memory that learns over time, MCP/agents/skills connecting Adobe and third-party apps, optimization opportunities from site insights |
| **Operations** | Manage/publish/schedule/generate workflows, CMS skills management, MCP support for LLM pipelines, REST API for API-first access |

**How to enable it** (prerequisite: an EDS project with DA as content source, and Quick Edit implemented in the codebase):

1. Guided setup tool: `https://da.live/app/adobe-rnd/ew-extensions/tools/ew-setup/ew-setup` — the recommended path. Beyond flipping the flags, it also surfaces the AI agent in DA's **browse view**, so authors get the assistant at the file-tree level, not just inside the canvas.
2. Or manually, in the `flags` sheet at `https://da.live/config#/<org>/<site>` (site-level overrides org-level):

| Flag | Value | Effect |
|---|---|---|
| `ew.enabled` | `true` | Turns on Experience Workspace (off by default) |
| `ew.disableChat` | `true` | Disables the chat (on by default) |
| `ew.canvasDefaultView` | `layout` / `content` / `split` | Default canvas view |
| `ew.canvasDefaultPanel` | `outline` / `files` / library item (`blocks`, `templates`) | Default side panel |

3. Point Sidekick at the canvas via the Admin API (`https://admin.hlx.page/config/ORG/sites/SITE/sidekick.json`):

```json
"sidekick": {
  "editUrlPattern": "https://da.live/canvas#/{{org}}/{{site}}{{pathname}}"
}
```

**The demo moment:** open a page in the canvas, ask the AI Assistant to rewrite a section in brand voice, watch it land in the layout visually — then publish through the same Sidekick flow. Same pipeline, new surface. For AI-forward audiences this is the flagship moment; the classic editor is your GA fallback for conservative audiences.

---

## The Author Experience (What to Show in the Demo)

DA at `da.live` gives authors a browser-based editor that produces the same document format as Google Docs and SharePoint — but purpose-built for EDS.

**Key moments to hit in a demo:**

1. **Open a page in the DA editor** — it looks like a clean word processor. No component tree, no JSON editor. Authors write text. (If Experience Workspace is enabled, open the canvas instead and let the visual layout speak first.)

2. **Insert a block** — authors type a table, name the first cell with the block name (e.g. `Cards`), fill in the rows. That table becomes a rendered component on the live site. Show the before and after.

3. **Reference a fragment** — show how a shared content piece (a footer CTA, a legal disclaimer, a global hero) lives in one DA document and can be embedded across hundreds of pages. One edit, everywhere updated.

4. **Version history** — every save creates a version. Show the version list with timestamps and user names. This is the audit trail question IT always asks.

5. **Real-time collaboration** — two cursors in the same document simultaneously. If the customer is in a multi-author environment, open two browsers and show them editing the same page at the same time. This moment consistently lands.

6. **Sidekick preview + publish** — from inside the editor, one click to preview on the CDN, one more click to publish live. No ticketing system. No deployment pipeline. No developer approval.

---

## The Technical Stack (For the Architect Conversation)

When the IT architect asks how it works:

- **Storage**: Cloudflare R2 (object storage, edge-distributed)
- **Session/Auth**: Cloudflare KV + Adobe IMS (JWT bearer tokens)
- **API**: REST at `https://admin.da.live` — full CRUD for documents, sheets, and media
- **Collaboration**: Y.js CRDT-based real-time sync (same technology as Notion and Figma)
- **Rendering**: EDS Franklin pipeline — DA content serves the same `.plain.html` format as SharePoint content, so the delivery layer is identical
- **Identity**: Adobe IMS — authors log in with their Adobe ID, not a separate CMS login
- **Authoring surfaces**: classic DA editor (GA), Experience Workspace canvas (Early Access), Universal Editor (in-context) — all against the same content store

The key architectural truth that closes IT objections:

> "DA stores content in the same infrastructure as Edge Delivery Services. There is no separate CMS database. No additional cloud footprint. No migration path. Content is an edge-native artifact."

---

## DA vs SharePoint vs Google Docs — The Honest Comparison

This is the question that comes up in every EDS deal. Do not dodge it.

| | SharePoint | Google Docs | DA |
|---|---|---|---|
| Setup overhead | High (IT-managed, app permissions, site provisioning) | Low (shared drives, anyone can create) | Medium (GitHub repo + DA org setup) |
| Author UX | Word-like, familiar | Familiar, collaborative | Clean editor + Experience Workspace canvas |
| Version history | SharePoint versioning | Google revisions | DA version API with audit trail |
| Real-time collab | Yes | Yes | Yes (Y.js CRDT) |
| Block authoring | Table-based (same format) | Table-based (same format) | Table-based, or visual in Experience Workspace |
| Fragments / reuse | Limited | Limited | Native fragment embedding |
| API access | Microsoft Graph API | Google Drive API | DA Admin REST API + DA MCP |
| AI agent authoring | Via Graph API | Via Workspace API | Native — DA MCP tools + Experience Workspace AI Assistant |
| Enterprise governance | SharePoint permissions | Google Workspace IAM | Adobe IMS + DA org config |
| AEM Assets integration | External link | External link | Native Assets Selector |
| Translation support | Manual | Manual | Google Translate + Smartling native |
| Licensing cost | Microsoft 365 | Google Workspace | Included with EDS — no extra cost |

**When to recommend DA over SharePoint/GDrive:**
- Customer wants unified Adobe identity across authoring and delivery
- AI agent authoring is part of the roadmap (DA MCP + Experience Workspace matter here)
- Customer needs fragment-based reuse across hundreds of pages
- Customer has complex multi-site EDS deployments (MSM-like features in DA)

**When SharePoint/GDrive is still fine:**
- Customer already has strong SharePoint governance they are happy with
- Complex Excel formulas and 5,000+ row spreadsheets are in the content model
- Existing MSM + in-context UE workflow is already deployed on XWalk

---

## DA + Universal Editor — The Dual Authoring Story

DA is not mutually exclusive with Universal Editor. This is a critical demo moment for enterprise deals:

- DA is the **document editor** — authors write content in a browser-based word processor
- Experience Workspace is the **canvas editor** — authors work visually with an AI assistant on the same DA content
- Universal Editor is the **in-context editor** — authors see the page as it renders and click to edit in place
- All of them author the same DA-stored content

The workflow: Author drafts in DA or the Experience Workspace canvas (fast, AI-assisted), then opens Universal Editor to see the visual result and make layout adjustments. One content store, multiple editing surfaces, appropriate for different workflows and author personas.

**Always lead with DA + UE dual authoring unless the customer explicitly requires XWalk.** Per the team standard: pure DA with XWalk is for customers running existing Java delivery stacks or requiring MSM + in-context authoring. Everyone else defaults to DA.

---

## The MCP / AI Agent Angle

This is the differentiator in 2026 deals. Two MCP servers matter for DA, and they are not the same thing — know which is which before an architect asks.

> **Do not say "the only CMS with AI agent write access."** AEM as a Cloud Service has its own MCP servers (`aem-content`, `aem`) with fragment, page, launch and governance write access — see `tech-depth.md`. An architect who knows the portfolio will catch the overclaim, and you lose the room over a line you did not need.
>
> The accurate and stronger framing: **both** AEM authoring surfaces are agent-writable, and you pick by deal type.
>
> | Deal | Content store | MCP |
> |---|---|---|
> | EDS site, document authoring | DA (Cloudflare R2) | DA MCP + `hlx-admin-mcp` |
> | Cloud Service, Content Fragments / Sites | AEM CS | `aem-content` + `aem` |
>
> Competitors have neither. That is the real differentiator — say that instead.

### The official DA MCP (Adobe, Early Access)

> **Docs:** https://docs.da.live/about/early-access/da-mcp
> **Endpoint:** `https://mcp.adobeaemcloud.com/adobe/mcp/da` (streamable HTTP; Adobe IMS auth is automatic — no tokens)
> **Server-to-server:** `https://da-mcp.adobeaem.workers.dev/mcp` with an IMS Bearer token (Developer Console EDS credential + email added to the DA Config permission sheet)

10 tools, all source-level CRUD and lookups:

| Tool | What it does |
|---|---|
| `da_list_sources` | Lists documents/folders in an org/repo path |
| `da_get_source` | Reads current document content (HTML) |
| `da_create_source` | Creates new documents or folders |
| `da_update_source` | Updates an existing document in place |
| `da_delete_source` | Deletes documents or directories |
| `da_copy_content` | Copies files or directories |
| `da_move_content` | Moves/renames files or directories |
| `da_get_versions` | Gets version history with timestamps |
| `da_lookup_fragment` | Resolves fragment references |
| `da_lookup_media` | Looks up media asset references |

**Know the gap:** the DA MCP has **no preview or publish tools** — it writes to the source store only. A `da_update_source` write does not appear on the live `.aem.page` URL until preview/publish is triggered via Sidekick or the `admin.hlx.page` API.

### hlx-admin-mcp (closes the gap)

The companion server for demos where the write must be **visible on the live site**: its `da_write` tool does write → preview → publish in one call. `da_login` / `da_whoami` handle the `admin.hlx.page` OAuth. Rule of thumb: DA MCP for reads, bulk restructuring, and fine-grained control; `hlx-admin-mcp da_write` for any write the audience needs to see live. Details in `tech-depth.md`.

**The demo moment that wins AI-forward deals:**

> "Watch this: 'Update all 47 product pages for the healthcare vertical, rewrite the hero headline for each one, and publish them before the 2pm call' — and an AI agent does it against the same authoring layer your authors use. Not a script. Not a bulk edit tool. A natural language prompt that understands context — and your authors watch it land in their Experience Workspace canvas in real time."

Pair this with use-case 08 (MCP content push) for the full execution demo.

---

## The Admin and Governance Story

For IT/legal/compliance stakeholders:

**Organization model**: DA uses an `org/repo` structure mapping directly to GitHub organizations and repositories. Each repo is a content namespace. Access is controlled at the org and repo level via Adobe IMS.

**Audit trail**: Every document write creates a version entry with timestamp and user identity. The `GET /versionlist/{org}/{repo}/{path}` API returns the full history. This is the compliance question answer.

**Configuration management**: The `GET|POST /config` endpoints handle org-level and repo-level configuration as sheet-formatted data — same authoring model as content. Experience Workspace itself is enabled this way (`ew.enabled` in the flags sheet), which is a nice governance proof point: even the editor rollout is config-as-content, site-by-site.

**Content isolation**: DA content is stored in Cloudflare R2, separate from Microsoft, Google, and legacy AEM infrastructure. Customers control their own org namespace.

**Approval workflows**: Current approvals run through AEM Snapshots; Experience Workspace's Operations pillar adds manage/publish/schedule workflows as it matures. For deals where multi-step approval workflow is a hard requirement today, position Snapshots as the bridge and the Workfront integration roadmap as the milestone.

---

## Objection Handling

**"We already have SharePoint set up for EDS. Why change?"**

You do not have to. DA and SharePoint use the same document format — no migration needed, no code changes. The question is whether you want Adobe-native identity, fragment reuse, MCP-based AI authoring, and Experience Workspace's AI canvas. If those are not on your roadmap, keep SharePoint. If they are, DA is the path.

**"Is DA production-ready or is this still experimental?"**

The DA platform and classic editor are in production at EDS customers today, on the same Cloudflare infrastructure as EDS delivery — 99.99% uptime SLA, included in the EDS license at no additional cost. Be precise about maturity tiers: Experience Workspace and the DA MCP are Early Access — demo-ready and opt-in, but flag them as such. Honesty here buys credibility for the rest of the pitch.

**"What about Google Docs workflows our content team prefers?"**

DA's editor is simpler and more purpose-built than Google Docs for web content, and Experience Workspace gives authors a visual canvas with an AI assistant that Google Docs cannot match. The learning curve is 30 minutes, not 30 days. Run a live author training session during the POC — it consistently removes the concern.

**"Does this replace AEM traditional authoring?"**

No. DA is a document-based authoring tool; Experience Workspace adds a canvas surface on the same store. For customers who need component-level in-context authoring, Universal Editor layers on top of DA. For customers who need full AEM Sites-style authoring, XWalk is the path.

**"What happens to our content if we leave DA?"**

DA uses the same format as Google Docs and SharePoint for EDS. Content can move back to either platform. No vendor lock-in at the content layer.

---

## Demo Environment Checklist

Before any DA authoring demo:

- [ ] Confirm your `aem.live` org is set up — your GitHub org must be linked
- [ ] Verify the demo repo has content at `da.live/{org}/{repo}`
- [ ] If showing Experience Workspace: Quick Edit implemented in the site code, `ew.enabled=true` in the flags sheet at `da.live/config#/<org>/<site>`, Sidekick `editUrlPattern` pointed at `da.live/canvas#` — and confirm Early Access eligibility
- [ ] If showing MCP authoring: DA MCP connector added (IMS auth is automatic) and, for live-site writes, `hlx-admin-mcp` authenticated via `da_login`
- [ ] Have the Sidekick extension installed and configured for preview/publish
- [ ] Prepare a fragment example — a shared block that appears on multiple pages
- [ ] Stage a versioning moment — make an edit, show the version history, restore a prior version

The strongest DA demo is 12 minutes: 4 minutes on the editor and blocks (canvas-first if Experience Workspace is enabled), 4 minutes on fragments and versioning, 4 minutes on Sidekick preview-to-publish. Close with the AI Assistant or the MCP prompt if the audience is technical or AI-forward.
