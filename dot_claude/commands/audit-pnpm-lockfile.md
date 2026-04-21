Audit pnpm lockfile/package.json for sync, bloat, and security.

$ARGUMENTS

**Checks:**
1. **Sync:** Check if `pnpm-lock.yaml` matches `package.json`. 
2. **Duplicates:** Flag packages resolved at 2+ major/minor versions (bundle bloat).
3. **Workspace:** Ensure consistent dependency versions across monorepo packages.
4. **Outdated:** Flag if >1 major version behind: `vue`, `@inertiajs/vue3`, `vite`, `typescript`, `tailwindcss`.
5. **Security:** Report results of `pnpm audit --audit-level=high`.
6. **Phantom Deps:** Identify imports not listed in `package.json`.

**Findings:**
---
**Lockfile Version:** [version]
**Issues:**
- [CRITICAL | WARN | INFO] [Package Name] -> Description

**Recommended Actions:**
- [Action]
---

**Constraint:** If `pnpm-lock.yaml` is missing, report CRITICAL immediately.