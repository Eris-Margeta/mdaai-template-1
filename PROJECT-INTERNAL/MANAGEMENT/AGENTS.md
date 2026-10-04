# AGENTS.md - Management Navigation

<!-- Parent: ../../AGENTS.md -->

This directory contains **project planning documents** that guide development.

---

## Directory Purpose

The MANAGEMENT folder contains the strategic planning documents that define WHAT work is authorized and WHEN it should happen.

**PERMISSION LEVEL:**
- `PROJECT-ELABORATION.md` - AI can modify (per Article 10 rules)
- Other documents - AI cannot modify

---

## Documents

| Document | Purpose | AI Modifiable |
|----------|---------|---------------|
| `PROJECT-ELABORATION.md` | The Backlog - authorized tasks | Yes (limited) |
| `VISION.md` | Long-term project direction | No |
| `ROADMAP.md` | Timeline and milestones | No |
| `PROJECT-RULES.md` | Project-specific hard rules | **NO** |
| `ENVIRONMENT.md` | System environment details | **NO** |

---

## For AI Agents

### PROJECT-ELABORATION.md

This is your **primary work source**. Before starting any work:
1. Read this document to find authorized tasks
2. Identify the current phase and point
3. Work ONLY on authorized tasks

**Modification Rules:**
- You CAN mark tasks as `[x]` complete
- You CAN add Work Order references to completed tasks
- You CANNOT add new tasks (unless in REVISION Phase)
- You CANNOT reorder tasks (unless in REVISION Phase)
- You CANNOT move items between phases

### During REVISION Phase

When the human operator initiates a REVISION Phase:
1. You may propose restructuring
2. You may suggest new tasks
3. You may recommend priority changes
4. All changes require human approval
5. Document changes via Work Order

### Other Documents

- `VISION.md` - Read for context, do not modify
- `ROADMAP.md` - Read for timeline awareness, do not modify
- `PROJECT-RULES.md` - **MANDATORY READ** - Project-specific hard rules
- `ENVIRONMENT.md` - **READ BEFORE SYSTEM OPERATIONS** - Environment details

### PROJECT-RULES.md

This document contains **project-specific hard rules** that supplement global governance. These are BINDING rules specific to this project:
- Coding protocols
- Testing requirements
- Security rules
- Architecture constraints

### ENVIRONMENT.md

This document grounds AI agents to the actual system environment:
- Current date (use for Work Orders)
- Development environment (OS, machine, tools)
- Deployment environment (target server)
- Access commands (SSH, etc.)
- Environment variables

**Read this BEFORE performing any system operations.**

---

## Quick Reference

| Need | Action |
|------|--------|
| Find next task | Read `PROJECT-ELABORATION.md`, find first unchecked item |
| Mark task complete | Change `[ ]` to `[x]`, add Work Order reference |
| Suggest new work | Document in NOTES.md, request human add to backlog |
| Check timeline | Read `ROADMAP.md` |
| Project-specific rules | Read `PROJECT-RULES.md` |
| System environment | Read `ENVIRONMENT.md` |
