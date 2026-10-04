# AGENTS.md - Guides Navigation

<!-- Parent: ../../AGENTS.md -->

This directory contains **best practice guides** maintained by human developers.

---

## Directory Purpose

The GUIDES folder contains coding standards, style guides, and best practices. These are reference documents that AI agents should consult but cannot modify.

**PERMISSION LEVEL:** READ-ONLY for AI agents

---

## Documents

| Document | Purpose | Language |
|----------|---------|----------|
| `CODE-PHILOSOPHY.md` | **Core principles - MUST READ** | All |
| `TESTING-PHILOSOPHY.md` | **Testing approach - READ IF TESTING** | All |
| `RUST-ENTERPRISE-CODE-DOCTRINE.md` | Rust coding conventions | Rust |
| `GO-ENTERPRISE-CODE-DOCTRINE.md` | Go coding conventions | Go |
| `PYTHON-ENTERPRISE-CODE-DOCTRINE.md` | Python coding conventions | Python |
| `NODE-ENTERPRISE-CODE-DOCTRINE.md` | Node.js/TypeScript conventions | TypeScript |
| `HTML-CSS-ENTERPRISE-CODE-DOCTRINE.md` | HTML/CSS conventions | Frontend |

---

## For AI Agents

### When to Consult Guides

**ALWAYS read CODE-PHILOSOPHY.md first.** It contains:
- Single Responsibility Principle
- Code structure patterns
- Comment standards
- README requirements

**When writing tests, read TESTING-PHILOSOPHY.md.** It contains:
- AI-Human alignment in testing
- Universal test design principles
- Test organization patterns
- How to run tests correctly

Then, before writing code in any language:
1. Check if a style guide exists for that language
2. Read the relevant guide completely
3. Follow all conventions specified

### Hierarchy of Style Authority

1. **Project-specific ADRs** - Highest (if an ADR overrides a style guide)
2. **Style guides in this folder** - Standard authority
3. **Language official guides** - Reference when our guides don't cover something

### Guide Scope

Each style guide covers:
- Project structure
- Naming conventions
- Error handling patterns
- Testing conventions
- Tools and configuration
- Prohibited practices

### If No Guide Exists

If there's no style guide for your language:
1. Follow the language's official style guide
2. Document any project-specific conventions in KNOWLEDGE/DEVELOPMENT-PRACTICES.md
3. Suggest creating a formal guide (add to NOTES.md)

---

## Note on Legacy Files

The following files in this folder are legacy and have been moved:
- `AI-INSTRUCTIONS.md` → Now at `GOVERNANCE/AI-INSTRUCTIONS.md`
- `CHECKPOINT-PROTOCOL.md` → Now at `GOVERNANCE/CHECKPOINT-PROTOCOL.md`
- `DEVELOPER-GUIDE.md` → Now at `KNOWLEDGE/DEVELOPER-GUIDE.md`
- `DEVELOPMENT-PRACTICES.md` → Now at `KNOWLEDGE/DEVELOPMENT-PRACTICES.md`

The canonical versions are in their new locations. These legacy copies will be removed.
