# AGENTS.md - Knowledge Navigation

<!-- Parent: ../../AGENTS.md -->

This directory contains **living documentation** that AI agents can and should update.

---

## Directory Purpose

The KNOWLEDGE folder contains accumulated wisdom about the project. Unlike GOVERNANCE (approved revision only) and GUIDES (human-maintained), these documents are designed to grow with the project.

**PERMISSION LEVEL:** AI agents CAN and SHOULD update these documents

---

## Documents

| Document | Purpose | Update Frequency |
|----------|---------|------------------|
| `DEVELOPER-GUIDE.md` | Technical onboarding | As architecture evolves |
| `DEVELOPMENT-PRACTICES.md` | Accumulated best practices | When patterns emerge |
| `GOTCHAS.md` | Known pitfalls | When problems are discovered |
| `ERROR-CATALOG.md` | Common errors and fixes | When errors are resolved |
| `TOOL-NOTES.md` | Tool-specific knowledge | When tools are configured |

---

## For AI Agents

### Before Starting Work

1. **Read GOTCHAS.md** - Avoid known pitfalls
2. **Scan ERROR-CATALOG.md** - Know common errors
3. **Check DEVELOPMENT-PRACTICES.md** - Follow established patterns

### During Work

If you discover something worth documenting:
1. Identify the appropriate document
2. Add the information following the document's format
3. Create a Work Order for the update

### After Resolving Errors

1. Create a Corrective Work Order (CWO)
2. Update GOTCHAS.md if it's a new pitfall
3. Update ERROR-CATALOG.md if it's a new error type
4. Reference the CWO in your updates

### Required Work Orders

Every update to KNOWLEDGE/ requires a Work Order:
- GOTCHAS.md updates → Reference CWO that discovered the gotcha
- ERROR-CATALOG.md updates → Reference CWO that resolved the error
- DEVELOPMENT-PRACTICES.md updates → Reference WO or CWO source
- DEVELOPER-GUIDE.md updates → Reference WO for the change

---

## Update Guidelines

### GOTCHAS.md

Add when you:
- Hit a non-obvious problem
- Find a behavior that differs from expectation
- Discover environment-specific issues

### ERROR-CATALOG.md

Add when you:
- Resolve a new error type
- Find a better resolution for existing error
- Identify patterns in error occurrence

### DEVELOPMENT-PRACTICES.md

Add when you:
- Solve a recurring problem
- Discover an efficient pattern
- Establish a project convention

### DEVELOPER-GUIDE.md

Update when:
- Architecture changes
- New components are added
- Setup procedures change

---

## Quick Reference

| Need | Document |
|------|----------|
| "I keep hitting this bug" | GOTCHAS.md |
| "What does this error mean?" | ERROR-CATALOG.md |
| "How should I implement this?" | DEVELOPMENT-PRACTICES.md |
| "How do I set up the project?" | DEVELOPER-GUIDE.md |
| "How do I use this tool?" | TOOL-NOTES.md |
