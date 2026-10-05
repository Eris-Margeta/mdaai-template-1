# MULTI-AGENT PROTOCOL

**Protocol on the Governance of Parallel AI Agent Execution**

---

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**
Board for Standardization and Development

**Class:** 001-01/26-01
**Reference Number:** 251-01-01-26-02 (Rev. 1)
**Date:** 20.01.2026

SUBJECT: Multi-Agent Governance Protocol, Version 1.0

---

## CHAPTER I: PURPOSE AND SCOPE

### **Article 1: Purpose**

(1) This protocol establishes binding rules for the coordination and governance of multiple AI agents operating concurrently on the same project.

(2) Whether an orchestrator spawns 2 agents or 150 agents, ALL agents are bound by the same governance framework without exception.

(3) The purpose is to ensure:
- Consistent compliance with project protocols
- Proper coordination of work
- Accurate audit trail via Work Orders
- Prevention of conflicts and duplications
- Shared knowledge propagation

### **Article 2: Scope of Application**

(1) This protocol applies when:
- A single AI session spawns sub-agents
- Multiple AI tools work on the same repository
- An orchestration system (e.g., Sisyphus) coordinates parallel execution
- Any form of concurrent AI activity occurs

(2) This protocol is SUBORDINATE to `AI-INSTRUCTIONS.md`. In case of conflict, AI-INSTRUCTIONS.md prevails.

---

## CHAPTER II: AGENT HIERARCHY

### **Article 3: Orchestrator Responsibilities**

(1) The **Orchestrator** (parent agent or coordination system) is responsible for:

| Duty | Description |
|------|-------------|
| Protocol Propagation | Ensure all spawned agents are directed to read AGENTS.md |
| Sequence Coordination | Manage Work Order sequence number allocation |
| Conflict Resolution | Handle sequence conflicts and agent collisions |
| Aggregation | Collect and verify Work Orders from all agents |
| Knowledge Sync | Ensure KNOWLEDGE/ updates are propagated |

(2) The Orchestrator MUST include in every agent spawn instruction:

```
GOVERNANCE NOTICE: Before any work, you MUST read:
1. AGENTS.md (entry point)
2. PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md (constitution)
3. PROJECT-INTERNAL/GOVERNANCE/MULTI-AGENT-PROTOCOL.md (this document)

You are bound by all governance rules. Create Work Orders for all work.
Coordinate sequence numbers via registry.json.
```

### **Article 4: Sub-Agent Responsibilities**

(1) Each **Sub-Agent** (spawned agent) is independently responsible for:

| Duty | Description |
|------|-------------|
| Protocol Compliance | Read and follow all governance documents |
| Work Orders | Create WO/CWO for all work performed |
| Sequence Claims | Claim unique sequence numbers before creating WOs |
| Knowledge Updates | Update GOTCHAS.md, ERROR-CATALOG.md as needed |
| Conflict Reporting | Report any conflicts to Orchestrator immediately |

(2) **No agent may claim ignorance of governance.** Receipt of a task does not exempt an agent from reading governance documents.

---

## CHAPTER III: WORK ORDER COORDINATION

### **Article 5: Sequence Number Allocation**

(1) Work Order sequence numbers must be unique across all agents.

(2) **Allocation Procedure:**

```
1. Agent reads registry.json
2. Agent identifies next available sequence number
3. Agent reserves number by updating registry.json with status "reserved"
4. Agent creates Work Order with reserved number
5. Agent saves and registers Work Order metadata as PENDING or IN PROGRESS before implementation
6. OPEN as IN PROGRESS; update active records; CLOSE COMPLETE only with verified evidence
```

(3) **Registry Entry Format:**

```json
{
  "id": "WO-2026-001",
  "type": "standard",
  "status": "IN PROGRESS",
  "taskRef": "Dated direct operator request or approved planning task",
  "filePath": "PROJECT-INTERNAL/WORK-ORDERS/WO-2026-001-example.md"
}
```

### **Article 6: Conflict Prevention**

(1) Before reserving a sequence number, the agent MUST verify:
- The number is not already reserved by another agent
- The number is not already used by any Work Order (active or terminal)

(2) If a conflict is detected:
- STOP work immediately
- Report conflict to Orchestrator
- Wait for resolution
- Do NOT proceed with duplicate numbers
- Do NOT "skip ahead" to avoid conflict

(3) The Orchestrator is responsible for resolving conflicts by:
- Assigning the correct sequence to each agent
- Updating registry.json with authoritative allocations
- Instructing agents to proceed

### **Article 7: Parallel Work Order Creation**

(1) Multiple agents MAY create Work Orders simultaneously if:
- Each has reserved a unique sequence number
- Each is working on a distinct, authorized task
- There is no dependency between tasks

(2) Agents MUST NOT:
- Create Work Orders for the same task
- Modify files being modified by another agent
- Update the same KNOWLEDGE/ document simultaneously

---

## CHAPTER IV: KNOWLEDGE SYNCHRONIZATION

### **Article 8: Shared Knowledge Base**

(1) All agents share the same KNOWLEDGE/ directory:
- `DEVELOPER-GUIDE.md`
- `DEVELOPMENT-PRACTICES.md`
- `GOTCHAS.md`
- `ERROR-CATALOG.md`
- `TOOL-NOTES.md`

(2) When an agent discovers a gotcha or error pattern:
- The agent MUST update the appropriate KNOWLEDGE/ file
- The update MUST include the agent identifier
- A Work Order MUST be created for the update

### **Article 9: Knowledge Update Procedure**

(1) Before updating a KNOWLEDGE/ file:
- Read the current content
- Check if the information already exists
- If new, append (do not overwrite existing content)

(2) Update format:

```markdown
### GOTCHA-XXX: [Title]
**Discovered:** YYYY-MM-DD (Agent: [agent-id], CWO-YYYY-XXX)
**Problem:** [Description]
**Solution:** [Resolution]
```

(3) After updating:
- Update the already opened Work Order with the actual knowledge update evidence
- Other agents should periodically re-read KNOWLEDGE/ files

---

## CHAPTER V: FILE ACCESS COORDINATION

### **Article 10: File Locking**

(1) Agents MUST NOT simultaneously modify the same file.

(2) Before modifying a file, the agent SHOULD:
- Check if any other agent has indicated intent to modify
- If unclear, request clarification from Orchestrator
- Proceed only when assured of exclusive access

(3) The Orchestrator SHOULD:
- Assign distinct file sets to each agent when possible
- Manage file access conflicts when they arise

### **Article 11: Registry.json Atomicity**

(1) Coordinate one registry writer unless an actual atomic adapter/lock is available. Function schemas alone do not provide locking.

(2) Direct-file fallback: serialize writers, read current file, save/register active entries before work, synchronize updates/closure, and read back the exact target. A plain read-modify-write is not race-proof. Preserve terminal results; linked corrections change currentStatus only. Reservation status "reserved" belongs to sequenceReservations, not workOrders lifecycle status.

(3) On conflict stop, reread and coordinate before retrying; never overwrite another writer's data.

---

## CHAPTER VI: COMMUNICATION

### **Article 12: Inter-Agent Communication**

(1) Agents do NOT communicate directly with each other.

(2) All coordination flows through:
- The Orchestrator (for task assignment and conflict resolution)
- registry.json (for Work Order coordination)
- KNOWLEDGE/ files (for shared learnings)

(3) An agent requiring information from another agent MUST:
- Request the information from the Orchestrator
- OR read it from KNOWLEDGE/ files if documented there

### **Article 13: Reporting to Orchestrator**

(1) Agents MUST report to the Orchestrator:
- Task completion (with Work Order reference)
- Errors encountered (with CWO reference)
- Conflicts detected (immediately, before proceeding)
- Blocking issues (requesting guidance)

(2) Report format:

```
AGENT REPORT
Agent ID: [identifier]
Status: COMPLETE | ERROR | CONFLICT | BLOCKED
Work Order: WO-YYYY-XXX or CWO-YYYY-XXX
Details: [brief description]
```

---

## CHAPTER VII: ERROR HANDLING

### **Article 14: Agent-Level Errors**

(1) When an agent encounters an error:
- Follow standard error protocol (AI-INSTRUCTIONS.md Article 7)
- Create Corrective Work Order
- Update KNOWLEDGE/ERROR-CATALOG.md if new error type
- Report to Orchestrator

(2) Agent errors do NOT affect other agents unless:
- They involve shared resources (files, registry.json)
- They block tasks that other agents depend on

### **Article 15: System-Level Errors**

(1) System-level errors (affecting multiple agents) require:
- ALL agents to STOP work
- Orchestrator to assess the situation
- Coordinated resolution
- Orchestrator to clear agents to resume

(2) Examples of system-level errors:
- registry.json corruption
- Git repository state issues
- Build system failures affecting all agents

---

## CHAPTER VIII: VERIFICATION

### **Article 16: Orchestrator Verification**

(1) Before declaring multi-agent work complete, the Orchestrator MUST verify:

- [ ] All agents have reported completion or blocking
- [ ] All Work Orders are present in registry.json
- [ ] All CWOs are resolved (or escalated)
- [ ] KNOWLEDGE/ updates are consistent
- [ ] No sequence number gaps or duplicates
- [ ] All modified files are in expected state

(2) Verification failures require investigation before proceeding.

### **Article 17: Agent Self-Verification**

(1) Before reporting completion, each agent MUST verify:

- [ ] Work Order created for all completed tasks
- [ ] CWO created for all errors encountered
- [ ] KNOWLEDGE/ updated if new learnings
- [ ] registry.json updated with WO metadata
- [ ] No uncommitted protocol violations

---

## CHAPTER IX: FINAL PROVISIONS

### **Article 18: Protocol Violations**

(1) If an agent violates this protocol:
- The agent MUST create a CWO for the violation
- The Orchestrator MUST be notified
- The agent MUST not proceed until violation is addressed

(2) Common violations:
- Creating Work Order without sequence reservation
- Modifying file being modified by another agent
- Failing to read governance documents
- Ignoring conflict and proceeding

### **Article 19: Entry Into Force**

(1) This protocol is binding for all multi-agent operations under TEJL governance.

(2) It supplements but does not replace AI-INSTRUCTIONS.md.

(3) Updates to this protocol require REVISION Phase approval.

---

**Compiled by:**
AI Assistant, System Integration Sector

**Approved by:**
Operator, Board for Standardization and Development of TEJL
