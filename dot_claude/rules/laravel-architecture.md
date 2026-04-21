# Laravel Architecture Rules

Applies to: all Laravel projects

## Code Style & Static Analysis

- Laravel Pint enforced. Config in `pint.json` at project root.
- PHPStan level 5 minimum. No `@phpstan-ignore` without a comment explaining the exception.
- `declare(strict_types=1)` on every PHP file.
- No unused imports. No dead code committed.

## Multi-Tenancy

- All tenant-scoped Eloquent models extend `TenantModel` and use the `BelongsToTenant` trait.
- `tenant_id` is a non-nullable `foreignId` FK on every tenant-scoped table.
- Global scope on `TenantModel` enforces `tenant_id` filtering — never call `withoutGlobalScopes()` without explicit justification in a comment.
- Tenant resolution: subdomain-based, resolved in middleware, set on `TenantContext` singleton. Controllers must not resolve tenants.
- Cross-tenant queries are a security violation. Any query that could return rows from multiple tenants without explicit intent is CRITICAL.

## Package Structure (shared Laravel package)

- The shared core is a pure Laravel package. No routes, no controllers, no HTTP layer.
- Service providers register all bindings. No façade aliases that aren't in the provider.
- Config files published via `php artisan vendor:publish`. Never assume app config in the package.
- Consumed by the SaaS app via Composer path repository in development, GitHub Packages in CI.

## Controllers

- Thin controllers only. Business logic belongs in service classes or single-action invokables.
- Validation: Form Request classes. Never `$request->validate()` inline in a controller method.
- Resource controllers follow Laravel conventions (`index`, `store`, `show`, `update`, `destroy`).
- No logic in `__construct` beyond dependency injection.

## API Responses

- Consistent shape: `['data' => mixed, 'message' => string, 'meta' => array]` via `ApiResponse` helper.
- HTTP status codes: 200, 201, 204, 400, 401, 403, 404, 409, 422, 500. No invented codes.
- Validation errors: 422 with Laravel's default error bag structure inside `data`.
- Never return raw Eloquent collections — always transform via API Resources.

## Authentication & Authorization

- Sanctum: all API routes behind `auth:sanctum` middleware.
- Spatie Permission: roles and permissions defined in seeders. Use constants or enums for role/permission names — never hardcode strings in controllers.
- Every model with resource-level access control must have a corresponding Policy class.
- `Gate::authorize()` or `$this->authorize()` in controllers — not inline `if` checks.

## Database

- All schema changes via migrations. No manual column additions in any environment.
- PostgreSQL: `jsonb` over `json`. `uuid` for public-facing identifiers. `bigIncrements` for internal PKs.
- Eloquent: `with()` for all known relationship traversals. N+1 is a defect.
- Raw queries require an inline comment: `// Raw: Eloquent cannot express [reason]`.
- Indexes: every `tenant_id` + query column combination on tenant-scoped tables should have a composite index.

## Testing

- PHPUnit with Pest syntax.
- Feature tests for every API endpoint — cover happy path, validation failure, authorization failure, tenant isolation.
- Unit tests for service classes and complex business logic.
- `RefreshDatabase` trait on all test classes. No database mocking.
- Factories must set `tenant_id` from context, not a hardcoded value.
