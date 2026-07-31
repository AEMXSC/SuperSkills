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

DA is not a replacement for SharePoint or Google Docs. It is the authoring layer Adobe built specifically for EDS customers who need enterprise content governance without legacy CMS complexity.

The positioning statement that lands in executive rooms:

> "DA merges the simplicity of document-based authoring with the power of Adobe Experience Manager. It is the fastest CMS on the planet — built on edge infrastructure, authenticated with Adobe Identity, and designed so authors publish content without ever touching a developer."

Three things that matter when you say this:
- **"Fastest CMS on the planet"** — backed by the 1,000 documents/minute API throughput benchmark. Use it.
- **"Built on edge infrastructure"** — DA runs on Cloudflare Workers and R2 storage, the same infrastructure as EDS itself. No separate system to fail.
- **"Authors publish without touching a developer"** — this is the CMO's dream and the IT team's nightmare made safe. Sidekick handles preview and publish from inside the editor.

---

## The Author Experience (What to Show in the Demo)

DA at `da.live` gives authors a browser-based rich text editor that produces the same document format as Google Docs and SharePoint — but purpose-built for EDS.

**Key moments to hit in a demo:**

1. **Open a page in the DA editor** — it looks like a clean word processor. No component tree, no JSON editor, no WYSIWYG canvas with invisible regions. Authors write text.

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

The key architectural truth that closes IT objections:

> "DA stores content in the same infrastructure as Edge Delivery Services. There is no separate CMS database. No additional cloud footprint. No migration path. Content is an edge-native artifact."

---

## DA vs SharePoint vs Google Docs — The Honest Comparison

This is the question that comes up in every EDS deal. Do not dodge it.

| | SharePoint | Google Docs | DA |
|---|---|---|---|
| Setup overhead | High (IT-managed, app permissions, site provisioning) | Low (shared drives, anyone can create) | Medium (GitHub repo + DA org setup) |
| Author UX | Word-like, familiar | Familiar, collaborative | Clean editor, purpose-built |
| Version history | SharePoint versioning | Google revisions | DA version API with audit trail |
| Real-time collab | Yes | Yes | Yes (Y.js CRDT) |
| Block authoring | Table-based (same format) | Table-based (same format) | Table-based (same format) |
| Fragments / reuse | Limited | Limited | Native fragment embedding |
| API access | Microsoft Graph API | Google Drive API | DA Admin REST API + MCP |
| AI agent authoring | Via Graph API | Via Workspace API | Via `da_write` MCP tool |
| Enterprise governance | SharePoint permissions | Google Workspace IAM | Adobe IMS + DA org config |
| AEM Assets integration | External link | External link | Native Assets Selector |
| Translation support | Manual | Manual | Google Translate + Smartling native |
| Licensing cost | Microsoft 365 | Google Workspace | Included with EDS — no extra cost |

**When to recommend DA over SharePoint/GDrive:**
- Customer wants unified Adobe identity across authoring and delivery
- AI agent authoring is part of the roadmap (MCP matters here)
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
- Universal Editor is the **in-context editor** — authors see the page as it renders and click to edit in place
- Both can author the same DA-stored content

The workflow: Author drafts in DA (fast, distraction-free), then opens Universal Editor to see the visual result and make layout adjustments. One content store, two editing surfaces, appropriate for different workflows and author personas.

**Always lead with DA + UE dual authoring unless the customer explicitly requires XWalk.** Per the team standard: pure DA with XWalk is for customers running existing Java delivery stacks or requiring MSM + in-context authoring. Everyone else defaults to DA.

---

## The MCP / AI Agent Angle

This is the differentiator in 2026 deals. DA exposes a full MCP server (`hlx-admin-mcp`) giving AI agents native write access to the authoring layer.

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

**What the MCP tools do:**

| Tool | What it does |
|---|---|
| `da_login` | Authenticates via Adobe IMS OAuth |
| `da_whoami` | Confirms identity before writes |
| `da_get_source` | Reads current document content (HTML) |
| `da_write` / `da_update_source` | Writes document → triggers CDN preview → publishes |
| `da_list_sources` | Lists all documents in a repo path |
| `da_get_versions` | Gets version history with timestamps |
| `da_copy_content` | Copies files or directories |
| `da_move_content` | Moves/renames files or directories |
| `da_create_source` | Creates new documents or folders |
| `da_delete_source` | Deletes documents or directories |
| `da_lookup_fragment` | Resolves fragment references |
| `da_upload_media` | Uploads images and media assets |

**The demo moment that wins AI-forward deals:**

> "This is the only CMS where I can say: 'Update all 47 product pages for the healthcare vertical, rewrite the hero headline for each one, and publish them before the 2pm call' — and an AI agent does it. Not a script. Not a bulk edit tool. A natural language prompt that understands context."

Pair this with use-case 08 (MCP content push) for the full execution demo.

---

## The Admin and Governance Story

For IT/legal/compliance stakeholders:

**Organization model**: DA uses an `org/repo` structure mapping directly to GitHub organizations and repositories. Each repo is a content namespace. Access is controlled at the org and repo level via Adobe IMS.

**Audit trail**: Every document write creates a version entry with timestamp and user identity. The `GET /versionlist/{org}/{repo}/{path}` API returns the full history. This is the compliance question answer.

**Configuration management**: The `GET|POST /config` endpoints handle org-level and repo-level configuration as sheet-formatted data — same authoring model as content.

**Content isolation**: DA content is stored in Cloudflare R2, separate from Microsoft, Google, and legacy AEM infrastructure. Customers control their own org namespace.

**Approval workflows**: Current approvals run through AEM Snapshots. Full multi-step approval (Workfront-integrated) is on the roadmap. For deals where approval workflow is a hard requirement today, position Snapshots as the bridge and Workfront integration as the 2026 milestone.

---

## Objection Handling

**"We already have SharePoint set up for EDS. Why change?"**

You do not have to. DA and SharePoint use the same document format — no migration needed, no code changes. The question is whether you want Adobe-native identity, fragment reuse, and MCP-based AI authoring. If those are not on your roadmap, keep SharePoint. If they are, DA is the path.

**"Is DA production-ready or is this still experimental?"**

DA is in production at EDS customers today. It runs on the same Cloudflare infrastructure as EDS delivery — 99.99% uptime SLA. It is included in the EDS license at no additional cost. The team is Adobe-staffed and partner-supported.

**"What about Google Docs workflows our content team prefers?"**

DA's editor is simpler and more purpose-built than Google Docs for web content. The learning curve is 30 minutes, not 30 days. Run a live author training session during the POC — it consistently removes the concern.

**"Does this replace AEM traditional authoring?"**

No. DA is a document-based authoring tool, not an SPA editor or WYSIWYG canvas editor. For customers who need component-level in-context authoring, Universal Editor layers on top of DA. For customers who need full AEM Sites-style authoring, XWalk is the path.

**"What happens to our content if we leave DA?"**

DA uses the same format as Google Docs and SharePoint for EDS. Content can move back to either platform. No vendor lock-in at the content layer.

---

## Demo Environment Checklist

Before any DA authoring demo:

- [ ] Confirm your `aem.live` org is set up — your GitHub org must be linked
- [ ] Verify the demo repo has content at `da.live/{org}/{repo}`
- [ ] Test `da_login` in Claude Code if showing MCP authoring
- [ ] Have the Sidekick extension installed and configured for preview/publish
- [ ] Prepare a fragment example — a shared block that appears on multiple pages
- [ ] Stage a versioning moment — make an edit, show the version history, restore a prior version

The strongest DA demo is 12 minutes: 4 minutes on the editor and blocks, 4 minutes on fragments and versioning, 4 minutes on Sidekick preview-to-publish. Close with the MCP prompt if the audience is technical or AI-forward.
