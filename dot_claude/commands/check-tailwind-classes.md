Audit Tailwind CSS usage in the component(s) or file(s) specified. Branding-agnostic — do not flag specific color values as wrong; flag structural and pattern violations only.

$ARGUMENTS

---
**Tailwind Class Audit**

**Scope:** [files/components reviewed]

**Checks:**

1. **Semantic abstractions** — Flag any custom class names (`.btn-*`, `.card-*`, `.form-*`, etc.) defined in `<style>` or global CSS that replicate Tailwind utility compositions. These should be replaced with utility classes applied directly.

2. **Hardcoded design tokens in shared components** — Flag any color (`text-*`, `bg-*`, `border-*`), font (`font-*`, `text-size`), or spacing token hardcoded in a component that is intended to be reusable across projects. These should be accepted via props or CSS custom properties.

3. **Responsive convention** — All breakpoint modifiers must be mobile-first. Flag any `max-*:` variants used for layout (not overrides).

4. **Scoped `<style>` misuse** — Flag `<style scoped>` blocks that handle structural layout (flexbox, grid, sizing, spacing). These belong in utilities. Acceptable uses: CSS variables, third-party overrides, CSS transitions/animations.

5. **Duplicate utility groups** — Flag obvious redundancy: e.g., `flex flex-col flex-column` or conflicting classes (`w-full w-1/2`).

6. **Accessibility utilities** — Flag missing `sr-only` on icon-only buttons, missing `focus:` rings on interactive elements.

**Issues:**
- [WARN | INFO] Description → `file:line`

**Clean:** State explicitly if no violations found.
---
