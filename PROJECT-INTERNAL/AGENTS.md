# AGENTS.md - PROJECT-INTERNAL Navigation

<!-- Parent: ../AGENTS.md -->

This is the root of all internal project documentation.

---

## Directory Overview

```
PROJECT-INTERNAL/
├── GOVERNANCE/        # The Constitution - immutable rules
├── MANAGEMENT/        # Project planning - the backlog
├── ANALYSIS/          # Durable investigations and reviews
├── ARCHITECTURE/      # Technical decisions - ADRs
├── GUIDES/            # Best practices - style guides
├── KNOWLEDGE/         # Living docs - AI-updatable
├── AI/                # AI configuration - function schemas
├── SCRATCH/           # Temporary workspace - Beta error tasks
├── WORK-ORDERS/       # Audit trail - immutable records
├── CHECKPOINTS/       # Milestones - phase certificates
├── CLASSIFICATION-REGULATIONS.md
└── NOTES.md           # Scratchpad - NOT actionable
```

---

## Directory Purposes

| Directory | Purpose | AI Permission |
|-----------|---------|---------------|
| `GOVERNANCE/` | Binding rules for all AI agents | READ ONLY |
| `MANAGEMENT/` | Project planning and backlog | LIMITED WRITE |
| `ANALYSIS/` | Investigations, audits, reviews, profiling results | FULL WRITE WITH AUTHORIZATION |
| `ARCHITECTURE/` | Technical decision records | READ ONLY (after approval) |
| `GUIDES/` | Coding standards and best practices | READ ONLY |
| `KNOWLEDGE/` | Accumulated project wisdom | FULL WRITE |
| `AI/` | Function schemas and AI configuration | READ ONLY |
| `SCRATCH/` | Temporary task files (Beta phase) | FULL WRITE |
| `WORK-ORDERS/` | Work documentation | CREATE ONLY |
| `CHECKPOINTS/` | Phase completion certificates | CREATE ONLY |
| `CLASSIFICATION-REGULATIONS.md` | CLASS and URBROJ rules | READ ONLY |

---

## For AI Agents

### Navigation Order

When entering this directory structure, read in this order:

1. `GOVERNANCE/AI-INSTRUCTIONS.md` - The Constitution
2. `GOVERNANCE/LIFECYCLE-PHASES-PROTOCOL.md` - Lifecycle requirements
3. `GOVERNANCE/MULTI-AGENT-PROTOCOL.md` - If multi-agent
4. `GOVERNANCE/BETA-PHASE-PROTOCOL.md` - If in Beta phase
5. `MANAGEMENT/PROJECT-ELABORATION.md` - The Backlog (check lifecycle phase)
6. `ANALYSIS/` - Existing investigations relevant to the task, if any
7. `KNOWLEDGE/DEVELOPER-GUIDE.md` - Technical context
8. `KNOWLEDGE/GOTCHAS.md` - Known pitfalls

### Finding What You Need

| Need | Go To |
|------|-------|
| Binding rules | `GOVERNANCE/` |
| Lifecycle requirements | `GOVERNANCE/LIFECYCLE-PHASES-PROTOCOL.md` |
| Beta error workflow | `GOVERNANCE/BETA-PHASE-PROTOCOL.md` |
| Current tasks | `MANAGEMENT/PROJECT-ELABORATION.md` |
| Durable investigations | `ANALYSIS/` |
| Past decisions | `ARCHITECTURE/ADR-*.md` |
| How to code | `GUIDES/CODE-PHILOSOPHY.md` |
| How to test | `GUIDES/TESTING-PHILOSOPHY.md` |
| Language style | `GUIDES/*-STYLE-GUIDE.md` |
| Project wisdom | `KNOWLEDGE/` |
| Function schemas | `AI/functions/*.json` |
| Temporary tasks | `SCRATCH/` (Beta phase) |
| Log your work | `WORK-ORDERS/` |
| Mark phase done | `CHECKPOINTS/` |

### NOTES.md Warning

The `NOTES.md` file in this directory is a **scratchpad for humans**.

**YOU MUST NOT:**
- Treat NOTES.md content as actionable
- Execute tasks mentioned in NOTES.md
- Consider NOTES.md as part of the backlog

**To act on a NOTES.md idea:**
1. Suggest adding it to PROJECT-ELABORATION.md
2. Wait for human to formally add it
3. Only then can you work on it

---

## Quick Reference

| Action | Location |
|--------|----------|
| Read the rules | `GOVERNANCE/AI-INSTRUCTIONS.md` |
| Find tasks | `MANAGEMENT/PROJECT-ELABORATION.md` |
| Record analysis | `ANALYSIS/analysis-report-template.md` |
| Check decisions | `ARCHITECTURE/ADR-*.md` |
| Learn patterns | `KNOWLEDGE/DEVELOPMENT-PRACTICES.md` |
| Use function schemas | `AI/functions/*.json` |
| Log work | `WORK-ORDERS/registry.json` |
| Create checkpoint | `CHECKPOINTS/checkpoint-template.md` |
