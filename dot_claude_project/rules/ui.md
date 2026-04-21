# Frontend Standards
- Script: `<script setup lang="ts">` only. No Options API.
- Props/Emits: Generic `defineProps<{}>` / `defineEmits<{}>` only.
- State: Composables for logic >1 line. No `this`.
- Inertia: Use `useForm()`. Nav via `<Link>`.
- Tailwind: Utility-first. Mobile-first (`sm:`). No layout props in `<style>`.
- A11y: `<button>` for actions, `<a>` for nav. `aria-label` for icons.