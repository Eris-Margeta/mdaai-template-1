# DEVELOPER GUIDE

**Technical Onboarding Documentation**

---

## Overview

This document provides technical context for developers (human and AI) working on this project. It covers architecture, setup, and development workflows.

**AI Agents:** You MAY update this document when discovering new information relevant to project development. Create a Work Order for any updates.

---

## Project Overview

### Purpose

[Brief description of what this project does]

### Technology Stack

| Component | Technology | Version |
|-----------|------------|---------|
| Language | [Language] | [Version] |
| Framework | [Framework] | [Version] |
| Database | [Database] | [Version] |
| Build Tool | [Tool] | [Version] |

---

## Getting Started

### Prerequisites

- [Prerequisite 1]
- [Prerequisite 2]
- [Prerequisite 3]

### Setup

```bash
# Clone repository
git clone [repository-url]
cd [project-name]

# Install dependencies
[install command]

# Configure environment
cp .env.example .env
# Edit .env with your settings

# Start development
[dev command]
```

### Verification

```bash
# Run tests to verify setup
[test command]

# Expected output:
# All tests pass
```

---

## Development Commands

The canonical command list for project automation is the root `Justfile`. Use these commands when creating Work Orders, verification steps, and final reports.

### Template Management

```bash
# Validate repository structure against template requirements
just validate

# Pull template updates into a downstream project
just sync-downstream

# Check for local improvements that should be contributed upstream
just sync-upstream
```

### Project Lifecycle Commands

These recipes are intentionally generic in the template and should be overridden by each project when the template is adopted.

```bash
# Install dependencies
just install

# Build the project
just build

# Run development mode
just dev

# Run tests
just test

# Run lint checks
just lint

# Format code
just fmt

# Clean build artifacts
just clean
```

### Documentation and Status Commands

```bash
# Render Mermaid diagrams from docs/diagrams/*.mmd into docs/assets/*.svg
just diagrams

# Show version and recent Work Order registry state
just status

# Count Work Orders
just wo-count

# List all AGENTS.md files
just agents
```

AI Assistants must not perform git state-changing operations unless the Operator explicitly requests them. If a project adds release, tagging, publishing, or commit recipes, document their side effects here before using them in a Work Order.

---

## Architecture

### High-Level Overview

```
[ASCII diagram or description of architecture]
```

### Key Components

| Component | Purpose | Location |
|-----------|---------|----------|
| [Component 1] | [Purpose] | `src/[path]` |
| [Component 2] | [Purpose] | `src/[path]` |

### Data Flow

1. [Step 1]
2. [Step 2]
3. [Step 3]

---

## Development Workflow

### Making Changes

1. Check `PROJECT-ELABORATION.md` for authorized tasks
2. Read relevant style guides in `GUIDES/`
3. Check `GOTCHAS.md` for known pitfalls
4. Create and open a Work Order before file changes
5. Implement changes following conventions
6. Write/update tests
7. Run the verification commands listed in the Work Order
8. Complete the Work Order and update the registry

### Running Tests

```bash
# Run all tests
[test command]

# Run specific tests
[specific test command]

# Run with coverage
[coverage command]
```

### Building

```bash
# Development build
[dev build command]

# Production build
[prod build command]
```

---

## Diagram Workflow

Repository diagrams use a two-file standard:

| File Type | Location | Purpose |
|-----------|----------|---------|
| Mermaid source | `docs/diagrams/*.mmd` | Editable, reviewable diagram source |
| Mermaid config | `docs/diagrams/mermaid-config.json` | Shared render configuration |
| SVG asset | `docs/assets/*.svg` | Stable, crisp asset embedded in Markdown |

This standard keeps diagrams readable in diffs, reliable in GitHub README rendering, and reusable across future TEJL project templates.

### Editing Procedure

1. Edit the Mermaid source file in `docs/diagrams/`.
2. Preview the diagram locally or in Mermaid Live Editor if needed.
3. Run `just diagrams` to regenerate SVG assets.
4. Confirm the matching SVG in `docs/assets/` changed as expected.
5. Embed the SVG in Markdown and link back to the Mermaid source.

### Render Command

```bash
just diagrams
```

The command renders every `docs/diagrams/*.mmd` file into a same-named SVG file under `docs/assets/` using `docs/diagrams/mermaid-config.json`. It uses a globally installed `mmdc` when available, otherwise falls back to `pnpm dlx --allow-build=puppeteer @mermaid-js/mermaid-cli`. On macOS it also detects Google Chrome or an existing Puppeteer/Playwright headless shell and exports `PUPPETEER_EXECUTABLE_PATH` automatically.

### Markdown Embedding Pattern

```md
![Diagram title](docs/assets/example.svg)

Source: [docs/diagrams/example.mmd](docs/diagrams/example.mmd)
```

When an AI Assistant changes a diagram that is already embedded in documentation, it must update both the Mermaid source and the rendered SVG in the same Work Order. If SVG rendering cannot run because Mermaid CLI or `pnpm` is unavailable, report that limitation and leave the Mermaid source as the authoritative draft.

---

## Common Tasks

### Adding a New Feature

1. Verify feature is in backlog (`PROJECT-ELABORATION.md`)
2. Read related ADRs for architectural context
3. Check style guide for language conventions
4. Create and open a Work Order
5. Implement with tests
6. Update documentation if needed
7. Complete the Work Order and registry entry

### Debugging

1. Check `ERROR-CATALOG.md` for known issues
2. Review logs at [log location]
3. [Debugging tips specific to this project]

### Database Migrations

```bash
# [Migration commands if applicable]
```

---

## Configuration

### Environment Variables

| Variable | Purpose | Required | Default |
|----------|---------|----------|---------|
| `[VAR_1]` | [Purpose] | Yes | - |
| `[VAR_2]` | [Purpose] | No | `[default]` |

### Configuration Files

| File | Purpose |
|------|---------|
| `.env` | Environment-specific settings |
| `[config file]` | [Purpose] |

---

## Deployment

### Environments

| Environment | URL | Branch |
|-------------|-----|--------|
| Development | [URL] | `develop` |
| Staging | [URL] | `staging` |
| Production | [URL] | `main` |

### Deployment Process

```bash
# [Deployment commands]
```

---

## Troubleshooting

### Common Issues

See `ERROR-CATALOG.md` for detailed error resolution.

Quick references:
- Build fails: Check [common cause]
- Tests fail: Check [common cause]
- Runtime error: Check [common cause]

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | YYYY-MM-DD | [Author] | Initial creation |

---

**Note:** This is a living document. Update it when you discover information that would help future developers.
