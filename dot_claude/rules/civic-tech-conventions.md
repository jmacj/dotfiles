# Civic Tech Conventions

Applies to: civic transparency sites, open government data repos

## Data Integrity

- All public data must derive from verifiable government records. Every data entry requires a source citation (URL or document reference) in the record or an accompanying `sources.yaml`.
- No PII in public datasets. Official contact information must follow minimum necessary disclosure: use institutional contacts over personal ones where available.
- If data provenance is uncertain, mark the record `verified: false` and display it with an uncertainty label in the UI.
- Data files: YAML for human-edited records, JSON for CI-generated output.
- Timestamps: ISO 8601 — `YYYY-MM-DD` for dates, RFC 3339 for datetimes.

## Repository Standards

- Contributions must use the structured pull request template. PRs without it are not reviewed.
- All contributed data must be license-compatible with the repo's declared license — flag incompatible sources before merge.
- CI: schema validation runs on every PR that touches data files. Do not merge PRs with validation failures.
- Branch naming: `data/[identifier]` for data additions, `feat/[feature]` for site features, `fix/[description]` for corrections.

## Transparency-First UI

- Every data point displayed to the public must link to or reference its source. No unsourced assertions.
- Uncertainty must be surfaced: if data is unverified, outdated (> 1 year without re-verification), or contested, show it with an explicit label — not hidden, not styled away.
- No dark patterns. Navigation and data tables must be immediately legible without guidance.
- Data tables always include: `Last Updated` column, `Source` column or footnote.
- Language: plain and accessible. Avoid policy jargon without a plain-language equivalent.
