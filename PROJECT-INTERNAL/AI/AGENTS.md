# AGENTS.md - AI Configuration Navigation

<!-- Parent: ../AGENTS.md -->

This directory contains **AI agent configuration** including function schemas, prompts, and tool definitions.

---

## Directory Purpose

The AI folder centralizes all machine-readable configurations that define how AI agents interact with this project's systems. This includes function call schemas, system prompts, and tool definitions.

**PERMISSION LEVEL:**
- Function schemas: IMMUTABLE (AI cannot modify)
- Prompts: IMMUTABLE (AI cannot modify)
- Only human operators may modify these files

---

## Structure

```
AI/
├── AGENTS.md              # This file
└── functions/             # Function call schemas
    ├── work-orders.json   # Work order creation functions
    ├── registry.json      # Registry management functions
    └── reporting.json     # Report generation functions
```

---

## For AI Agents

### Using Function Schemas

The function schemas in `functions/` define the structured operations you can perform. Each schema follows the OpenAI/Anthropic function calling format.

**Available Functions:**

| Schema File | Functions | Purpose |
|-------------|-----------|---------|
| `work-orders.json` | `createWorkOrder`, `createCorrectiveWorkOrder` | Create WO/CWO documents |
| `registry.json` | `registerWorkOrder`, `reserveSequenceNumber`, `updateStatistics` | Manage registry.json |
| `reporting.json` | `generateSummaryReport`, `generateComplianceReport` | Generate reports |

### Function Execution Flow

When completing a task that requires a Work Order:

1. **Reserve** sequence number via `reserveSequenceNumber`
2. **Create** the work order document following the template
3. **Register** the completed WO via `registerWorkOrder`
4. **Update** statistics via `updateStatistics`

### Schema Validation

All function parameters are validated against JSON Schema. Required fields must be provided. See individual schema files for detailed parameter documentation.

---

## Modification Policy

These files may ONLY be modified:
- By human operators
- During formal REVISION phase
- With explicit human approval

AI-initiated modifications are PROHIBITED.

---

## Related Documents

- [Work Order Protocol](../GOVERNANCE/WORK-ORDER-PROTOCOL.md)
- [Work Order Template](../WORK-ORDERS/work-order-template.md)
- [Registry](../WORK-ORDERS/registry.json)
- [AI Instructions](../GOVERNANCE/AI-INSTRUCTIONS.md)
