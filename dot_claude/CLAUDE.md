# Claude — Jan (jmacj)

## Communication

You are talking to a senior developer. Skip preamble, recaps, and encouragement.
Lead with the decision or finding. Justify only when non-obvious.
One precise question over a list of options when clarification is needed.
Architecture and tradeoffs over implementation prose.

## Workflow

### Claude.ai — Decisions Only
- Requirements, architecture, edge cases, business rules. Once a decision is made, it stays made.
- Plans complex or multi-step work into sequenced checklists via `/plan-implementation`.
- Proposes decisions with clear tradeoffs. Jan makes the final call, always.
- Claude never makes unilateral architectural or structural decisions.
- No line-by-line implementation at this layer.

### Claude Code — All Execution
- Scoped implementation directly against local files and running environments.
- Reads per-repo `CLAUDE.md` automatically for project context. Has persistent memory across sessions.
- Writes and edits files directly.

**Readiness test before switching to Claude Code:**
> "Does Claude Code have everything it needs to execute without asking for clarification?"
> If yes — plan is solid, checklist item is scoped, per-repo `CLAUDE.md` has context — skip chat and go directly to Claude Code.

### Verification (Jan's responsibility)
- Pull package updates, run migrations where applicable.
- `composer format` (Pint) and `composer analyse` (PHPStan level 5).
- Confirm behavior before committing.
- Minimal fixes (typos, config tweaks, minor syntax) handled by Jan directly — not routed through Claude Code.

### Signal Words
- `"plan"` / `/plan-implementation` → produce a sequenced checklist + CLAUDE.md context block. No code.
- `"review the diff"` → structured review only. No rewrites. No out-of-scope suggestions.
- `"implement"` / `"write"` → write or edit files directly.

## Stack Conventions

### Laravel
- Laravel 13+. Pint enforced. PHPStan level 5 minimum.
- `declare(strict_types=1)` on every PHP file.
- Validation in Form Request classes only — never `$request->validate()` inline.
- API responses: `['data' => ..., 'message' => ..., 'meta' => ...]` via `ApiResponse` helper.
- All tenant-scoped models extend `TenantModel` and implement `BelongsToTenant`.
- `tenant_id` is always a non-nullable FK. Never expose cross-tenant data.
- Auth: Sanctum (token). Authorization: Spatie Permission via Policy classes.
- No raw queries without a comment explaining why Eloquent cannot handle it.
- PHPUnit with Pest syntax. Feature tests for every API endpoint. No DB mocking.

### Vue 3 / TypeScript / Inertia
- `<script setup lang="ts">` always. No Options API.
- `defineProps<{...}>()` and `defineEmits<{...}>()` — generic form only.
- Composables in `composables/use*.ts`. No logic beyond simple computed/watch in components.
- Types in `types/`, exported from `types/index.ts`. No `any`.
- Inertia: `usePage()`, `useForm()`, `router.visit()`. Pages in `Pages/`, shared in `Components/`.

### Tailwind CSS
- Utility-first. No semantic class abstractions in shared CSS.
- Mobile-first responsive (`sm:`, `md:`, `lg:`).
- No hardcoded color values or font families in shared components. Design tokens are project-scoped.

### General
- pnpm only. Never npm or yarn.
- PostgreSQL. All schema changes via migrations. `jsonb` over `json`. UUID for public-facing IDs.
- GitHub Actions: artifact-based CD where applicable. Secrets in GitHub environment secrets, never inline.


## Active Projects

| Alias | Repo(s) | Status |
|---|---|---|
| **[saas]** | `saas-core`, `saas-app`, `saas-web` | Active — multi-repo SaaS |
| **[work]** | private | Day job — EHR, Laravel + React/Next.js |
| **[civic-a]** | `civic-a` | Active — Nuxt, PM2, Playwright E2E |
| **[civic-b]** | `civic-data` | Active — CC BY 4.0, CODEOWNERS `@jmacj` |
| **[events]** | private | Laravel + Blade + Alpine.js, multi-theme |

## Rules

@rules/laravel-architecture.md
@rules/nuxt-vue-components.md
@rules/civic-tech-conventions.md
