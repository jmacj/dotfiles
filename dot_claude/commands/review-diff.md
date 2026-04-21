Review the diff below against Jan's stack conventions. Do not rewrite code. Do not suggest changes outside the diff scope.

$ARGUMENTS

Output this structure exactly:

---
**Verdict:** APPROVE | REQUEST CHANGES | DISCUSS

**Critical** (blocks merge):
- [Issue description → `file:line`]

**Conventions** (non-blocking, should fix before next PR):
- [Issue description → `file:line`]

**Notes** (observations, no action required):
- [Observation]
---

Checklist — flag any violation found:

**Laravel:**
- [ ] `declare(strict_types=1)` present
- [ ] Pint style (formatting, import order)
- [ ] PHPStan level 5 — return types, nullability, generics on collections
- [ ] Validation in Form Request only
- [ ] `ApiResponse` shape consistent
- [ ] Tenant-scoped models extend `TenantModel`, use `BelongsToTenant`
- [ ] `tenant_id` on every new tenant-scoped table
- [ ] No cross-tenant query exposure
- [ ] Sanctum gates + Spatie Permission checks present where required
- [ ] No N+1 — `with()` used for relationships

**Vue 3 / TypeScript:**
- [ ] `<script setup lang="ts">`
- [ ] `defineProps<{...}>()` generic form
- [ ] No Options API remnants
- [ ] No `any` types
- [ ] Composables in `composables/use*.ts` if logic is reused
- [ ] Inertia patterns: `usePage()`, `useForm()`, `router.visit()`

**Tailwind:**
- [ ] Utility-first — no semantic class abstractions
- [ ] No hardcoded design tokens in shared components

**General:**
- [ ] pnpm lockfile updated if dependencies changed
- [ ] No hardcoded secrets or environment values
- [ ] Migrations present for schema changes (no raw column adds)
