Validate row-level tenant scoping for Laravel models/migrations.

$ARGUMENTS

**Checklist:**
- **Base:** Extends `TenantModel`; Uses `BelongsToTenant` trait.
- **Migration:** `tenant_id` is non-nullable `foreignId` + `constrained()`.
- **Isolation:** No `withoutGlobalScopes()` without comment justification.
- **Context:** Factory sets `tenant_id` via `TenantContext`.
- **Graphs:** Relationships target tenant-scoped or global entities only.

---
**Model: `[ClassName]`**

| Check | Status | Notes |
|---|---|---|
| **Base Class** | | |
| **Trait** | | |
| **Migration** | | |
| **Queries** | | |
| **Factory** | | |
| **Rel Graph** | | |

**Issues:**
- [CRITICAL | WARN] Description → `file:line`

**Verdict:** SCOPED | VIOLATIONS | MANUAL REVIEW
---

**CRITICAL:** Business/User data must be gated. Flag ungated global queries immediately.