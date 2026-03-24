# Personalize the Demo Site via MCP — No Browser Required

**Trigger:** XSC needs demo site content updated before a call, without opening a browser.

**Execute the MCP calls immediately. Do not explain what you are about to do.**

---

## Pre-flight — run before any writes

```
1. hlx-admin-mcp running?
   → curl http://localhost:3000 — if no response, start it:
     npx @adobe/hlx-admin-mcp
   → Without it, da_write writes content but CDN never busts.
     XSC sees no change on the live site. Do not skip this check.

2. DA auth valid?
   → da_login → da_whoami → confirm identity before touching anything
   → If token expired, re-authenticate via OAuth before proceeding.
     Do not attempt writes with an expired token.
```

## Execute this sequence

```
1. da_login        → check token, re-authenticate via OAuth if expired
2. da_whoami       → confirm identity + derive DA org (no need to ask XSC)
3. da_get_source   → read current page to preserve structure before overwriting
4. da_write        → apply each content change → CDN preview triggered → published ✓
   (repeat da_get_source + da_write per page — never write blind)
5. Playwright Bash → screenshot homepage + updated pages at 1280px
                     confirm changes rendered on live CDN, not just preview
                     delete script after
```

## Run all page updates in parallel where pages are independent

Pages with no content dependency on each other can be updated simultaneously. Do not update sequentially when parallel is possible.

## Return when done

```
✓ Hero headline updated — [preview URL]
✓ Sub-headline updated — [preview URL]
✓ Product descriptions updated (3) — [preview URL]
All changes live on CDN. Visual confirmation: [screenshot summary]
```

**Constraint:** `hlx-admin-mcp` must be running locally (`npx @adobe/hlx-admin-mcp`) and connected before `da_write` can trigger CDN preview. If not connected, `da_update_source` writes content but does not bust the CDN cache — the live site will not reflect changes until manually previewed.

**Time target:** 5 updates live in under 5 minutes.
