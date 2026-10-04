# CHECKPOINT PROTOCOL

**Protocol on the Creation and Management of Development Checkpoints**

---

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Board for Standardization and Development

**Class:** 001-01/26-01
**Reference Number:** 251-01-01-26-04 (Rev. 1)
**Date:** 20.01.2026

SUBJECT: Checkpoint Protocol, Version 1.0

---

## CHAPTER I: PURPOSE

### **Article 1: Purpose**

(1) A Checkpoint is a formal milestone marker that captures the complete state of a project at a significant point in development.

(2) Checkpoints serve as:
- Phase completion certificates
- Historical reference points
- Rollback targets if needed
- Documentation of cumulative progress

(3) Checkpoints are IMMUTABLE after creation.

---

## CHAPTER II: MANDATORY TRIGGERS

### **Article 2: When to Create a Checkpoint**

(1) A Checkpoint MUST be created when:

| Trigger | Checkpoint Type |
|---------|-----------------|
| Development phase completed | Phase Checkpoint |
| Major version increment (X.0.0) | Version Checkpoint |
| ADR implementation finalized | ADR Checkpoint |
| Significant milestone reached | Milestone Checkpoint |
| Human operator requests | Manual Checkpoint |

(2) Checkpoint creation requires human approval.

---

## CHAPTER III: PRE-CHECKPOINT REQUIREMENTS

### **Article 3: Prerequisites**

(1) Before creating a checkpoint, the following MUST be verified:

- [ ] All phase tasks marked complete in PROJECT-ELABORATION.md
- [ ] All Work Orders for the phase are created and logged
- [ ] No unresolved Corrective Work Orders
- [ ] All tests passing
- [ ] Documentation updated via REVISION protocol
- [ ] Human approval obtained

(2) If any prerequisite is not met, checkpoint creation is BLOCKED.

### **Article 4: Knowledge Base Synchronization**

(1) Before checkpoint creation, update:
- PROJECT-ELABORATION.md (task status)
- DEVELOPMENT-PRACTICES.md (new learnings)
- GOTCHAS.md (discovered pitfalls)
- README.md (if user-facing changes)
- Relevant ADRs (if architectural changes)

(2) Each update requires a Work Order.

---

## CHAPTER IV: CHECKPOINT STRUCTURE

### **Article 5: Naming Convention**

(1) Format: `CP-[NNN]-PHASE-[X]-[DESCRIPTION].md`

(2) Examples:
- `CP-001-PHASE-1-FOUNDATION.md`
- `CP-002-PHASE-2-CORE-FEATURES.md`
- `CP-003-VERSION-1.0.0-RELEASE.md`
- `CP-004-ADR-005-DATABASE-MIGRATION.md`

### **Article 6: Required Sections**

(1) Every Checkpoint document MUST contain:

| Section | Content |
|---------|---------|
| Header | Checkpoint metadata (number, date, phase) |
| Summary Table | Quick reference of key metrics |
| Scope | What this checkpoint covers |
| Deliverables | What was completed |
| Work Orders | List of all WOs in this phase |
| Files Changed | Summary of file modifications |
| Issues Resolved | CWOs that were resolved |
| Outstanding Items | Any known issues carried forward |
| Test Results | Test coverage and pass rates |
| Next Phase | Preview of upcoming work |
| Approvals | Human sign-off |

---

## CHAPTER V: TEMPLATE

### **Article 7: Checkpoint Template**

```markdown
# Checkpoint [CP-NNN]

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Development Checkpoint Certificate

---

**Checkpoint Number:** CP-NNN
**Phase:** [Phase Name]
**Date:** YYYY-MM-DD
**Version:** X.Y.Z

---

## Summary Table

| Metric | Value |
|--------|-------|
| Work Orders Completed | XX |
| Corrective Orders Resolved | XX |
| Files Modified | XX |
| Tests Passing | XX/XX (100%) |
| Coverage | XX% |

---

## Scope

This checkpoint certifies the completion of **Phase X: [Phase Name]** as defined in PROJECT-ELABORATION.md.

### Phase Objectives
1. [Objective 1]
2. [Objective 2]
3. [Objective 3]

---

## Deliverables

### Completed Tasks

| Task | Work Order | Status |
|------|------------|--------|
| Task 1 description | WO-2026-001 | Complete |
| Task 2 description | WO-2026-002 | Complete |

### Key Implementations
- [Implementation 1]
- [Implementation 2]

---

## Work Orders

### Standard Work Orders
| ID | Subject | Executor | Date |
|----|---------|----------|------|
| WO-2026-001 | Subject | Executor | Date |

### Corrective Work Orders (Resolved)
| ID | Subject | Severity | Resolution |
|----|---------|----------|------------|
| CWO-2026-001 | Subject | High | Fixed via WO-2026-003 |

---

## Files Changed

### Created
- `path/to/new/file.rs`

### Modified
- `path/to/modified/file.rs` (+45, -12)

### Deleted
- `path/to/removed/file.rs`

---

## Issues

### Resolved in This Phase
- [Issue 1] - Fixed via CWO-2026-001
- [Issue 2] - Fixed via CWO-2026-002

### Outstanding (Carried Forward)
- [Issue 3] - Tracked in Phase X+1, Point Y

---

## Test Results

**Test Suite:** [Test framework used]
**Total Tests:** XX
**Passed:** XX
**Failed:** 0
**Coverage:** XX%

```
[Test output summary]
```

---

## Next Phase Preview

**Phase X+1: [Next Phase Name]**

Key objectives:
1. [Objective 1]
2. [Objective 2]

---

## Approvals

**Prepared By:** [AI Assistant / Operator Name]
**Date:** YYYY-MM-DD

**Approved By:** [Operator Name]
**Date:** YYYY-MM-DD

---

**STATUS: CERTIFIED**

This checkpoint is now IMMUTABLE. Any corrections require a new Corrective Work Order referencing this checkpoint.
```

---

## CHAPTER VI: CREATION PROCEDURE

### **Article 8: Checkpoint Creation Steps**

(1) The checkpoint creation procedure:

1. **Verification Phase**
   - Verify all prerequisites (Article 3)
   - Run full test suite
   - Generate coverage report

2. **Documentation Phase**
   - Update all relevant documents
   - Create Work Orders for updates
   - Compile list of phase Work Orders

3. **Creation Phase**
   - Fill out checkpoint template
   - Include all required sections
   - Calculate summary metrics

4. **Approval Phase**
   - Present checkpoint to human operator
   - Obtain explicit approval
   - Record approval in document

5. **Finalization Phase**
   - Save checkpoint to CHECKPOINTS/
   - Update registry.json
   - Create Work Order for checkpoint creation
   - Mark phase complete in PROJECT-ELABORATION.md

### **Article 9: Post-Checkpoint Actions**

(1) After checkpoint creation:
- The phase is officially closed
- No further changes to phase scope
- Any new work goes in next phase
- The checkpoint document is IMMUTABLE

---

## CHAPTER VII: IMMUTABILITY

### **Article 10: Checkpoint Immutability**

(1) Once created, a Checkpoint CANNOT be modified.

(2) If an error is discovered in a Checkpoint:
- Create a CWO referencing the checkpoint
- Document the correction in the CWO
- Do NOT modify the original checkpoint

(3) Checkpoints may be referenced but never edited.

---

## CHAPTER VIII: FINAL PROVISIONS

### **Article 11: File Storage**

(1) Checkpoints are stored in:
`PROJECT-INTERNAL/CHECKPOINTS/CP-NNN-PHASE-X-DESCRIPTION.md`

(2) The template is located at:
`PROJECT-INTERNAL/CHECKPOINTS/checkpoint-template.md`

### **Article 12: Entry Into Force**

(1) This protocol is binding for all checkpoint creation under TEJL governance.

(2) It supplements AI-INSTRUCTIONS.md Article 13.

---

**Compiled by:**
AI Assistant, System Integration Sector

**Approved by:**
Operator, Board for Standardization and Development of TEJL
