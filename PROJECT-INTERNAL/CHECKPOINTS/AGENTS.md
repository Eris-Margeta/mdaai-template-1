# AGENTS.md - Checkpoints Navigation

<!-- Parent: ../../AGENTS.md -->

This directory contains **milestone certificates** - immutable records of completed phases.

---

## Directory Purpose

The CHECKPOINTS folder contains formal certificates marking the completion of development phases and milestones. Once created, checkpoints are IMMUTABLE.

**PERMISSION LEVEL:**
- `checkpoint-template.md` - Reference only (template)
- `CP-*.md` files - IMMUTABLE after creation

---

## Structure

```
CHECKPOINTS/
├── checkpoint-template.md    # Template for new checkpoints
├── CP-001-PHASE-1-*.md       # Phase 1 completion
├── CP-002-PHASE-2-*.md       # Phase 2 completion
└── ...
```

---

## For AI Agents

### When to Create a Checkpoint

Create a checkpoint when:
1. A development phase (from PROJECT-ELABORATION.md) is complete
2. A major version increment occurs (X.0.0)
3. An ADR implementation is finalized
4. The human operator explicitly requests one

### Prerequisites (MUST verify before creating)

- [ ] All phase tasks marked complete in PROJECT-ELABORATION.md
- [ ] All Work Orders for the phase are created and logged
- [ ] No unresolved Corrective Work Orders
- [ ] All tests passing
- [ ] Documentation updated via REVISION protocol
- [ ] Human approval obtained

### Creation Procedure

1. **Verify prerequisites** - Do NOT proceed if any are unmet
2. **Use template** - Copy `checkpoint-template.md`
3. **Fill all sections** - Follow the embedded AI instructions
4. **Name correctly** - `CP-NNN-PHASE-X-DESCRIPTION.md`
5. **Get approval** - Present to human for sign-off
6. **Create Work Order** - Log the checkpoint creation

### Checkpoint Numbering

- Sequential: CP-001, CP-002, CP-003
- No gaps allowed
- Check existing checkpoints to find next number

### Naming Convention

Format: `CP-NNN-TYPE-DESCRIPTION.md`

Examples:
- `CP-001-PHASE-1-FOUNDATION.md`
- `CP-002-PHASE-2-CORE-FEATURES.md`
- `CP-003-VERSION-1.0.0-RELEASE.md`
- `CP-004-ADR-005-AUTH-IMPLEMENTATION.md`

---

## Immutability

**Checkpoints CANNOT be modified after creation.**

If an error is discovered:
1. Create a CWO referencing the checkpoint
2. Document the correction in the CWO
3. Do NOT modify the checkpoint document

---

## Quick Reference

| Need | Action |
|------|--------|
| Create checkpoint | Verify prerequisites, use template, get approval |
| Find checkpoint template | Use `checkpoint-template.md` |
| Check phase status | Read `PROJECT-ELABORATION.md` |
| Fix checkpoint error | Create CWO, do NOT modify checkpoint |
