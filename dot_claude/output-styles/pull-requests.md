> UNOFFICIAL — No native `output-styles/` directory in Claude Code as of April 2026.
> Import via `@output-styles/pull-requests.md` in a project CLAUDE.md, or reference manually in prompts.

# Pull Request Description Style

## Base Template

```markdown
## What
- [Imperative bullet. What changed.]
- [Keep to 1–3 bullets. One change per bullet.]

## Why
[1–2 sentences. The motivation — a bug, a requirement, a constraint. Omit if obvious from "What".]

## How
[Only for non-obvious implementation decisions. Omit if the approach is straightforward.]

## Testing
- [ ] [Manual test performed]
- [ ] [Automated tests added or updated]
- [ ] [Edge case covered]

## Notes
[Breaking changes, migration steps, deploy order, follow-up issues. Omit section if none.]
```

---

## Context-Specific Additions

### Multi-repo Laravel SaaS

Append to **Notes** when applicable:

**Dependency order:**
- Shared core package changes: does the app require `composer update`? Does the frontend package require a version bump + registry publish?
- State merge/deploy order explicitly when multiple repos are affected.

**Migrations:**
- Additive-only (zero-downtime safe) or destructive? If destructive, state the deploy sequence.
- Confirm `up()` and `down()` both present.

**Tenancy:**
- Confirm `BelongsToTenant` + `tenant_id` FK on any new or modified tenant-scoped model.

**Testing checklist additions:**
```markdown
- [ ] Tenant isolation verified — cross-tenant query not possible
- [ ] PHPStan level 5 passes (`composer analyse`)
- [ ] Pint clean (`composer format --test`)
- [ ] Feature tests cover: happy path, 422 validation failure, 403 authorization failure
```

---

### Artifact-based CD (Nuxt + PM2 + atomic symlink)

Append to **Notes** for any PR touching deployment config or workflows:

```markdown
- Affected workflows: [list]
- Deploy sequence: artifact upload → download → extract to `releases/[ts]/` → symlink swap → PM2 reload → prune
- Symlink swap atomic: `ln -sfn` ✓ / ✗
- Rollback tested: yes / no
- Releases retained after prune: [n] (minimum 3)
```

**Testing checklist additions:**
```markdown
- [ ] Playwright E2E suite passes
- [ ] `ecosystem.config.cjs` — name, script, cwd match deploy script
- [ ] Symlink swap uses `ln -sfn` (atomic), not `ln -sf`
- [ ] Release pruning retains ≥ 3 releases
```

---

### Civic / open data repos

Append to **Notes** for data PRs:

```markdown
- Source citation: included in data file / `sources.yaml` ✓ / ✗
- Schema validation: passes in CI ✓ / ✗
- License compatibility: confirmed ✓ / ✗
- `verified: true/false` set correctly on all new records
```

---

### Regulated / compliance-sensitive projects

Append to **Notes** when applicable:

```markdown
- Compliance impact: [none / indirect / direct — describe]
  If any sensitive data change: explicit review note required before merge.
- Auth/permission scope change: [yes / no]
  If yes: requires explicit sign-off in PR comments.
- Schema migration: [none / additive / destructive]
  If destructive: deploy plan required in this section.
```

---

## PR Size Guidelines

- Scope PRs to one feature, one fix, or one migration. Multi-repo changes should be coordinated PRs with explicit merge order — not a single monolithic PR.
- Never combine a schema migration with unrelated feature work.
- Data repo PRs: one logical unit (one entity type or one record batch) per PR.
- Deploy config changes should be their own PR unless trivially coupled to the feature.
