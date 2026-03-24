# Omni-Channel Content Activation — Content Fragments + GraphQL

**Trigger:** XSC needs a live headless demo showing one CF delivered to multiple channels via GraphQL.

**Execute immediately. Do not explain what you are about to do.**

---

## Step 1 — Build the Content Fragment model

Create the CF model schema with these fields:
- `headline` (single-line text)
- `body` (multi-line rich text)
- `cta` (single-line text)
- `channelOverrides` (nested fragment — per-channel tone variants)
- `complianceApproved` (boolean — blocks publish if false)

Write and commit the configuration files.

## Step 2 — Create 3 sample Content Fragments

One CF, three tone variants:
- **Patient-facing:** plain language, empathy-first, no clinical jargon
- **Clinical staff:** precise, abbreviated, protocol-aligned
- **Marketing/public site:** benefit-led, conversion-oriented

## Step 3 — Write GraphQL persisted queries (one per channel)

Each query returns only the fields that channel needs:
```graphql
# patient-portal query — full body + compliance flag
# mobile-app query — headline + cta only (card format)
# clinical-staff query — headline + body (dense, no CTA)
```
Test all three in AEM GraphQL Explorer before the demo.

## Step 4 — Build channel preview pages

Three simple renditions visible simultaneously:
- Patient portal card
- Mobile app tile
- Clinical staff alert banner

Same CF source. Three outputs. The demo moment is: edit one field → all three refresh.

## Step 5 — Configure DMwOA asset delivery

Single asset URL → web crop, mobile crop, thumbnail served automatically. No rendition management.

## Step 6 — Visual validation

Playwright Bash script loads all 3 channel previews simultaneously, captures screenshots. Confirms the "one edit → three refreshes" moment works before the call. Run via `node validate-channels.js`, delete after.

## Step 7 — Wire the governance close

Configure one approval workflow: `complianceApproved = false` blocks all channel delivery. This is the close: *"One approval controls what goes live everywhere — patient-safe content cannot ship without compliance sign-off regardless of channel."*

**Time target:** Full working demo with live GraphQL queries in 1–2 hours.
