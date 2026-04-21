# Vue 3 + TypeScript + Inertia Component Rules

Applies to: private SaaS frontend packages, civic Nuxt projects

## Component Authoring

- `<script setup lang="ts">` on every component. No Options API. No `<script>` without `setup`.
- `defineProps<{...}>()` generic form. No runtime prop validators (`{ type: String, required: true }`).
- `defineEmits<{...}>()` generic form: `defineEmits<{ update: [value: string] }>()`.
- `defineExpose()` only when a parent has a legitimate imperative use case — document why.

## TypeScript

- No `any`. Use explicit types or `unknown` and narrow.
- Type assertions (`as`) require an inline comment explaining why narrowing is not possible.
- Props and emit interfaces defined inline only if single-component use. Otherwise, extract to `types/[domain].ts` and export from `types/index.ts`.
- Generic utility types in `types/utils.ts`.

## Composition API

- All stateful logic beyond a single `computed` or `watch` goes into a composable.
- Composables: `composables/use[Name].ts`. Pure functions — no direct DOM access unless inside `onMounted` or a watcher.
- No `this`. No Options API lifecycle hooks (`mounted`, `created`). Use `onMounted`, `onUnmounted`, etc.
- `provide`/`inject` only for genuinely tree-wide state. Prefer props for component-local data.

## Inertia.js

- Page components: `Pages/[Domain]/[PageName].vue`.
- Shared components: `Components/[Domain]/[ComponentName].vue`.
- Shared Inertia props accessed via `usePage().props`. Do not pass them through route params.
- Form state: `useForm()`. No manual `ref` + `axios` for form submissions.
- Navigation: `router.visit()`. Never `window.location.href` for Inertia routes.
- Inertia link: `<Link href="...">` not `<a href="...">` for client-side navigation.

## Nuxt

- Auto-imported composables from `composables/`. Do not manually import Nuxt-provided composables.
- `useFetch` / `useAsyncData` for data fetching in page components.
- `definePageMeta` for route metadata (title, auth guards if applicable).

## Tailwind CSS

- Utility-first. No `.btn`, `.card`, `.form-field`, or other semantic abstractions in global or scoped CSS.
- Mobile-first responsive: `sm:`, `md:`, `lg:`. Avoid `max-*:` variants for primary layout.
- No hardcoded color values (`text-blue-500`, `bg-gray-100`) or font families in shared/library components. Accept via props or CSS custom properties set by project context.
- `<style scoped>` blocks are acceptable only for: CSS custom properties, third-party library overrides, CSS transitions and animations that cannot be expressed with Tailwind's `transition-*` utilities.
- No layout (flex, grid, width, padding, margin) in `<style>` blocks — utilities only.

## Accessibility

- Every interactive element has an accessible name: visible text, `aria-label`, or `aria-labelledby`.
- `<button>` for actions that do not navigate. `<a>` (or `<Link>`) for navigation. Never swap these.
- `v-if` over `v-show` for content that is significant in size and not toggled frequently.
- Modals and dialogs: trap focus on open, restore focus to trigger on close. Use `aria-modal="true"` and `role="dialog"`.
- Icon-only buttons: `aria-label` required, icon wrapped in `aria-hidden="true"` span.

## File Organization (SaaS frontend packages)

```
Components/
  [Domain]/               # domain-first, not UI-category-first
Pages/
  [Domain]/
composables/
  use[Name].ts
types/
  index.ts                # re-exports all domain types
  [domain].ts
```
