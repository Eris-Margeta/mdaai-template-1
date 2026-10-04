# GOTCHAS

**Known Pitfalls and Their Solutions**

---

## Overview

This document contains hard-won knowledge about project-specific pitfalls. It is the first line of defense against repeating mistakes.

**AI Agents:**
- MUST consult this document before starting any work
- MUST update this document when discovering new gotchas
- Create a Corrective Work Order when adding a new gotcha

---

## Format

Each gotcha follows this structure:

```markdown
### GOTCHA-NNN: [Short Title]

**Discovered:** YYYY-MM-DD
**Source:** CWO-YYYY-NNN or WO-YYYY-NNN
**Severity:** Critical | High | Medium | Low
**Affected Area:** [Component/Module]

**Problem:**
[What goes wrong]

**Root Cause:**
[Why it goes wrong]

**Solution:**
[How to avoid or fix it]

**Code Example:**
```code
[If applicable]
```
```

---

## Gotchas by Category

### Build & Compilation

*(Gotchas related to build process will be added here)*

### Runtime

*(Gotchas related to runtime behavior will be added here)*

### Database

*(Gotchas related to database operations will be added here)*

### API

*(Gotchas related to API behavior will be added here)*

### Testing

*(Gotchas related to testing will be added here)*

### Dependencies

*(Gotchas related to dependencies will be added here)*

### Environment

*(Gotchas related to environment/configuration will be added here)*

---

## Gotcha Template

Copy this when adding a new gotcha:

```markdown
### GOTCHA-NNN: [Title]

**Discovered:** YYYY-MM-DD
**Source:** CWO-YYYY-NNN
**Severity:** [Critical|High|Medium|Low]
**Affected Area:** [Area]

**Problem:**
[Description]

**Root Cause:**
[Analysis]

**Solution:**
[How to avoid/fix]

**Code Example:**
```code
[If applicable]
```
```

---

## Adding a New Gotcha

1. Assign the next sequential GOTCHA number
2. Fill out all required fields
3. Place in the appropriate category
4. Reference the source CWO or WO
5. Create a Work Order documenting the addition

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | YYYY-MM-DD | Template | Initial structure |
