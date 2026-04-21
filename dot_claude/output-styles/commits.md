> UNOFFICIAL — No native `output-styles/` directory in Claude Code as of April 2026.
> Import via `@output-styles/commits.md` in a project CLAUDE.md, or reference manually in prompts.

# Commit Message Style

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

- Description: imperative mood, lowercase, no trailing period. Max 72 chars total including type and scope.
- Body: only when the WHY is not obvious from the description. Hard-wrap at 72 chars.
- Footer: breaking changes (`BREAKING CHANGE: ...`) and issue refs (`Closes #n`). No co-author lines unless requested.

## Types

| Type | When |
|---|---|
| `feat` | New feature or behavior visible to users or consumers |
| `fix` | Bug fix |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf` | Performance improvement |
| `test` | Adding or correcting tests only |
| `ci` | CI/CD workflow or pipeline changes |
| `chore` | Maintenance, dependency updates, tooling config |
| `docs` | Documentation only |
| `revert` | Reverts a previous commit — reference the reverted SHA in body |

## Scopes by Project

### [saas] (multi-repo SaaS)

| Scope | Applies to |
|---|---|
| `core` | Shared package logic |
| `saas` | SaaS app-level changes |
| `web` | Frontend package |
| `db` | Migrations, schema changes |
| `auth` | Sanctum, Spatie Permission, policies |
| `tenancy` | TenantModel, BelongsToTenant, subdomain resolution |
| `domain` | Core domain logic |
| `api` | Endpoints, API resources, form requests |
| `ui` | Component-level frontend changes |
| `types` | TypeScript type definitions |

### Nuxt / artifact-based CD projects

| Scope | Applies to |
|---|---|
| `cd` | GitHub Actions workflows |
| `deploy` | PM2 config, symlink scripts, release pruning |
| `e2e` | Playwright test suite |
| `data` | Public data files, source citations |
| `seo` | Meta tags, sitemap, structured data |
| `ui` | Nuxt page and component changes |

### Civic / open data repos

| Scope | Applies to |
|---|---|
| `data` | Record additions or corrections |
| `schema` | Data schema changes |
| `ci` | Validation pipeline |
| `docs` | Contribution templates, CODEOWNERS, README |

### Laravel Blade / server-rendered apps

| Scope | Applies to |
|---|---|
| `domain` | Core domain logic |
| `api` | API layer |
| `ui` | Frontend components |
| `auth` | Authentication and authorization |
| `theme` | Multi-theme templates |

## Examples

```
feat(domain): add record assignment to workflow

fix(tenancy): scope ResourceQuery to current tenant on index

refactor(core): extract DomainService from DomainController

test(api): add tenant isolation assertions to resource endpoints

ci(cd): cache pnpm store in build workflow

chore(db): add composite index on tenant_id + created_at

feat(data): add council records for region batch 2024-Q4

fix(deploy): retain last 3 releases in prune step

feat(theme): add dark mode variant to confirmation template
```

## Breaking Changes

```
feat(auth)!: replace Sanctum cookie auth with token-only

BREAKING CHANGE: Cookie-based sessions removed. All API clients
must switch to Bearer token authentication.
```
