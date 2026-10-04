# AGENTS.md - Governance Navigation

<!-- Parent: ../../AGENTS.md -->

This directory contains the **immutable governance documents** that define AI behavior.

---

## Directory Purpose

The GOVERNANCE folder contains the "Constitution" of this project - the binding rules that ALL AI agents must follow without exception.

**PERMISSION LEVEL:** IMMUTABLE - AI agents CANNOT modify these files.

---

## Documents

| Document | Purpose | Read Order |
|----------|---------|------------|
| `AI-INSTRUCTIONS.md` | The Constitution - all binding rules | 1st (MANDATORY) |
| `LIFECYCLE-PHASES-PROTOCOL.md` | Project lifecycle phases and requirements | 2nd (MANDATORY) |
| `MULTI-AGENT-PROTOCOL.md` | Rules for parallel agent execution | 3rd (if multi-agent) |
| `BETA-PHASE-PROTOCOL.md` | Error handling & testing in Beta | If Beta phase |
| `WORK-ORDER-PROTOCOL.md` | How to create Work Orders | Reference |
| `CHECKPOINT-PROTOCOL.md` | How to create Checkpoints | Reference |
| `DOCUMENTATION-PROTOCOL.md` | Public documentation rules | Reference |

---

## For AI Agents

### CRITICAL REQUIREMENTS

1. **You MUST read AI-INSTRUCTIONS.md before any work**
2. **You CANNOT modify any file in this directory**
3. **All articles in these documents are BINDING**
4. **Protocol violations require Corrective Work Orders**

### If Operating in Multi-Agent Mode

Read `MULTI-AGENT-PROTOCOL.md` after `AI-INSTRUCTIONS.md`.

### Quick Reference

- Work Order creation → `WORK-ORDER-PROTOCOL.md`
- Checkpoint creation → `CHECKPOINT-PROTOCOL.md`
- Lifecycle phases → `LIFECYCLE-PHASES-PROTOCOL.md`
- Beta error workflow → `BETA-PHASE-PROTOCOL.md`
- Error handling → `AI-INSTRUCTIONS.md` Article 7
- Document permissions → `AI-INSTRUCTIONS.md` Article 9
- Lifecycle awareness → `AI-INSTRUCTIONS.md` Articles 18-19

---

## Modification Policy

These documents may ONLY be modified:
- By human operators
- During formal REVISION phase
- With explicit human approval
- Via documented Work Order

AI-initiated modifications are PROHIBITED.
