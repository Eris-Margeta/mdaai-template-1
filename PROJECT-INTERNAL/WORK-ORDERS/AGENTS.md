# AGENTS.md - Work Orders Navigation

<!-- Parent: ../../AGENTS.md -->

This directory contains the **audit trail** of all development work.

---

## Directory Purpose

The WORK-ORDERS folder maintains an immutable record of all work performed. Every completed task, every error resolved, every change made is documented here.

**PERMISSION LEVEL:**
- `registry.json` - AI can UPDATE (add entries, not modify existing)
- `WO-*.md` files - IMMUTABLE after creation
- `CWO-*.md` files - IMMUTABLE after creation
- Templates - Reference only

---

## Structure

```
WORK-ORDERS/
├── registry.json              # Index of all work orders
├── work-order-template.md     # Template for standard WOs
├── WO-2026-001-*.md           # Standard work orders
├── WO-2026-002-*.md
├── CORRECTIVE/                # Corrective work orders
│   ├── corrective-work-order-template.md
│   ├── CWO-2026-001-*.md
│   └── CWO-2026-002-*.md
└── DIAGNOSTIC/                # Diagnostic work orders
    └── DWO-2026-001-*.md
```

---

## For AI Agents

### Before Creating a Work Order

1. **Read registry.json** - Get the next sequence number
2. **Reserve the number** - Update registry.json with status "reserved"
3. **Create the Work Order** - Use the appropriate template
4. **Update registry.json** - Change status to "complete"

### Multi-Agent Coordination

If multiple agents are working:
1. Check registry.json for reserved numbers
2. Claim an unreserved sequence number
3. Update registry.json IMMEDIATELY
4. If conflict, STOP and notify orchestrator

### Creating Work Orders

**When to create WO:**
- Task completed from PROJECT-ELABORATION.md
- Significant code change (>10 lines)
- New file created
- File deleted
- Documentation updated

**When to create CWO:**
- Error encountered and resolved
- Protocol violation corrected
- Unexpected behavior fixed

### Registry Entry Format

```json
{
  "id": "WO-2026-001",
  "type": "standard",
  "date": "2026-01-20",
  "subject": "Description",
  "taskRef": "Phase 1, Point 1.1",
  "executor": "Eris Margeta",
  "status": "complete",
  "filesChanged": 5,
  "timeActual": "2h 15m"
}
```

### File Naming

- Standard: `WO-YYYY-NNN-short-description.md`
- Corrective: `CORRECTIVE/CWO-YYYY-NNN-short-description.md`
- Diagnostic: `DIAGNOSTIC/DWO-YYYY-NNN-short-description.md`

---

## Immutability Rules

1. **Never modify a completed Work Order**
2. **Never delete a Work Order**
3. **To correct an error in a WO, create a CWO referencing it**
4. **Voided WOs are marked VOID but not deleted**

---

## Quick Reference

| Task | Action |
|------|--------|
| Start work | Reserve sequence in registry.json |
| Complete work | Create WO, update registry.json |
| Hit error | Create CWO, update KNOWLEDGE/ |
| Void a WO | Mark status as VOID (do not delete) |
