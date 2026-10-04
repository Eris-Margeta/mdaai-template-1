# AGENTS.md - Architecture Navigation

<!-- Parent: ../../AGENTS.md -->

This directory contains **Architecture Decision Records (ADRs)** - the binding precedents for technical decisions.

---

## Directory Purpose

The ARCHITECTURE folder contains formal records of significant architectural decisions. Once accepted, ADRs become binding precedent that ALL AI agents must follow.

**PERMISSION LEVEL:**
- `adr-template.md` - Reference only, do not modify
- `ADR-*.md` (Accepted) - IMMUTABLE
- `ADR-*.md` (Proposed) - AI may assist in creation

---

## Documents

| Document | Purpose | Status |
|----------|---------|--------|
| `adr-template.md` | Template for new ADRs | Template |
| `ADR-000-record-architecture-decisions.md` | Meta-ADR establishing the process | Accepted |

---

## For AI Agents

### Before Proposing Architectural Changes

1. **Read all existing ADRs** to understand established patterns
2. **Check if a relevant ADR already exists** - follow it if so
3. **Propose a new ADR** only if no existing decision applies

### Creating a New ADR

When the human operator initiates the ADR Phase:

1. Use `adr-template.md` as the base
2. Assign the next sequential number (e.g., if ADR-005 exists, use ADR-006)
3. Fill out all sections based on discussion with operator
4. Present for human approval
5. Once accepted, create Work Order for ADR creation

### ADR Status Meanings

| Status | Meaning |
|--------|---------|
| Proposed | Under discussion, not yet binding |
| Accepted | Binding precedent, must be followed |
| Deprecated | No longer applicable, but preserved for history |
| Superseded by ADR-XXX | Replaced by newer decision |

### Referencing ADRs

When proposing solutions, reference relevant ADRs:
- "Per ADR-003, we should use the repository pattern"
- "ADR-005 established that we use JWT for authentication"

### Modifying ADRs

- **You CANNOT modify an Accepted ADR**
- To change a decision, create a NEW ADR that supersedes the old one
- The old ADR remains for historical reference

---

## Quick Reference

| Need | Action |
|------|--------|
| Understand past decisions | Read all ADR-*.md files |
| Propose new architecture | Ask operator to initiate ADR Phase |
| Create ADR | Use adr-template.md, assign next number |
| Change old decision | Create new ADR with status "Supersedes ADR-XXX" |
