Audit Tailwind usage. Focus: Structure & Patterns. Branding-agnostic.

$ARGUMENTS

**Checks:**
1. **Abstractions:** Flag custom CSS classes (`.btn`, `.card`) replicating utilities. 
2. **Hardcoding:** Flag hardcoded colors/fonts/spacing in shared components. Use CSS variables.
3. **Mobile-First:** Flag `max-w-*` or layout overrides that break mobile-first flow.
4. **Style Scoping:** Flag `<style scoped>` used for Flex/Grid/Spacing (must be utilities).
5. **Redundancy:** Flag conflicting classes (e.g., `w-full w-1/2`) or duplicates.
6. **A11y:** Flag missing `sr-only` on icons or missing `focus:` ring utilities.

**Findings:**
---
**Scope:** [Files]
**Issues:**
- [WARN | INFO] [Pattern Type] -> Description (file:line)
---
**Clean:** State "No violations" if none found.