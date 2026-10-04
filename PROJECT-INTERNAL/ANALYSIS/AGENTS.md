# AGENTS.md - Analysis Navigation

<!-- Parent: ../AGENTS.md -->

This directory contains formal analysis artifacts that support planning, architecture, performance work, audits, and strategic reviews.

---

## Directory Purpose

The `ANALYSIS/` directory is the standard location for durable investigation records. Use it when an analysis should outlive the current conversation but is not itself a backlog item, ADR, Work Order, checkpoint, or user-facing document.

**PERMISSION LEVEL:** AI agents can create and update analysis documents when authorized by the Operator or by an active Work Order.

---

## Appropriate Content

| Artifact | Use For |
|----------|---------|
| Profiling report | Performance measurements, bottleneck findings, benchmark interpretation |
| Strategic review | System-wide assessment, risk review, modernization review |
| Technical investigation | Comparison of options, dependency research, feasibility analysis |
| Progress summary | Durable summary of a phase, incident, migration, or research thread |
| Audit report | Security, accessibility, reliability, or compliance analysis |

---

## Boundaries

Analysis documents are evidence and reasoning records. They are not executable authorization by themselves.

**Do not treat `ANALYSIS/` documents as:**
- Backlog authorization
- ADR acceptance
- Work Order completion records
- Checkpoint certificates
- User-facing documentation

To act on analysis findings:

1. Convert recommendations into `PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md` tasks, or request Operator authorization.
2. Create an ADR if the recommendation changes architecture.
3. Create a Work Order before implementation or file edits.

---

## Naming Convention

Use lowercase, date-aware, descriptive filenames:

```text
YYYY-MM-DD-topic-analysis.md
YYYY-MM-DD-topic-strategic-review.md
phase-N-topic-progress-summary.md
phase-N-topic-profiling-results.md
```

Examples:

```text
2026-05-29-authentication-strategic-review.md
phase-02-api-performance-profiling-results.md
```

---

## Required Structure

Use `analysis-report-template.md` for new durable reports unless the Operator requests another structure.

Every analysis report should include:

- Context
- Scope
- Evidence
- Findings
- Risks
- Recommendations
- Follow-up actions
- Source references

---

## Quick Reference

| Need | Destination |
|------|-------------|
| Durable investigation | `ANALYSIS/` |
| Binding architecture decision | `ARCHITECTURE/ADR-*.md` |
| Authorized task | `MANAGEMENT/PROJECT-ELABORATION.md` |
| Execution record | `WORK-ORDERS/` |
| Living implementation knowledge | `KNOWLEDGE/` |
