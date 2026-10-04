# BETA PHASE PROTOCOL

**Protocol on Beta Phase Error Handling and Quality Assurance Workflows**

---

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Board for Standardization and Development

**Class:** 001-01/26-01
**Reference Number:** 251-01-01-26-08 (Rev. 1)
**Date:** 20.01.2026

SUBJECT: Beta Phase Protocol, Version 1.0

---

## CHAPTER I: PURPOSE AND SCOPE

### **Article 1: Purpose**

(1) This protocol defines **mandatory workflows** for the Beta lifecycle phase.

(2) Beta phase is characterized by:
- Full quality standards enforcement
- Comprehensive testing requirements
- Tight documentation coupling
- Rigorous error handling procedures

(3) This protocol supplements LIFECYCLE-PHASES-PROTOCOL.md with detailed Beta-specific procedures.

### **Article 2: Scope**

(1) This protocol applies to:
- All development work during Beta phase
- All error resolution activities
- All testing activities
- All documentation coupling verification

(2) **Regression is PROHIBITED.** Once in Beta, you cannot revert to Alpha-level practices.

---

## CHAPTER II: ERROR HANDLING WORKFLOW

### **Article 3: The Error Handling Principle**

(1) **In Beta phase, errors are opportunities for systematic improvement.**

(2) **CRITICAL RULE:** Never wire-fix. Never patch symptoms. Always address root cause.

(3) **Every error triggers the Error Resolution Workflow (Article 4).**

### **Article 4: Error Resolution Workflow**

(1) When an error is discovered during Beta phase, the following workflow is **MANDATORY**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        BETA ERROR RESOLUTION WORKFLOW                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  1. STOP - Do NOT immediately fix the error                                 │
│     │                                                                        │
│     ▼                                                                        │
│  2. ANALYZE - Investigate root cause IN DEPTH                               │
│     │         ├─ What is the actual cause?                                  │
│     │         ├─ Why did this happen?                                       │
│     │         └─ Is this a symptom of a larger issue?                       │
│     ▼                                                                        │
│  3. DOCUMENT - Create task file in PROJECT-INTERNAL/SCRATCH/                │
│     │          ├─ Root cause analysis                                       │
│     │          ├─ Steps to reproduce                                        │
│     │          └─ Planned fix approach                                      │
│     ▼                                                                        │
│  4. TEST CHECK - Does a test exist for this kind of issue?                  │
│     │                                                                        │
│     ├─ NO TEST EXISTS ────────────────────────────────────┐                 │
│     │   │                                                  │                 │
│     │   ▼                                                  │                 │
│     │   4a. Create UNIVERSAL test                          │                 │
│     │       (Not hardcoded to this specific case)          │                 │
│     │       │                                              │                 │
│     │       ▼                                              │                 │
│     │   4b. Run test - MUST FAIL                           │                 │
│     │       (Proves test catches the issue)                │                 │
│     │                                                      │                 │
│     ├─ TEST EXISTS ───────────────────────────────────────┐│                 │
│     │   │                                                  ││                 │
│     │   ▼                                                  ││                 │
│     │   4c. Review test adequacy                           ││                 │
│     │       └─ Improve if needed                           ││                 │
│     │       │                                              ││                 │
│     │       ▼                                              ││                 │
│     │   4d. Run test - SHOULD FAIL                         ││                 │
│     │       (If passes, test is inadequate)                ││                 │
│     │                                                      ││                 │
│     └─────────────────────────────────────────────────────┴┘                 │
│     │                                                                        │
│     ▼                                                                        │
│  5. FIX - NOW implement the fix                                             │
│     │                                                                        │
│     ▼                                                                        │
│  6. VERIFY - Run test - MUST PASS                                           │
│     │                                                                        │
│     ▼                                                                        │
│  7. REGRESSION - Run full test suite                                        │
│     │                                                                        │
│     ▼                                                                        │
│  8. CLEANUP - Delete SCRATCH task file                                      │
│     │                                                                        │
│     ▼                                                                        │
│  9. DOCUMENT - Create Corrective Work Order (CWO)                           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

(2) **Skipping any step is a protocol violation.**

### **Article 5: Root Cause Analysis Requirements**

(1) Root cause analysis MUST answer:
- What is the immediate cause of the error?
- What is the underlying/systemic cause?
- Why wasn't this caught earlier?
- Could similar issues exist elsewhere?

(2) **Surface-level fixes are PROHIBITED.** Examples:

| Surface Fix (WRONG) | Root Cause Fix (CORRECT) |
|---------------------|--------------------------|
| Add null check here | Ensure data validation at source |
| Catch exception and ignore | Fix condition causing exception |
| Add timeout retry | Fix why operation hangs |
| Hardcode workaround | Fix architectural issue |

### **Article 6: SCRATCH File Requirements**

(1) Every error resolution MUST have a SCRATCH task file.

(2) Task file location: `PROJECT-INTERNAL/SCRATCH/TASK-{description}.md`

(3) Task file MUST contain:
- Error description
- Root cause analysis
- Step-by-step fix plan
- Test strategy

(4) Task file MUST be deleted after resolution.

(5) **Rationale:** This protects against power outages, context loss, and ensures systematic tracking.

---

## CHAPTER III: TESTING REQUIREMENTS

### **Article 7: Universal Test Principle**

(1) **Tests MUST be universal, not hardcoded to specific cases.**

(2) Example:

```
BAD (hardcoded):
  test("user with ID 42 should not cause error")

GOOD (universal):
  test("users with special characters in name are handled correctly")
  test("edge case: empty input returns validation error")
```

(3) A test should catch a CLASS of issues, not just one specific instance.

### **Article 8: Test-First Verification**

(1) Before fixing an issue, the test MUST fail.

(2) This proves:
- The test actually catches the issue
- The fix will be verifiable
- We're not testing something else

(3) **If a test passes before the fix, the test is inadequate.**

### **Article 9: Test Coverage in Beta**

(1) Beta phase requires comprehensive test coverage:

| Test Type | Requirement |
|-----------|-------------|
| Unit Tests | All public functions |
| Integration Tests | All component interactions |
| E2E Tests | All user-facing workflows |
| Error Cases | All error handling paths |

(2) New features CANNOT be merged without corresponding tests.

(3) **Coverage is measured by BEHAVIOR, not lines.** 100% line coverage with poor test design is worthless.

---

## CHAPTER IV: SELF-CORRECTION

### **Article 10: Task-Level Self-Correction**

(1) After completing EACH task in Beta phase:

```
┌─────────────────────────────────────────────────────────┐
│              TASK COMPLETION CHECKLIST                   │
├─────────────────────────────────────────────────────────┤
│  [ ] Change follows CODE-PHILOSOPHY.md                  │
│  [ ] Tests exist for new/changed functionality          │
│  [ ] Tests pass                                         │
│  [ ] Inline documentation is accurate                   │
│  [ ] No temporary/debug code left behind                │
│  [ ] No hardcoded values that should be configurable    │
└─────────────────────────────────────────────────────────┘
```

(2) AI may batch some verifications but ALL must be verified by phase end.

### **Article 11: Phase-Level Self-Correction**

(1) At the END of each Beta phase:

```
┌─────────────────────────────────────────────────────────┐
│               PHASE COMPLETION CHECKLIST                 │
├─────────────────────────────────────────────────────────┤
│  [ ] All PROJECT-INTERNAL/ docs synchronized            │
│  [ ] All KNOWLEDGE/ documents current                   │
│  [ ] All tests written and passing                      │
│  [ ] Public documentation reflects reality              │
│  [ ] README.md current                                  │
│  [ ] CHANGELOG.md updated                               │
│  [ ] No protocol deviations                             │
│  [ ] SCRATCH folder empty                               │
│  [ ] No temporary files/caches                          │
└─────────────────────────────────────────────────────────┘
```

(2) **Phase CANNOT complete until all items checked.**

---

## CHAPTER V: DOCUMENTATION COUPLING

### **Article 12: Tight Coupling Requirement**

(1) In Beta phase, code and documentation MUST remain synchronized.

(2) **Every code change with user-facing impact requires documentation update in the SAME Work Order.**

(3) Coupling verification happens:
- After each task (light check)
- After each phase (full check)

### **Article 13: Documentation Coupling Checklist**

(1) After code changes, verify:

| Changed | Verify |
|---------|--------|
| Public API | API documentation updated |
| CLI flags | CLI help and docs updated |
| Config options | Configuration guide updated |
| Error messages | Troubleshooting docs updated |
| Dependencies | Installation docs updated |

(2) **Undocumented changes are incomplete changes.**

---

## CHAPTER VI: CLEANUP REQUIREMENTS

### **Article 14: Cache and Temporary File Cleanup**

(1) Beta phase requires a clean working environment.

(2) **Delete after use:**
- Test caches (`.pytest_cache/`, `__pycache__/`, etc.)
- Build caches (`target/`, `dist/`, `build/`)
- Coverage reports (after review)
- Debug logs
- Temporary outputs
- IDE caches not in .gitignore

(3) **Do NOT litter the file system.** Clean as you go.

### **Article 15: SCRATCH Folder Hygiene**

(1) SCRATCH folder should be empty at phase end.

(2) Long-lived SCRATCH files indicate incomplete work.

(3) **Exception:** `AGENTS.md` and `.gitkeep` are permanent.

---

## CHAPTER VII: FINAL PROVISIONS

### **Article 16: Corrective Work Orders**

(1) Every error resolved via this workflow MUST have a CWO.

(2) CWO MUST include:
- Reference to the original error
- Root cause analysis summary
- Test created/improved
- Fix implemented
- Verification that tests pass

### **Article 17: Protocol Violations**

(1) Violations of this protocol include:
- Fixing errors without root cause analysis
- Skipping test creation/verification
- Leaving SCRATCH files undeleted
- Incomplete documentation coupling
- Committing without test verification

(2) All violations require immediate correction and a CWO documenting the violation.

### **Article 18: Entry Into Force**

(1) This protocol is binding for all Beta phase work.

(2) It supplements LIFECYCLE-PHASES-PROTOCOL.md and AI-INSTRUCTIONS.md.

---

**Compiled by:**
AI Assistant, System Integration Sector

**Approved by:**
Operator, Board for Standardization and Development of TEJL
