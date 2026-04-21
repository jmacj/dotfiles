# Civic Tech Standards

## Data & Provenance
- Source: Every record requires a citation (URL/doc) in-record or `sources.yaml`.
- PII: Strictly forbidden. Use institutional contacts only.
- Validation: If source is uncertain, set `verified: false`. UI must display "Unverified".
- Formatting: YAML (human-edited), JSON (CI-generated). 
- Timestamps: ISO 8601 (Date: YYYY-MM-DD | Datetime: RFC 3339).

## UI & Transparency
- Linkage: Every public data point must link to its specific source reference.
- Visibility: Show explicit labels for outdated (>1yr) or contested data. No styling away "messy" data.
- Structure: Data tables must include `Last Updated` and `Source` (column or footnote).
- UX: No dark patterns. Utility-first Tailwind only. No layout logic in CSS.
- Language: Plain, accessible English/Tagalog. No policy jargon.