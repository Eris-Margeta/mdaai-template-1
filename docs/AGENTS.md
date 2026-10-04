# AGENTS.md - Documentation Navigation

<!-- Parent: ../AGENTS.md -->

This directory contains **public-facing documentation** for end users and developers.

---

## Directory Purpose

The `/docs/` folder contains all public documentation that will be published to a documentation website. This is distinct from `PROJECT-INTERNAL/` which is for development governance.

**PERMISSION LEVEL:**
- AI can CREATE new documentation files
- AI can UPDATE documentation when explicitly authorized
- Documentation updates require Work Orders

---

## Structure

```
docs/
├── index.md              # Documentation home page
├── AGENTS.md             # This file
│
├── guide/                # User Guide (how to use)
│   ├── index.md
│   ├── getting-started.md
│   ├── configuration.md
│   └── features/
│
├── tutorials/            # Step-by-step tutorials
│   ├── index.md
│   └── tutorial-*.md
│
├── api/                  # API Reference
│   ├── index.md
│   └── endpoints/
│
├── architecture/         # Technical architecture
│   ├── index.md
│   └── decisions.md
│
├── diagrams/             # Editable Mermaid source files
│
├── assets/               # Rendered images and SVG diagrams
│   └── screenshots/
│
└── .templates/           # Documentation templates
    ├── readme.md             # Standard README template
    ├── readme-monorepo.md    # Monorepo README template
    ├── readme-folder.md      # Folder README template
    ├── user-guide-page.md
    ├── tutorial.md
    ├── api-endpoint.md
    └── architecture-overview.md
```

---

## For AI Agents

### When to Write Documentation

**The Checkpoint Rule:**
> Documentation is written at checkpoints, not during active development.

- During development: Write inline code comments only
- At checkpoint: Write/update docs for completed features
- Pre-release: Full documentation review

### Documentation Protocol

See `PROJECT-INTERNAL/GOVERNANCE/DOCUMENTATION-PROTOCOL.md` for full rules.

Key requirements:
1. Every Work Order with user-facing changes must update docs
2. Documentation tasks should be in PROJECT-ELABORATION.md
3. All code examples must be tested
4. All links must be verified

### Using Templates

Templates are in `.templates/`:

| Template | Use For |
|----------|---------|
| `readme.md` | Standard repository README |
| `readme-monorepo.md` | Monorepo root README |
| `readme-folder.md` | Non-conventional folder README |
| `user-guide-page.md` | Feature documentation |
| `tutorial.md` | Step-by-step tutorials |
| `api-endpoint.md` | REST API endpoints |
| `architecture-overview.md` | System architecture |

### Documentation Work Orders

All documentation work requires Work Orders:

```markdown
## Documentation Impact

**User-facing change:** Yes
**Docs updated:** Yes
**Files changed:**
- docs/guide/feature.md (+100 lines)
```

### Quality Checklist

Before completing documentation:
- [ ] Code examples compile and run
- [ ] All internal links work
- [ ] All external links work
- [ ] No placeholder text
- [ ] Consistent terminology
- [ ] Screenshots are current

---

## Quick Reference

| Need | Action |
|------|--------|
| Create README | Use `readme.md` or `readme-monorepo.md` template |
| Folder README | Use `readme-folder.md` template |
| Document a feature | Use `user-guide-page.md` template |
| Write a tutorial | Use `tutorial.md` template |
| Document API endpoint | Use `api-endpoint.md` template |
| Architecture docs | Use `architecture-overview.md` template |
| Check protocol | Read `PROJECT-INTERNAL/GOVERNANCE/DOCUMENTATION-PROTOCOL.md` |
