# DOCUMENTATION PROTOCOL

**Protocol on Public-Facing Documentation Creation and Maintenance**

---

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Board for Standardization and Development

**Class:** 001-01/26-01
**Reference Number:** 251-01-01-26-05 (Rev. 1)
**Date:** 20.01.2026

SUBJECT: Documentation Protocol, Version 1.0

---

## CHAPTER I: PHILOSOPHY

### **Article 1: Documentation as Deliverable**

(1) Public documentation is a **deliverable**, not an afterthought.

(2) Documentation is:
- Part of the product itself
- A feature requiring design, implementation, and testing
- Subject to the same quality standards as code
- Tracked through the Work Order system

(3) A feature without documentation is an **incomplete feature**.

### **Article 2: Documentation Types**

(1) The following documentation types are recognized:

| Type | Audience | Purpose | Location |
|------|----------|---------|----------|
| README | Everyone | First impression, quick start | `/README.md` |
| User Guide | End users | How to use the product | `/docs/guide/` |
| API Reference | Developers | Technical specifications | `/docs/api/` |
| Tutorials | New users | Step-by-step learning | `/docs/tutorials/` |
| Architecture | Contributors | System design | `/docs/architecture/` |
| Changelog | All | Version history | `/CHANGELOG.md` |
| Contributing | Contributors | How to contribute | `/CONTRIBUTING.md` |

(2) Not all projects require all types. Minimum requirements:
- README.md (always)
- CHANGELOG.md (always)
- User Guide (if end-user product)
- API Reference (if API exposed)

---

## CHAPTER II: TIMING

### **Article 3: When to Write Documentation**

(1) **Documentation follows the checkpoint rule:**
> Documentation is written at checkpoints, not during active development.

(2) **Rationale:**
- Features change during development; docs would be constantly outdated
- Checkpoint means "stable"; safe to document
- Forces documentation as a conscious deliverable
- Prevents "we'll do it later" syndrome

(3) **The only exception:** Inline code comments (write as you code)

### **Article 4: Documentation Lifecycle**

(1) Documentation follows this lifecycle:

| Phase | Documentation Action |
|-------|----------------------|
| Phase Start | Create `/docs/` structure, no content |
| During Development | Write inline code comments only |
| Checkpoint | Write docs for completed features |
| Pre-Release | Full documentation review |
| Post-Release | Monitor and iterate based on feedback |

(2) **Pre-Checkpoint Rule:**
Before creating a checkpoint, verify documentation status per Article 9.

### **Article 5: Documentation Tasks in Backlog**

(1) Every phase in PROJECT-ELABORATION.md SHOULD include documentation tasks:

```markdown
### 2.1 User Authentication [COMPLETE]
- [x] Implement JWT tokens
- [x] Add session management
- [x] Write unit tests
- [x] Document auth flow in user guide  <-- Doc task
- **Work Order:** WO-2026-005
```

(2) Documentation tasks are NOT optional add-ons; they are part of the feature.

---

## CHAPTER III: STRUCTURE

### **Article 6: Documentation Folder Structure**

(1) The recommended structure for `/docs/`:

```
docs/
├── index.md                   # Docs home page
├── guide/                     # User Guide
│   ├── index.md               # Guide overview
│   ├── getting-started.md     # Installation & setup
│   ├── configuration.md       # How to configure
│   ├── features/              # Feature-specific guides
│   └── troubleshooting.md     # Common issues
├── tutorials/                 # Step-by-step tutorials
│   ├── index.md               # Tutorial list
│   └── tutorial-*.md          # Individual tutorials
├── api/                       # API Reference
│   ├── index.md               # API overview
│   └── endpoints/             # Endpoint documentation
├── architecture/              # Technical architecture
│   ├── index.md               # Architecture overview
│   └── decisions.md           # Links to ADRs
└── assets/                    # Images, diagrams
    ├── diagrams/
    └── screenshots/
```

(2) This structure is RECOMMENDED, not mandatory. Adapt to project needs.

### **Article 7: Documentation Tools**

(1) Recommended tools by project language:

| Language | Recommended Tool |
|----------|------------------|
| Rust | mdBook |
| Go | Hugo |
| Python | MkDocs + Material |
| Node/TS | Docusaurus or VitePress |
| Simple projects | Docsify |

(2) Tool selection should be documented in an ADR if non-standard.

---

## CHAPTER IV: README STANDARDS

### **Article 8: Root README Requirements**

(1) Every repository MUST have a high-quality root README.md.

(2) **Required sections:**
- Project title and description
- Badges (version, build status, license)
- Quick start / Installation
- Usage examples
- Documentation links
- Contributing guidelines
- License

(3) **Badge requirements:**

```markdown
![Version](https://img.shields.io/badge/version-X.Y.Z-blue)
![Build](https://img.shields.io/github/actions/workflow/status/org/repo/ci.yml)
![License](https://img.shields.io/badge/license-MIT-green)
```

(4) **CRITICAL: Version badge MUST derive from VERSION file.**
- Never hardcode versions in README
- Use dynamic badges or CI-generated badges
- VERSION file is the single source of truth

### **Article 9: Monorepo README Structure**

(1) **Root README in monorepo must include:**
- Overview of all packages/services
- Package table with versions (referencing VERSION files)
- Links to sub-package READMEs
- Shared setup instructions

(2) **Version matrix format:**

```markdown
| Package | Version | Description |
|---------|---------|-------------|
| @project/core | from packages/core/VERSION | Core functionality |
| @project/cli | from packages/cli/VERSION | CLI tool |
```

(3) **Sub-package READMEs:**
- Each package MUST have its own README.md
- Each package MUST have its own VERSION file
- Sub-README references root for shared setup

(4) **Synchronization:** CI/scripts update derived versions from VERSION files.

### **Article 10: Folder README Requirements**

(1) README files are **REQUIRED** in:
- Non-conventional folders (not `src`, `tests`, `docs`)
- Folders with complex organization
- Folders whose purpose isn't obvious from name
- Configuration folders
- Script folders

(2) **AGENTS.md vs README.md:**
- `AGENTS.md` = Navigation for AI agents
- `README.md` = Documentation for human developers
- Both may coexist if both audiences need different information

(3) **Folder README should explain:**
- Purpose of the folder
- Contents overview (what each file/subfolder does)
- How files relate to each other
- Usage instructions if applicable
- Any conventions or patterns used

### **Article 11: Version Single Source of Truth**

(1) **The VERSION file is the KING of version truth for its directory.**

(2) **Derived locations (NEVER edit directly):**
- README badges
- Package manifests (Cargo.toml, package.json, pyproject.toml)
- CI variables
- Documentation version numbers

(3) **Updating versions:**
```
1. Edit VERSION file
2. CI/scripts propagate to derived locations
3. Commit includes all derived updates
```

(4) **Manual version sync is PROHIBITED.** Automate or fail.

---

## CHAPTER V: SYNCHRONIZATION

### **Article 12: Keeping Documentation in Sync**

(1) **The Sync Problem:** Documentation drift occurs when code changes but docs don't.

(2) **Mandatory Sync Mechanisms:**

**Mechanism A: Work Order Documentation Section**

Every Work Order that changes user-facing behavior MUST include:

```markdown
## Documentation Impact

**User-facing change:** Yes/No
**Docs updated:** Yes/No/Not needed
**Files changed:**
- docs/guide/feature-a.md (+15 lines)
```

If user-facing = Yes and docs updated = No, the Work Order is INCOMPLETE.

**Mechanism B: Checkpoint Documentation Audit**

Every checkpoint MUST include a documentation audit:

```markdown
## Documentation Audit

| Feature | Documented | Up to Date |
|---------|------------|------------|
| Auth    | Yes        | Yes        |
| API     | Yes        | No         |
| Config  | No         | -          |
```

(3) **Work Orders with user-facing changes and no doc updates are protocol violations.**

### **Article 13: Pre-Checkpoint Documentation Requirements**

(1) Before creating a checkpoint, the following documentation requirements apply:

- [ ] All user-facing features in this phase are documented
- [ ] All code examples in documentation are tested
- [ ] All internal links are verified
- [ ] CHANGELOG.md is updated
- [ ] README.md reflects current state

(2) If any requirement is unmet, the checkpoint is BLOCKED until resolved.

### **Article 14: Documentation Sync Checklist**

(1) Before any release, verify:

- [ ] All new features documented
- [ ] All removed features removed from docs
- [ ] All code examples compile and run
- [ ] All links work (internal and external)
- [ ] All screenshots current
- [ ] Changelog updated
- [ ] Version numbers consistent

---

## CHAPTER VI: WORK ORDERS

### **Article 15: Documentation Work Orders**

(1) Documentation work is tracked through the standard Work Order system.

(2) Documentation Work Orders include:

| Field | Requirement |
|-------|-------------|
| Subject | "Document [feature/section]" |
| Task Reference | Link to backlog documentation task |
| Files Changed | List all doc files created/modified |
| Verification | Code examples tested, links verified |

(3) Example:

```markdown
# Work Order [WO-2026-015]

**Subject:** Document user authentication flow

## Files Changed

| File | Action | Lines Changed |
|------|--------|---------------|
| docs/guide/authentication.md | Created | +150 |
| docs/api/auth.md | Created | +200 |

## Verification

- [x] All code examples tested
- [x] All links verified
- [x] Screenshots current
```

---

## CHAPTER VII: CHANGELOG

### **Article 16: Changelog Requirements**

(1) Every project MUST maintain a CHANGELOG.md file.

(2) Format: [Keep a Changelog](https://keepachangelog.com/)

(3) Categories:
- **Added** - New features
- **Changed** - Changes in existing functionality
- **Deprecated** - Soon-to-be removed features
- **Removed** - Removed features
- **Fixed** - Bug fixes
- **Security** - Security fixes

(4) Workflow:
- During development: Add entries to [Unreleased]
- At release: Move [Unreleased] to new version section
- Every PR that changes behavior updates CHANGELOG.md

### **Article 17: Changelog Work Orders**

(1) Changelog updates do NOT require separate Work Orders.

(2) Changelog updates SHOULD be included in the Work Order for the feature.

---

## CHAPTER VIII: QUALITY

### **Article 18: Documentation Quality Standards**

(1) **Content Quality:**
- Accurate and up-to-date
- Complete (no TODOs or placeholders in published docs)
- Clear and understandable
- Consistent terminology

(2) **Technical Quality:**
- All code examples work
- All links resolve
- All images load
- Renders correctly

(3) **User Experience:**
- Easy to navigate
- Searchable (if using doc tool)
- Mobile-friendly
- Fast loading

---

## CHAPTER IX: FINAL PROVISIONS

### **Article 19: The Golden Rule**

> If the feature is stable enough for a checkpoint, it's stable enough for documentation.
> If it's not stable enough for documentation, it's not stable enough for a checkpoint.

### **Article 20: Entry Into Force**

(1) This protocol is binding for all documentation work under TEJL governance.

(2) It supplements AI-INSTRUCTIONS.md and the Checkpoint Protocol.

---

**Compiled by:**
AI Assistant, System Integration Sector

**Approved by:**
Operator, Board for Standardization and Development of TEJL
