Audit the pnpm lockfile and package.json for the project in the current directory or as specified.

$ARGUMENTS

Perform the following checks and report findings:

---
**pnpm Lockfile Audit**

**Lockfile Version:** [lockfile version from pnpm-lock.yaml]

**Checks:**

1. **Lockfile/manifest sync** — Does `pnpm-lock.yaml` match all `package.json` dependencies? Run: `pnpm install --frozen-lockfile --dry-run` mentally or check for missing/extra entries.

2. **Duplicate packages** — Identify packages resolved at multiple versions. Flag if the same package appears at 2+ versions (potential bundle bloat or peer conflict).

3. **Workspace consistency** — If this is a monorepo, confirm all workspace packages reference consistent versions of shared dependencies.

4. **Outdated critical deps** — Flag if any of these are more than one major version behind:
   - `vue`, `@inertiajs/vue3`, `vite`, `typescript`, `tailwindcss`
   - `laravel-vite-plugin` (if present)

5. **Security** — Note any packages with known CVEs if visible in npm audit output. Run `pnpm audit --audit-level=high` if possible.

6. **Phantom dependencies** — Flag any `import` of packages not listed in `package.json` dependencies or devDependencies.

**Issues:**
- [CRITICAL | WARN | INFO] Description → package name

**Recommended Actions:**
- [Action]
---

If no lockfile is present, flag that as CRITICAL — pnpm lockfile must be committed.
