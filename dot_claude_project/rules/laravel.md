# Laravel Logic
- Strict: `declare(strict_types=1)` on every file.
- Tenancy: Models must extend `TenantModel`. `tenant_id` is a required non-nullable FK.
- Resolution: Tenants resolved via Middleware -> `TenantContext`. Controllers do not resolve.
- Controllers: Thin. Use Invokable classes or Service classes.
- Requests: All validation in Form Request classes (no inline `$request->validate`).
- API: Shape is `['data' => ..., 'message' => ..., 'meta' => ...]`. Use API Resources.
- Auth: Sanctum + Spatie Policies. No string-based role checks; use Enums.
- DB: Postgres `jsonb` + `uuid` (public). Index all `tenant_id` columns.
- Tests: Pest. Feature tests mandatory for all endpoints. No DB mocking.