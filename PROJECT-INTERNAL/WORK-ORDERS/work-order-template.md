# Work Order WO-XXX

**`[AI INSTRUCTION: This template defines the MANDATORY structure for all Work Orders. You MUST create a Work Order document BEFORE starting any implementation work. The Work Order serves as both the specification and the execution log.]`**

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
System Integration Sector

**Class:** `[Use project class from project-meta.yaml, e.g., 003-05/25-01]`
**Reference Number:** `[Format: {class}-WO-{sequence}, e.g., 251-01-03-25-06-WO-050]`
**Date:** `[DD.MM.YYYY format, e.g., 02.02.2026]`
**Executor:** `[Use operator.name from project-meta.yaml, e.g., Eris Margeta]`

**SUBJECT:** `[Phase X.Y.Z - Brief, clear description of the task]`

---

## AUTHORIZATION
Task Reference: `[e.g., PROJECT-DEVELOPMENT-ELABORATION.md, Phase 10.6, Section 10.6.2.a]`
Related ADR: `[e.g., ADR-014 (Accepted)]`
Depends On: `[e.g., WO-049 (Completed)]`

---

## OBJECTIVE

`[One paragraph explaining WHAT this Work Order accomplishes and WHY it is necessary. Be specific and measurable. Example: "Add is_ignored: bool field to DirContextTreeNode struct to support privacy-preserving debug mode. This field marks nodes that matched ignore rules and should never have their contents read."]`

---

## TECHNICAL SPECIFICATION

**`[AI INSTRUCTION: This section contains the detailed technical specification of the work to be performed. Include file paths, function signatures, code examples, and precise requirements. This is the BINDING specification - implement EXACTLY what is written here.]`**

**Files to Modify:**
1. `[path/to/file.rs]`
2. `[path/to/other_file.rs]`

---

### Change 1: `[Description of first change]`

**Current Code:**
```rust
// Show current implementation if modifying existing code
```

**New Code:**
```rust
// Show exact new implementation
// Include comments explaining the change
```

**Rationale:** `[Why this change is necessary]`

---

### Change 2: `[Description of second change]`

`[Repeat pattern for each distinct change]`

---

## RATIONALE

`[Explain the reasoning behind the approach. Reference ADRs, architectural principles, or business requirements. Example: "Per ADR-014, we require a mechanism to distinguish between normal files, omitted files, and ignored files in debug mode without complex state management."]`

---

## VERIFICATION STEPS

**`[AI INSTRUCTION: Define the EXACT steps to verify this work is complete and correct. These are the acceptance criteria.]`**

1. **Compilation:** `cargo build -p package-name`
2. **Unit Tests:** `cargo test -p package-name`
3. **Manual Test 1:** `[Specific manual verification step]`
   - Expected: `[What should happen]`
4. **Manual Test 2:** `[Another verification step]`
   - Expected: `[What should happen]`

---

## EXPECTED OUTCOME

**`[AI INSTRUCTION: List the concrete, measurable outcomes of this work. After execution, you will verify these outcomes were achieved.]`**

- `[e.g., is_ignored field added to struct]`
- `[e.g., Field initialized to false in constructor]`
- `[e.g., All existing tests pass (N tests)]`
- `[e.g., No breaking changes to existing functionality]`

---

## FILES CHANGED
**`[AI INSTRUCTION: FILL THIS SECTION AFTER EXECUTION. Leave as "To be filled" when creating the WO.]`**

*(To be filled after execution)*

| File | Action | Lines Changed |
|------|--------|---------------|
| - | - | - |

---

## VERIFICATION RESULTS
**`[AI INSTRUCTION: FILL THIS SECTION AFTER EXECUTION. Document actual test results and verification outcomes.]`**

*(To be filled after execution)*

**Build Status:** Pending
**Test Status:** Pending
**Manual Verification:** Pending

---

## TIME EXPENDITURE
**`[AI INSTRUCTION: Estimate time for a human to complete this work. After execution, record actual time spent.]`**

**Estimated:** `[e.g., 0h 15m - estimate for human, including analysis and testing]`
**Actual:** *(To be filled after execution)*

---

## MATERIAL EXPENDITURE

`[Default: "Consumables". If using external services (API calls, cloud resources), list them explicitly.]`

---

## STATUS
**`[AI INSTRUCTION: Update this field as work progresses:]`**
**🟡 PENDING** - Awaiting execution
**🔵 IN PROGRESS** - Work started
**✅ COMPLETED** - Successfully executed
**❌ BLOCKED** - Cannot proceed (explain why)

---

**Created:** `[YYYY-MM-DD]`
**Last Updated:** `[YYYY-MM-DD]`
**Completed:** `[YYYY-MM-DD or empty if not complete]`

---

## AI INSTRUCTIONS FOR USING THIS TEMPLATE

### When to Create a Work Order:
- **ALWAYS** create a Work Order BEFORE starting implementation work
- Work Orders are required for ANY code changes, configuration updates, or structural modifications
- Work Orders are NOT required for pure research/analysis (use regular responses)

### Work Order Creation Process:
1. **Read** PROJECT-DEVELOPMENT-ELABORATION.md to identify the current task
2. **Extract** the task specification from the elaboration document
3. **Create** WO-XXX.md using this template (assign next sequential number)
4. **Fill** all sections marked "To be filled after execution" with placeholder text
5. **Set** STATUS to 🟡 PENDING
6. **Present** the Work Order to the Operator for approval (optional) or proceed directly to execution

### Work Order Execution Process:
1. **Open** the Work Order (change STATUS to 🔵 IN PROGRESS)
2. **Execute** the work EXACTLY as specified in TECHNICAL SPECIFICATION section
3. **Verify** using the steps defined in VERIFICATION STEPS section
4. **Document** all changes in FILES CHANGED section
5. **Record** actual verification results in VERIFICATION RESULTS section
6. **Update** TIME EXPENDITURE with actual time
7. **Set** STATUS to ✅ COMPLETED
8. **Log** the Work Order to registry.json

### Work Order Completion Checklist:
- [ ] All changes from TECHNICAL SPECIFICATION implemented
- [ ] All VERIFICATION STEPS executed and passed
- [ ] FILES CHANGED section filled with actual changes
- [ ] VERIFICATION RESULTS section filled with actual results
- [ ] TIME EXPENDITURE updated with actual time
- [ ] STATUS updated to ✅ COMPLETED
- [ ] Work Order logged to registry.json

### Registry Logging:
After completing a Work Order, add an entry to `PROJECT-INTERNAL/WORK-ORDERS/registry.json`:
```json
{
  "class": "003-05/25-01",
  "referenceNumber": "251-01-03-25-06-WO-050",
  "date": "2026-02-02",
  "executor": "Eris Margeta",
  "subject": "Brief subject line",
  "description": "One-sentence description of what was done",
  "tasks": [
    "Specific task 1",
    "Specific task 2"
  ],
  "timeExpenditure": "0h 15m",
  "materialExpenditure": "Consumables"
}
```

### Formatting Rules:
- Use DD.MM.YYYY date format (European standard)
- Time format: Xh Ym (e.g., "1h 30m" or "0h 15m")
- Status emojis: 🟡 Pending, 🔵 In Progress, ✅ Completed, ❌ Blocked
- File paths: Use backticks for inline code
- Code blocks: Use triple backticks with language identifier

### Complete Example Work Order:

```markdown
# Work Order WO-050

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
System Integration Sector

**Class:** 003-05/25-01
**Reference Number:** 251-01-03-25-06-WO-050
**Date:** 02.02.2026
**Executor:** Eris Margeta

**SUBJECT:** Phase 10.6.1 - Data Structure Enhancement: Add is_ignored Flag

---

## AUTHORIZATION
Task Reference: PROJECT-DEVELOPMENT-ELABORATION.md, Phase 10.6, Section 10.6.2.a
Related ADR: ADR-014 (Accepted)

---

## OBJECTIVE
Add is_ignored: bool field to DirContextTreeNode struct to support privacy-preserving
debug mode. This field marks nodes that matched ignore rules and should never have
their contents read, even when displayed in the directory tree for diagnostic purposes.

---

## TECHNICAL SPECIFICATION

**File to Modify:** crates/dctx-core/src/datatypes.rs

**Change Required:**
Add new field to DirContextTreeNode struct:
```rust
pub struct DirContextTreeNode {
    // ... existing fields ...
    pub is_binary_file: bool,
    pub binary_file_type: Option<String>,

    // NEW: Privacy & Debug Support
    /// Marks files/folders that matched ignore rules.
    /// Only populated when --debug-ignored flag is active.
    /// When true: Show in tree but NEVER read content.
    pub is_ignored: bool,
}
```

**Constructor Update:**
```rust
impl DirContextTreeNode {
    pub fn new(node_type: NodeType, relative_path: &str, disk_path: PathBuf) -> Self {
        Self {
            // ... existing fields ...
            is_ignored: false,  // NEW: Default to false
        }
    }
}
```

---

## RATIONALE
Per ADR-014, we require a mechanism to distinguish between normal files (shown in tree,
content read), omitted files (shown in tree, content not read), and ignored files in
debug mode (shown in tree, content NEVER read). The is_ignored flag provides this
distinction without complex state management.

---

## VERIFICATION STEPS
1. Compile with `cargo build -p dctx-core`
2. Run full test suite: `cargo test -p dctx-core`
3. Verify no existing code breaks (field defaults to false)
4. Confirm struct size remains reasonable

---

## EXPECTED OUTCOME
- is_ignored field added to struct
- Field initialized to false in constructor
- All existing tests pass (284 tests)
- No breaking changes to existing functionality

---

## FILES CHANGED

| File | Action | Lines Changed |
|------|--------|---------------|
| crates/dctx-core/src/datatypes.rs | Modified | +6 lines |

**Details:**
- Added is_ignored: bool field to DirContextTreeNode struct (line 93)
- Added initialization is_ignored: false to constructor (line 103)
- Added documentation comment explaining field purpose

---

## VERIFICATION RESULTS

**Build Status:** ✅ PASS
- Compilation completed in 1.15s
- Zero warnings, zero errors

**Test Status:** ✅ ALL PASS
- 284/284 unit tests passed
- 0 failed, 0 ignored
- Test execution time: 0.06s

**Manual Verification:** ✅ PASS
- Field defaults to false (safe default)
- No breaking changes to existing code
- Memory overhead: 1 byte per node (minimal)

---

## TIME EXPENDITURE
**Estimated:** 0h 10m
**Actual:** 0h 08m

---

## MATERIAL EXPENDITURE
Consumables

---

## STATUS
✅ **COMPLETED** - Successfully executed

---

**Created:** 2026-02-02
**Last Updated:** 2026-02-02
**Completed:** 2026-02-02
```

This example demonstrates:
- ✅ Complete header with all metadata
- ✅ Clear authorization and objective
- ✅ Detailed technical specification with code examples
- ✅ Rationale explaining the approach
- ✅ Specific verification steps
- ✅ Measurable expected outcomes
- ✅ Complete post-execution documentation
- ✅ Proper status lifecycle tracking
