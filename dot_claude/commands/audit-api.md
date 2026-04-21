Audit the Laravel API endpoint(s) below. Flag issues only — do not rewrite.

$ARGUMENTS

For each endpoint, output:

---
**Endpoint:** `[METHOD /path]`

| Concern | Status | Notes |
|---|---|---|
| **Tenancy Scope** | SCOPED / UNSCOPED / N/A | `BelongsToTenant` present? `tenant_id` in all queries? |
| **Auth** | PASS / FAIL / MISSING | Sanctum middleware on route? |
| **Authorization** | PASS / FAIL / MISSING | Policy invoked? Spatie permission check? |
| **Validation** | PASS / FAIL / MISSING | Form Request class? All fields covered? |
| **Response Shape** | PASS / FAIL / INCONSISTENT | `ApiResponse` structure? Correct HTTP status codes? |
| **PHPStan L5** | PASS / VIOLATIONS | Visible return type issues, nullable mismatches |
| **N+1 Risk** | NONE / POSSIBLE / CONFIRMED | Missing `with()` on relationships? |
| **Error Handling** | ADEQUATE / GAPS | 404, 403, 422 handled appropriately? |

**Issues:**
- [CRITICAL | WARN | INFO] Description → `file:line` if available

---

HTTP status code reference: 200 OK, 201 Created, 204 No Content, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 409 Conflict, 422 Unprocessable Entity, 500 Internal Server Error.

If no issues found in a category, state PASS and move on.
