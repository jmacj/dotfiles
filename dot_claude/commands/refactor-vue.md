Evaluate the Vue 3 component(s) below and produce a refactor plan. Do not write code.

$ARGUMENTS

Output:

---
**Verdict:** CLEAN | NEEDS REFACTOR | REWRITE

**Issues:**
- [Issue description → `Component.vue:line`]

**Refactor Plan:** *(omit if CLEAN)*
Ordered steps. Each step is a discrete change, scoped to the component. Suitable for use as a direct Claude Code prompt.

1. [Step]
2. [Step]
---

Evaluation checklist:

**Script:**
- [ ] `<script setup lang="ts">` — not `<script lang="ts">`, not Options API
- [ ] `defineProps<{...}>()` generic form — not runtime validators
- [ ] `defineEmits<{...}>()` generic form
- [ ] No `any` — explicit types or `unknown`
- [ ] Types extracted to `types/` if used beyond this component

**Logic:**
- [ ] Reusable logic in `composables/use*.ts`, not inline
- [ ] No `this`
- [ ] No `data()` / `methods` / `computed` Options API keys

**Inertia:**
- [ ] `usePage()` for shared props — not route params
- [ ] `useForm()` for form state
- [ ] `router.visit()` for programmatic navigation

**Tailwind:**
- [ ] Utility-first — no `.btn`, `.card`, or similar abstractions
- [ ] No hardcoded color values in shared/library components
- [ ] No scoped `<style>` blocks for structural layout

**Accessibility:**
- [ ] Interactive elements have accessible labels
- [ ] `<button>` for actions, `<a>` for navigation
- [ ] Focus management on modals/dialogs
