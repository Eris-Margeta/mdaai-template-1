# WORK ORDER PROTOCOL

**Protocol on the Creation and Management of Work Orders**

---

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Board for Standardization and Development

**Class:** 001-01/26-01
**Reference Number:** 251-01-01-26-03 (Rev. 1)
**Date:** 20.01.2026

SUBJECT: Work Order Protocol, Version 1.0

---

## CHAPTER I: PURPOSE

### **Article 1: Purpose**

(1) Work Orders create an immutable audit trail of all development activity.

(2) Every significant action MUST be documented via a Work Order.

(3) Work Orders serve as:
- Historical record of all changes
- Verification that work was authorized
- Accountability mechanism for AI and human operators
- Input for project metrics and analysis

---

## CHAPTER II: WORK ORDER TYPES

### **Article 2: Standard Work Order (WO)**

(1) A Standard Work Order documents successful completion of authorized work.

(2) Use for:
- Completed tasks from PROJECT-ELABORATION.md
- Bug fixes
- New file creation
- Significant code changes
- Knowledge document updates

### **Article 3: Corrective Work Order (CWO)**

(1) A Corrective Work Order documents error handling and resolution.

(2) Use for:
- Errors encountered during development
- Protocol violations and their correction
- Unexpected behavior and fixes
- Failed attempts that required retry

(3) CWOs MUST include root cause analysis and prevention measures.

### **Article 4: Diagnostic Work Order (DWO)**

(1) A Diagnostic Work Order documents investigation activity.

(2) Use for:
- Root cause analysis of complex issues
- Performance investigation
- Security audits
- Pre-implementation research

---

## CHAPTER III: WHEN TO CREATE

### **Article 5: Mandatory Triggers**

(1) A Work Order MUST be created for:

| Event | Work Order Type |
|-------|-----------------|
| Task from backlog completed | Standard (WO) |
| Bug fixed | Standard (WO) |
| Error encountered and resolved | Corrective (CWO) |
| Protocol violation self-corrected | Corrective (CWO) |
| New file created | Standard (WO) |
| File deleted | Standard (WO) |
| Significant refactoring | Standard (WO) |
| Knowledge document updated | Standard (WO) |
| ADR created or updated | Standard (WO) |
| Checkpoint created | Standard (WO) |

(2) Failure to create a required Work Order is a protocol violation.

### **Article 5a: Project Elaboration Synchronization**

(1) Every Work Order completion MUST include a review of `PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md`.

(2) If the completed work changes roadmap state, phase completion, active priorities, authorized backlog, or implementation sequencing, `PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md` MUST be updated in the same Work Order or in an immediately following documentation Work Order.

(3) If the completed work has no roadmap impact, the Work Order MUST explicitly state: "Project Elaboration reviewed; no roadmap update required."

(4) A Work Order that leaves the Project Elaboration document stale is incomplete.

---

## CHAPTER IV: WORK ORDER STRUCTURE

### **Article 6: Numbering**

(1) Format: `[TYPE]-[YEAR]-[SEQUENCE]-[SHORT-DESCRIPTION]`

(2) Examples:
- `WO-2026-001-implement-user-auth`
- `WO-2026-015-add-database-migration`
- `CWO-2026-003-fix-null-pointer`
- `CWO-2026-007-protocol-violation-missing-wo`
- `DWO-2026-001-investigate-memory-leak`

(3) Sequence numbers:
- Are unique across all Work Order types
- Must be claimed via registry.json before use
- Cannot have gaps (except for voided orders)

### **Article 7: Required Fields**

(1) Every Work Order MUST contain:

| Field | Description |
|-------|-------------|
| Class | Classification code from project-meta.yaml |
| Reference Number | Unique sequential reference |
| Date | Date of creation (YYYY-MM-DD) |
| Executor | Operator name or AI model identifier |
| Subject | One-line description of work |
| Task Reference | Link to PROJECT-ELABORATION.md task |
| Description | Detailed description of work performed |
| Files Changed | Table of files with actions and line counts |
| Tests | Test status (pass/fail) |
| Time Expenditure | Estimated vs actual time |
| Status | COMPLETE, PENDING, VOID |

(2) Corrective Work Orders additionally require:

| Field | Description |
|-------|-------------|
| Incident Type | Error / Protocol Violation / Unexpected Behavior |
| Severity | Critical / High / Medium / Low |
| Root Cause | Analysis of why it happened |
| Prevention Measures | What was done to prevent recurrence |
| Knowledge Updates | Which KNOWLEDGE/ docs were updated |

---

## CHAPTER V: TEMPLATES

### **Article 8: Standard Work Order Template**

```markdown
# Work Order [WO-YYYY-NNN]

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Work Order Registry

---

**Class:** [XXX-XX/YY-XX]
**Reference Number:** [XXX-XX-XX-YY-XX]
**Date:** [YYYY-MM-DD]
**Executor:** [Operator Name or AI Model]

---

## Subject

[One-line description of work performed]

## Authorization

**Task Reference:** PROJECT-ELABORATION.md, Phase X, Point Y.Z
**Authorized By:** [Human name or "Backlog"]

## Description

[Detailed description of work performed]

## Files Changed

| File | Action | Lines Changed |
|------|--------|---------------|
| path/to/file.rs | Modified | +45, -12 |
| path/to/new.rs | Created | +120 |

## Tests

- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] No regressions introduced

## Verification

**Build Status:** [Pass/Fail]
**Test Status:** [Pass/Fail]
**Manual Verification:** [Description if applicable]

## Time Expenditure

**Estimated:** [from backlog or Xh Ym]
**Actual:** [Xh Ym]

## Notes

[Any additional observations or recommendations]

---

**Status:** COMPLETE
**Registry Updated:** Yes
```

### **Article 9: Corrective Work Order Template**

```markdown
# Corrective Work Order [CWO-YYYY-NNN]

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Corrective Action Registry

---

**Class:** [XXX-XX/YY-XX]
**Reference Number:** [XXX-XX-XX-YY-XX]
**Date:** [YYYY-MM-DD]
**Executor:** [Operator Name or AI Model]

---

## Incident Classification

**Type:** [Error / Protocol Violation / Unexpected Behavior]
**Severity:** [Critical / High / Medium / Low]
**Discovery Method:** [During testing / During development / User report]

## Incident Description

[What went wrong]

## Context

**Related Work Order:** [WO-YYYY-NNN if applicable]
**Task Reference:** [PROJECT-ELABORATION.md reference if applicable]

## Root Cause Analysis

[Why it went wrong - be specific and honest]

## Corrective Actions Taken

| Action | Status |
|--------|--------|
| [Action 1] | Complete |
| [Action 2] | Complete |

## Prevention Measures

[What was done to prevent recurrence]

## Knowledge Base Updates

- [ ] GOTCHAS.md updated (if applicable)
- [ ] ERROR-CATALOG.md updated (if applicable)
- [ ] DEVELOPMENT-PRACTICES.md updated (if applicable)

## Verification

**Issue Resolved:** [Yes/No]
**Tests Added:** [Yes/No]
**Regression Verified:** [Yes/No]

---

**Status:** RESOLVED
**Registry Updated:** Yes
```

---

## CHAPTER VI: REGISTRY

### **Article 10: Registry File**

(1) All Work Orders MUST be logged to `PROJECT-INTERNAL/WORK-ORDERS/registry.json`.

(2) Registry structure:

```json
{
  "project": "project-name",
  "lastUpdated": "2026-01-20T14:30:00Z",
  "nextSequence": 10,
  "workOrders": [
    {
      "id": "WO-2026-001",
      "type": "standard",
      "date": "2026-01-20",
      "subject": "Implement user authentication",
      "taskRef": "Phase 1, Point 3",
      "executor": "Eris Margeta",
      "status": "complete",
      "filesChanged": 5,
      "timeActual": "2h 15m"
    }
  ],
  "statistics": {
    "totalWorkOrders": 45,
    "totalCorrectiveOrders": 8,
    "correctiveRate": "17.8%"
  }
}
```

(3) Registry MUST be updated immediately after Work Order creation.

---

## CHAPTER VII: IMMUTABILITY

### **Article 11: Work Order Immutability**

(1) Once created, a Work Order CANNOT be modified.

(2) If an error is discovered in a Work Order:
- Create a new CWO referencing the erroneous WO
- Mark the original as referenced by the CWO
- Do NOT modify the original

(3) Voided Work Orders:
- Mark status as VOID
- Include reason for voiding
- Do NOT delete the file

---

## CHAPTER VIII: FINAL PROVISIONS

### **Article 12: File Storage**

(1) Work Orders are stored in:
- Standard: `PROJECT-INTERNAL/WORK-ORDERS/WO-YYYY-NNN-description.md`
- Corrective: `PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/CWO-YYYY-NNN-description.md`
- Diagnostic: `PROJECT-INTERNAL/WORK-ORDERS/DIAGNOSTIC/DWO-YYYY-NNN-description.md`

(2) Create subdirectories if they don't exist.

### **Article 13: Entry Into Force**

(1) This protocol is binding for all Work Order creation under TEJL governance.

(2) It supplements AI-INSTRUCTIONS.md Article 5 and Article 6.

---

**Compiled by:**
AI Assistant, System Integration Sector

**Approved by:**
Operator, Board for Standardization and Development of TEJL
