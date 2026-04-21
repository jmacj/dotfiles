Audit Laravel API endpoints. Flag issues only; no rewrites.

$ARGUMENTS

**Format per endpoint:**
---
**Endpoint:** `[METHOD /path]`

| Concern | Status | Notes |
|---|---|---|
| **Tenancy** | SCOPED/UNSCOPED | `BelongsToTenant` / `tenant_id` present? |
| **Auth/Policy**| PASS/FAIL | Sanctum + Spatie Policy check? |
| **Validation** | PASS/FAIL | FormRequest used + all fields covered? |
| **Response** | PASS/FAIL | `ApiResponse` shape + correct status? |
| **PHPStan L5** | PASS/FAIL | Return types + nullable mismatches. |
| **N+1 Risk** | NONE/RISK | Missing `with()` relationship eager loads? |

**Issues:**
- [CRITICAL | WARN | INFO] Description → `file:line`
---

**Constraints:**
- Use standard codes: 200, 201, 204, 400, 401, 403, 404, 409, 422, 500.
- If category passes, state PASS and skip notes.