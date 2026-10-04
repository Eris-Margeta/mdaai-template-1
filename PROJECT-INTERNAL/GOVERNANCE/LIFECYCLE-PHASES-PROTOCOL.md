# LIFECYCLE PHASES PROTOCOL

**Protocol on Project Lifecycle Phases and Phase Transitions**

---

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Board for Standardization and Development

**Class:** 001-01/26-01
**Reference Number:** 251-01-01-26-07 (Rev. 1)
**Date:** 20.01.2026

SUBJECT: Lifecycle Phases Protocol, Version 1.0

---

## CHAPTER I: OVERVIEW

### **Article 1: Purpose**

(1) This protocol defines **Project Lifecycle Phases** - meta-labels applied to groups of phases in PROJECT-ELABORATION.md.

(2) Lifecycle phases define:
- What quality standards apply
- What documentation is required
- What testing is expected
- What workflows are mandatory

(3) Each lifecycle phase has different requirements, building progressively toward production-ready software.

### **Article 2: Lifecycle Phase Hierarchy**

(1) Projects progress through lifecycle phases in order:

```
┌─────────────────────────────────────────────────────────────────────┐
│                        PROJECT LIFECYCLE                             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌──────────┐   ┌───────────┐   ┌─────────┐   ┌─────────┐          │
│  │EXPLORATION│ → │ PROTOTYPE │ → │  ALPHA  │ → │  BETA   │ → RELEASE│
│  └──────────┘   └───────────┘   └─────────┘   └─────────┘          │
│                                                                      │
│  Fast & Dirty    Validating      Quality       Full Quality         │
│  Research        Feasibility     No Tests      All Tests            │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

(2) A project may skip phases if appropriate (e.g., start at ALPHA for mature teams).

(3) **Regression is prohibited.** Once in BETA, you cannot return to ALPHA behaviors.

---

## CHAPTER II: EXPLORATION PHASE

### **Article 3: Exploration Phase Definition**

(1) **Purpose:** Fast research and proof-of-concept. Prove ideas work.

(2) **Mindset:** "Does this even work?" Speed over quality.

(3) **Typical phases:** 1 through X (defined in PROJECT-ELABORATION.md)

### **Article 4: Exploration Phase Requirements**

(1) **REQUIRED:**
- Basic Work Orders (can be abbreviated)
- Functional code that demonstrates concept

(2) **NOT REQUIRED:**
- Documentation (beyond inline comments)
- Testing
- Code quality standards
- Code structure rules
- Public documentation
- CI/CD

(3) **Explicitly permitted:**
- Quick and dirty code
- Hardcoded values
- Spaghetti code (temporarily)
- Missing error handling
- Console.log debugging

### **Article 5: Exploration Exit Criteria**

(1) Before transitioning to PROTOTYPE:
- [ ] Core concept proven viable
- [ ] Key technical risks identified
- [ ] Go/no-go decision made
- [ ] Brief summary of findings documented

---

## CHAPTER III: PROTOTYPE PHASE

### **Article 6: Prototype Phase Definition**

(1) **Purpose:** Validate feasibility with good code. Confirm the approach works.

(2) **Mindset:** "Can we build this properly?" Quality code, but fast iteration.

(3) **Typical phases:** X through Y (defined in PROJECT-ELABORATION.md)

### **Article 7: Prototype Phase Requirements**

(1) **REQUIRED:**
- Standard Work Orders
- Good code quality
- Reasonable code structure
- Basic error handling
- Inline code comments

(2) **NOT REQUIRED:**
- Comprehensive documentation
- Full test coverage
- CI/CD pipeline
- Public documentation
- Production-ready architecture

(3) **Explicitly permitted:**
- Refactoring as you go
- Changing approaches mid-phase
- Incomplete features
- Missing edge case handling

### **Article 8: Prototype Exit Criteria**

(1) Before transitioning to ALPHA:
- [ ] Core functionality works
- [ ] Technical approach validated
- [ ] Major architectural decisions documented (ADRs)
- [ ] Code is readable and reasonable
- [ ] Brief feature documentation exists

---

## CHAPTER IV: ALPHA PHASE

### **Article 9: Alpha Phase Definition**

(1) **Purpose:** High-quality code with proper structure. Feature complete, but not fully tested.

(2) **Mindset:** "Build it right." Quality code, proper documentation, but testing comes later.

(3) **Typical phases:** Y through Z (defined in PROJECT-ELABORATION.md)

### **Article 10: Alpha Phase Requirements**

(1) **REQUIRED:**
- Full Work Orders with all sections
- High-quality code
- Proper code structure (following CODE-PHILOSOPHY.md)
- Complete inline documentation
- Internal documentation (KNOWLEDGE/ documents)
- ADRs for all significant decisions
- Error handling

(2) **NOT REQUIRED:**
- Comprehensive tests
- CI/CD pipeline
- Public documentation website
- Production README with badges
- Versioning system
- Build validation

(3) **Explicitly permitted:**
- Manual testing only
- Missing edge case tests
- Incomplete public docs

### **Article 11: Alpha Exit Criteria**

(1) Before transitioning to BETA:
- [ ] All planned features implemented
- [ ] Code follows CODE-PHILOSOPHY.md
- [ ] KNOWLEDGE/ documents are current
- [ ] All ADRs documented
- [ ] Code review completed
- [ ] **MAJOR REFACTOR CHECKPOINT** (see Article 12)

### **Article 12: Alpha-to-Beta Refactor Checkpoint**

(1) **Before entering BETA, a mandatory refactor review occurs.**

(2) During this checkpoint:
- Review entire codebase against CODE-PHILOSOPHY.md
- Identify deviations from planned architecture
- Plan structural changes needed
- Create refactor Work Orders

(3) **Refactor scope may include:**
- Function names
- File names
- Folder structure
- Module organization
- API design
- Data structures

(4) **This is the LAST opportunity for major restructuring.** Once in BETA, structure is frozen except for critical fixes.

---

## CHAPTER V: BETA PHASE

### **Article 13: Beta Phase Definition**

(1) **Purpose:** Full quality with all tests, documentation, and validation. Production-ready code.

(2) **Mindset:** "Make it bulletproof." Every detail matters. Every change is verified.

(3) **Typical phases:** Z through end (defined in PROJECT-ELABORATION.md)

### **Article 14: Beta Phase Requirements**

(1) **REQUIRED:**
- Full Work Orders with all sections
- All quality standards from CODE-PHILOSOPHY.md
- **Tight code ↔ documentation coupling** (see Article 15)
- **Comprehensive testing** (see BETA-PHASE-PROTOCOL.md)
- CI/CD pipeline
- Public documentation
- Production README with badges
- Proper versioning
- Build validation
- **Self-correction after every task** (see Article 16)
- **Error analysis workflow** (see BETA-PHASE-PROTOCOL.md)
- **Cache/temp file cleanup** (see Article 17)

(2) **MANDATORY COUPLING:** At the end of each Beta phase:
- All PROJECT-INTERNAL/ docs align with code
- All tests pass
- All public documentation current
- Protocol compliance verified

### **Article 15: Beta Phase Documentation Coupling**

(1) **After every task in Beta phase, verify:**
- [ ] KNOWLEDGE/ documents reflect current state
- [ ] Code comments are accurate
- [ ] Related ADRs still valid
- [ ] Work Order documentation complete

(2) **After every Beta PHASE, verify:**
- [ ] All PROJECT-INTERNAL/ docs synchronized
- [ ] All tests written and passing
- [ ] Public documentation current
- [ ] README reflects current state
- [ ] CHANGELOG updated
- [ ] No protocol deviations

### **Article 16: Beta Phase Self-Correction**

(1) After completing each task in Beta:
1. Review the change against protocols
2. Verify documentation coupling
3. Confirm tests exist for new functionality
4. Clean up any temporary files

(2) AI determines optimal timing:
- Some verifications after each task
- Full verification after each phase
- **But ALL must be true at phase end**

### **Article 17: Beta Phase Cleanup Requirements**

(1) **Delete temporary artifacts:**
- Test caches
- Build caches
- Sandbox files
- Temporary outputs
- Debug logs
- Coverage reports (after review)

(2) **Do NOT litter the system.** Clean as you go.

---

## CHAPTER VI: PHASE TRANSITIONS

### **Article 18: Phase Transition Workflow**

(1) When completing a lifecycle phase:

```
┌─────────────────────────────────────────────────────────────────────┐
│                    PHASE TRANSITION WORKFLOW                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. Complete all tasks in current phase                             │
│  2. Verify exit criteria (Articles 5, 8, 11, or 20)                 │
│  3. Create PHASE TRANSITION CHECKPOINT                              │
│  4. Review what's needed for next phase                             │
│  5. Create "Next Phase Preparation" tasks                           │
│  6. Add preparation tasks to PROJECT-ELABORATION.md                 │
│  7. Begin next phase                                                │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

(2) **Next Phase Preparation** adds requirements not in previous phase:

| Transition | Preparation Tasks |
|------------|-------------------|
| Exploration → Prototype | Code cleanup, basic structure |
| Prototype → Alpha | Full structure, documentation setup |
| Alpha → Beta | **Major refactor**, test infrastructure, CI/CD setup |
| Beta → Release | Final polish, release preparation |

### **Article 19: Phase Transition Checkpoint**

(1) Every phase transition requires a Checkpoint document.

(2) The Checkpoint must include:
- Summary of phase accomplishments
- Exit criteria verification
- Issues discovered
- Recommendations for next phase
- List of preparation tasks

---

## CHAPTER VII: PROJECT-ELABORATION INTEGRATION

### **Article 20: Lifecycle Phase Declaration**

(1) Lifecycle phases are declared at the **top** of PROJECT-ELABORATION.md:

```markdown
## Lifecycle Phase Mapping

| Phases | Lifecycle | Description |
|--------|-----------|-------------|
| 1-2 | EXPLORATION | Research and proof of concept |
| 3-5 | PROTOTYPE | Validate feasibility |
| 6-8 | ALPHA | Quality implementation |
| 9-12 | BETA | Full testing and documentation |
```

(2) AI agents MUST check this mapping to understand current requirements.

### **Article 21: Phase Identification**

(1) To determine current lifecycle phase:
1. Read the Lifecycle Phase Mapping table
2. Identify which phases are complete (marked `[x]`)
3. Identify current phase number
4. Look up lifecycle phase in mapping

(2) **Current lifecycle phase determines:**
- What quality standards apply
- What documentation is required
- What testing is expected
- What workflows are mandatory

---

## CHAPTER VIII: FINAL PROVISIONS

### **Article 22: Beta Phase Protocol Reference**

(1) Due to the complexity of Beta phase requirements, a separate protocol exists:
- `BETA-PHASE-PROTOCOL.md` - Detailed error handling and testing workflows

(2) Beta phase participants MUST read both this protocol and BETA-PHASE-PROTOCOL.md.

### **Article 23: Entry Into Force**

(1) This protocol is binding for all projects using lifecycle phase management.

(2) It supplements AI-INSTRUCTIONS.md and the Work Order Protocol.

---

**Compiled by:**
AI Assistant, System Integration Sector

**Approved by:**
Operator, Board for Standardization and Development of TEJL
