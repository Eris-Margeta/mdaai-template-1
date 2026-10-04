# TOOL NOTES

**Tool-Specific Quirks and Configuration**

---

## Overview

This document captures tool-specific knowledge that isn't obvious from documentation. It includes quirks, workarounds, and project-specific configurations.

**AI Agents:** You MAY update this document when discovering tool-specific knowledge. Create a Work Order for any updates.

---

## Build Tools

### [Build Tool Name]

**Version:** X.Y.Z

**Project Configuration:**
```
[Configuration snippet]
```

**Notes:**
- [Note 1]
- [Note 2]

**Known Issues:**
- [Issue 1] - Workaround: [workaround]

---

## Package Managers

### pnpm

**Version:** 10+

**Notes:**
- Use `pnpm` for all Node.js projects
- Workspace configuration in `pnpm-workspace.yaml`

### Cargo

**Notes:**
- Workspace configuration in root `Cargo.toml`
- Use `cargo clippy` before commits

---

## Testing Tools

### [Test Framework]

**Configuration:**
```
[Config]
```

**Notes:**
- [Note]

---

## Linters & Formatters

### [Linter Name]

**Configuration:**
```
[Config]
```

**Notes:**
- [Note]

---

## CI/CD

### GitHub Actions

**Notes:**
- Workflow files in `.github/workflows/`
- Use `actions/setup-node@v4` for Node.js

---

## IDE / Editor

### VS Code

**Recommended Extensions:**
- [Extension 1]
- [Extension 2]

**Settings:**
```json
{
  // Project-specific settings
}
```

---

## Environment Tools

### Docker

**Notes:**
- [Note]

### Just (Justfile)

**Common Commands:**
```justfile
# List all commands
just --list

# Run tests
just test

# Build
just build
```

---

## Adding Tool Notes

When adding a new tool section:

1. Include version information
2. Document project-specific configuration
3. Note any quirks or workarounds
4. Create a Work Order for the addition

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | YYYY-MM-DD | Template | Initial structure |
