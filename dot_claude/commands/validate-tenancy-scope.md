Validate tenant scoping for the Laravel model(s) or migration(s) specified. Row-level tenancy via `tenant_id`, `TenantModel` base class, `BelongsToTenant` trait.

$ARGUMENTS

---
**Tenancy Scope Validation**

For each model or migration reviewed:

**Model: `[ClassName]`**

| Check | Status | Notes |
|---|---|---|
| Extends `TenantModel` | PASS / FAIL | Must not extend plain `Model` for tenant-scoped entities |
| Uses `BelongsToTenant` trait | PASS / FAIL | Provides global scope and `tenant_id` assignment |
| `tenant_id` FK in migration | PASS / FAIL / N/A | Non-nullable `foreignId('tenant_id')->constrained()` |
| No unscoped queries | PASS / FAIL | No `Model::withoutGlobalScopes()` without explicit justification |
| Factory uses tenant context | PASS / FAIL / N/A | Factory sets `tenant_id` from context, not hardcoded |
| Relationships don't escape tenant | PASS / FAIL | `hasMany`/`belongsTo` targets are also tenant-scoped or global |

**Issues:**
- [CRITICAL | WARN] Description → `file:line`

**Verdict:** SCOPED CORRECTLY | VIOLATIONS FOUND | MANUAL REVIEW REQUIRED

---

CRITICAL: Any model that stores user data or core business records MUST be tenant-scoped. Flag ungated global queries on these models as CRITICAL.
