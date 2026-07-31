#!/usr/bin/env bash
# ============================================================
# XSC YOLO Pre-flight — run this before closing your laptop
# Pass = go to sleep. Fail = fix it now.
# Usage: bash yolo-preflight.sh [url1 url2 url3 ...]
# ============================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
FAIL_COUNT=0; WARN_COUNT=0

ok()   { echo -e "${GREEN}✓${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; ((FAIL_COUNT++)); }
warn() { echo -e "${YELLOW}⚠${NC}  $1"; ((WARN_COUNT++)); }

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║        XSC YOLO Pre-flight Check                    ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# ── 1. GitHub auth ────────────────────────────────────────
echo "── Auth & Tooling ──"
if gh auth status &>/dev/null; then
  ok "GitHub auth valid"
else
  fail "GitHub auth expired — run: gh auth login"
fi

# ── 2. hlx-admin-mcp running ─────────────────────────────
if curl -s --max-time 3 http://localhost:3000 &>/dev/null; then
  ok "hlx-admin-mcp running on :3000"
else
  fail "hlx-admin-mcp not running — open a new terminal and run: npx @adobe/hlx-admin-mcp"
fi

# ── 3. DA MCP configured ─────────────────────────────────
if claude mcp list 2>/dev/null | grep -q "da"; then
  ok "DA MCP configured"
else
  fail "DA MCP not configured — run: claude mcp add da-mcp --transport http --url https://mcp.adobeaemcloud.com/adobe/mcp/da"
fi

# ── 3b. AEM Cloud Service MCP configured ─────────────────
if claude mcp list 2>/dev/null | grep -q "aem-content"; then
  ok "AEM Content MCP configured (Content Fragments, launches, pages)"
else
  warn "AEM Content MCP not configured — needed for use-cases 04/08/12/13/14. Run: claude mcp add aem-content --transport http --url https://mcp.adobeaemcloud.com/adobe/mcp/content"
fi

# ── 3c. Target author environment named ──────────────────
# Environment selection is the ONE decision the agent must not infer.
# See environment-matrix.md → "Environment selection".
if [ -n "$AEM_AUTHOR_URL" ]; then
  ok "Target author environment: $AEM_AUTHOR_URL"
  # NOTE: the tier (dev/stage/prod) is NOT derivable from the URL — author URLs
  # are opaque (author-p153659-e1614585). Only get-all-aem-author-environments
  # returns the `environment` field. This script cannot verify it; the agent must.
  warn "Tier not verifiable from the URL — author URLs are opaque. The agent MUST confirm via get-all-aem-author-environments before any write. If this resolves to a shared prod env, writes can break a colleague's demo."
else
  warn "AEM_AUTHOR_URL not set — the agent will auto-select a DEV tier via get-all-aem-author-environments, or stop if none qualifies. Export it now to be certain:  export AEM_AUTHOR_URL=https://author-<env>.adobeaemcloud.com"
fi

# ── 4. aem-code-sync app ─────────────────────────────────
if gh api /user/installations 2>/dev/null | grep -q "aem-code-sync"; then
  ok "aem-code-sync GitHub App installed"
else
  warn "Cannot confirm aem-code-sync — verify manually: github.com/apps/aem-code-sync"
fi

# ── 5. Playwright available ───────────────────────────────
if node -e "require('playwright')" 2>/dev/null; then
  ok "Playwright available"
else
  fail "Playwright not installed — run: npm install -g playwright && npx playwright install chromium"
fi

# ── 6. AEM CLI ────────────────────────────────────────────
if command -v aem &>/dev/null; then
  ok "AEM CLI available"
else
  warn "AEM CLI not found — install: npm install -g @adobe/aem-lib"
fi
echo ""

# ── 7. URL accessibility (if URLs passed as args) ─────────
if [ ${#@} -gt 0 ]; then
  echo "── Target URL checks ──"
  for url in "$@"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 -L "$url" 2>/dev/null || echo "000")
    case $status in
      200) ok "Accessible: $url" ;;
      401|403) fail "Auth wall (HTTP $status): $url — requires login, not importable overnight" ;;
      301|302) warn "Redirect: $url — verify final destination is correct" ;;
      000) fail "Unreachable: $url — check URL or network" ;;
      *) warn "HTTP $status: $url — verify this is expected" ;;
    esac
  done
  echo ""
fi

# ── 8. Result ─────────────────────────────────────────────
echo "────────────────────────────────────────────────────────"
if [ $FAIL_COUNT -gt 0 ]; then
  echo -e "${RED}✗ $FAIL_COUNT blocker(s) found — fix before going to sleep.${NC}"
  [ $WARN_COUNT -gt 0 ] && echo -e "${YELLOW}⚠ $WARN_COUNT warning(s) — review but not blocking.${NC}"
  echo ""
  echo "Re-run after fixing: bash yolo-preflight.sh"
  exit 1
else
  [ $WARN_COUNT -gt 0 ] && echo -e "${YELLOW}⚠ $WARN_COUNT warning(s) — review but not blocking.${NC}"
  echo -e "${GREEN}✓ All checks passed. YOLO mode is go. Close your laptop.${NC}"
  echo ""
  echo "The AI will build overnight. Check your wake-up report in the morning."
  exit 0
fi
