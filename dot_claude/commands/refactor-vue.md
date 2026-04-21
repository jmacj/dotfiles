Evaluate Vue 3 components and produce a refactor plan. No code.

$ARGUMENTS

**Evaluation:**
- Pattern: `<script setup lang="ts">`, Generic Props/Emits, No `any`.
- Logic: Composables for logic, Inertia `useForm()`/`usePage()`.
- Style: Utility-first Tailwind (no colors/fonts), no structural `<style scoped>`.
- A11y: Semantic HTML, focus management, accessible labels.

---
**Verdict:** CLEAN | NEEDS REFACTOR | REWRITE

**Issues:**
- [CRITICAL | WARN | INFO] Description → `file:line`

**Refactor Plan:** (omit if CLEAN)
1. [Step - Atomic & prompt-ready]
2. [Step - Atomic & prompt-ready]
