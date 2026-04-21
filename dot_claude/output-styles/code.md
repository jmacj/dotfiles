> UNOFFICIAL — No native `output-styles/` directory in Claude Code as of April 2026.
> Import via `@output-styles/code.md` in a project CLAUDE.md, or reference manually in prompts.

# Code Output Style

## General

- No comments unless the WHY is non-obvious: a hidden constraint, a non-obvious invariant, a workaround for a specific library bug.
- Never write multi-line docblocks, method summaries, or parameter descriptions — well-named identifiers are documentation.
- No `TODO`, `FIXME`, or `HACK` in generated code — surface issues explicitly in the response instead.
- Output only the requested file(s). No scaffolding, no boilerplate wrappers unless explicitly asked.
- When asked to `"plan"` / `/plan-implementation`: produce a sequenced checklist + CLAUDE.md context block only. No code, no prose.

## Laravel / PHP

- `declare(strict_types=1);` as the first statement after `<?php`. Always.
- Pint-compliant: 4-space indentation, single-quoted strings where no interpolation, trailing commas in multi-line arrays.
- PHPStan level 5: all method return types declared, nullable annotated as `?Type`, union types only when genuinely multiple types.
- Validation: Form Request class only. Never `$request->validate()` inline.
- Response transformation: API Resource class. Never raw `->toArray()` or `->toJson()`.
- Controllers: thin. Logic in a service class or single-action invokable (`__invoke`).
- Migrations: both `up()` and `down()` always. Column types: `jsonb` not `json`, `uuid` for public IDs, `timestamp` not `datetime`, `bigIncrements` for internal PKs.
- Tenant-scoped models: extend `TenantModel`, use `BelongsToTenant` trait, `tenant_id` non-nullable FK.
- Tests: Pest syntax. `RefreshDatabase`. No database mocking. Feature tests for every endpoint — cover happy path, 422, 403, and tenant isolation.

## Vue 3 / TypeScript

- Block order: `<script setup lang="ts">` → `<template>` → `<style>` (if needed).
- `defineProps<{...}>()` and `defineEmits<{...}>()` generic forms only. No runtime validators.
- No `any`. Use explicit types or `unknown` + narrowing. Type assertions (`as`) require an inline comment.
- Composables: extract to `composables/use[Name].ts` when logic is reused across components.
- Types: define in `types/[domain].ts`, re-export from `types/index.ts`. Inline only if strictly single-component.
- No scoped `<style>` blocks for layout — Tailwind utilities only. `<style>` is acceptable for: CSS custom properties, third-party overrides, transitions not expressible with Tailwind utilities.
- Inertia: `usePage()` for shared props, `useForm()` for form state, `router.visit()` for navigation. `<Link>` not `<a>` for client-side routes.

## Tailwind CSS

- Utilities in template only. No `@apply` in shared CSS — it creates hidden coupling.
- Mobile-first: `sm:`, `md:`, `lg:`. No `max-*:` for primary layout structure.
- No hardcoded color values (`text-blue-500`) or font families in shared/library components. Use CSS custom properties or design-token props injected per project context.

## Usage Examples

- Include a usage example only when the API surface is non-obvious: composable with multiple overloads, abstract service contract, non-standard factory call.
- Format: a single fenced code snippet immediately after the implementation. One example maximum.
- Omit for: straightforward CRUD methods, simple props, anything a type signature makes self-evident.
