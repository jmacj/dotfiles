You are producing an implementation plan for Jan's stack. Use this command for complex or multi-step features where sequencing across files or repos matters, cross-repo work (e.g. coordinating changes across a shared core package → SaaS app → frontend package in dependency order), or first-time patterns where conventions need to be established for the rest of the phase.

Do NOT use for: routine tasks where the pattern is already established in the repo's CLAUDE.md, simple single-file changes, or checklist items already specific enough to hand to Claude Code directly.

Feature or requirement: $ARGUMENTS

Produce exactly two artifacts — no prose before, between, or after them.

---

## Implementation Checklist

Sequenced by data dependencies. Each item must be specific enough to use as a direct Claude Code prompt without clarification.

Format: `- [ ] \`repo\` — task description`

Example items:
- [ ] `[core]` — Create `Resource` model extending `TenantModel` with `BelongsToTenant`; status enum: `draft`, `active`, `archived`
- [ ] `[core]` — Migration: `create_resources_table` with `tenant_id` (FK, non-nullable), `uuid`, status, timestamps; composite index on `[tenant_id, status]`
- [ ] `[app]` — `composer update` shared core package after core changes land
- [ ] `[web]` — `ResourceForm.vue`: `<script setup lang="ts">`, `useForm()`, status field bound to enum values from shared types

Rules for the checklist:
- Order strictly by data dependencies — migrations before models, models before services, services before controllers, controllers before frontend.
- Cross-repo items: call out the dependency explicitly (e.g. "after core changes land").
- Each item is one atomic deliverable. Split anything that touches more than one layer.
- No vague items. "Add validation" is not acceptable — "Add `StoreResourceRequest` with rules for name (required, string, max:255), tenant_id (injected, not user-provided), status (enum, default: draft)" is.

---

## CLAUDE.md Context Block

A lean, ready-to-paste markdown snippet for the relevant per-repo `CLAUDE.md` files. Carries only what is specific to this planning session — Claude Code already knows baseline project context from persistent memory and the global CLAUDE.md.

Include only:
- Current phase and the active feature being implemented
- Key decisions made in this chat session (chosen approach only — no alternatives, no reasoning)
- Conventions established for this feature that Claude Code should carry forward for the rest of the phase
- Known constraints or gotchas resolved during planning

Format as a fenced markdown block ready to paste:

\`\`\`markdown
## [Phase / Feature Name] — Active Context

**Phase:** [e.g. Phase 1 — Core Domain]
**Feature:** [e.g. Resource model and creation flow]

**Decisions:**
- [Chosen approach, one line]
- [Chosen approach, one line]

**Conventions for this feature:**
- [Convention Claude Code should follow for the rest of the phase]

**Constraints / gotchas:**
- [Resolved constraint or non-obvious gotcha]
\`\`\`

Paste this block into the relevant repo's `CLAUDE.md` before switching to Claude Code. Claude Code reads it automatically on launch.
