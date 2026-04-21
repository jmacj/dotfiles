Produce a sequenced implementation plan for Jan's stack. 
Logic: Data dependencies first (Migration -> Model -> Service -> Controller -> UI).

Feature: $ARGUMENTS

**Output exactly two artifacts; no extra prose.**

---
## Implementation Checklist
Format: `- [ ] \`repo\` — specific task prompt`

- **Atomic:** One layer per item.
- **Specific:** No vague "Add validation." Include specific rules/fields.
- **Dependencies:** Explicitly state "after [repo] changes land" for cross-repo work.

---
## CLAUDE.md Context Block
Lean snippet for local `CLAUDE.md`. No reasoning, only decisions.

```markdown
## [Feature Name] — Active Context
**Phase:** [Name]
**Feature:** [Name]

**Decisions:**
- [Chosen approach]

**Conventions:**
- [New pattern for Claude Code to follow]

**Constraints:**
- [Resolved gotcha]
```
