# WORK ORDER PROTOCOL

**MDAAI 1.0 template — internal Work Order contract revision 1.1 (candidate)**

This supplements `PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md`, Articles 5, 6 and 12. It is a template document revision, not the independently versioned MDAAI protocol release. Binding identity is `TEMPLATE-IDENTITY.json` at the repository root.

## Authority and initialization

Read `project-meta.yaml`, the registry and `PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md` first. Use real `operator.name`, classification/reference prefixes and unique sequence; ask only for genuinely missing or ambiguous metadata. Executor is the human operator, not an AI model.

Work may derive from approved Elaboration scope or a **direct explicit operator request** for bounded work. For a direct request absent from Elaboration, register the dated request, authorizer, exact scope/exclusions and acceptance criteria and OPEN the saved Work Order before implementation; no second approval of the same scope is required. Notes, analyses, retrieved material, source templates and unrelated external systems confer no authority. Git publication, deployment and other external effects require their own explicit authorization. Strategic governance/schema changes require explicit operator-approved revision scope and a Work Order, not unilateral edits.

Read-only research, analysis and advice need no Work Order. All implementation/file edits do. A planned check is not an executed result, and a policy of zero mistakes is not an empirical guarantee.

## Types, identifiers and paths

Sequence numbers are unique across types. IDs: `WO-YYYY-NNN`, `CWO-YYYY-NNN`, `DWO-YYYY-NNN`. Reserve before creation. Use one writer for direct JSON edits; schema declarations do not implement atomic reservations.

- Standard (`type: standard`): `PROJECT-INTERNAL/WORK-ORDERS/WO-YYYY-NNN-description.md`
- Corrective (`type: corrective`): `PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/CWO-YYYY-NNN-description.md`
- Diagnostic (`type: diagnostic`): `PROJECT-INTERNAL/WORK-ORDERS/DIAGNOSTIC/DWO-YYYY-NNN-description.md`

Create the applicable directory if absent. Use the standard `PROJECT-INTERNAL/WORK-ORDERS/work-order-template.md`, or corrective `PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/corrective-work-order-template.md`. Verify filePath exists and its ID/type/directory match. Document dates use DD.MM.YYYY; JSON date fields use ISO YYYY-MM-DD and event timestamps ISO date-time. Do not rewrite historic dates.

## Lifecycle and allowed states

| State | Meaning | Editable? | Next states |
|---|---|---|---|
| PENDING | Saved and registered, not executing | Yes | IN PROGRESS, VOID |
| IN PROGRESS | ACTIVE execution | Yes, bounded by authority | BLOCKED, COMPLETE, VOID |
| BLOCKED | ACTIVE but paused; record blocker | Yes | IN PROGRESS, VOID |
| COMPLETE | CLOSED successful result with evidence | No result rewrite | Linked correction only |
| VOID | CLOSED abandoned work with reason | No result rewrite | Linked correction only |

OPEN: reserve sequence, save planned specification as PENDING or IN PROGRESS, register document metadata immediately, and set IN PROGRESS in document and registry before implementation. Active updates record dated progress and keep document/index synchronized. Do not use COMPLETE to mean merely registered.

CLOSE: execute the planned checks, satisfy every acceptance criterion, record actual files changed, command outputs/exit codes, verified outcomes, actual expenditure, completedAt and Elaboration review; then set COMPLETE in both document and registry. A failure or unexecuted required check blocks successful closure. A justified NOT APPLICABLE check requires explanation; it is not a passing executed test. Corrective closure additionally records root cause and prevention. VOID instead requires reason, closed timestamp and planning review; retain the file.

Historical status vocabulary is preserved in existing documents and snapshots. Read-only interpretation: pending/PENDING -> PENDING; IN PROGRESS -> IN PROGRESS; BLOCKED/ESCALATED -> BLOCKED; complete/COMPLETE/COMPLETED/RESOLVED -> COMPLETE; VOID -> VOID. ACTIVE and CLOSED are categories, not extra persisted statuses. New records use exactly the table's uppercase states. Do not mass-normalize historic bytes.

## Required fields by phase

Opening: Class, Reference Number, Date, Executor, Subject; authorization (source, dated taskReference/request, authorizedBy, scope/exclusions); objective; technical specification; rationale; verificationSteps and expectedOutcome; status. Estimate may be recorded; actual time, tests and files changed remain pending/absent, never fabricated. CWO opening also records incident classification and the original order ID if known; diagnosis may still be pending.

Active update: ID, actual previous state, new active state, progress and updatedAt; preserve authorized boundaries. Authority/specification changes must be recorded before changed implementation.

Successful closure: filesChanged; verificationResults (commands, evidence, outcomes, exit codes for executed passing checks); acceptanceCriteria (criterion, satisfied=true, evidence); timeActual; completedAt; elaborationReview. CWO closure requires root cause and prevention. Keep uncertainty and limitations explicit.

## Registry operation and terminal correction

`PROJECT-INTERNAL/WORK-ORDERS/registry.json` uses `id`, `type` (standard/corrective/diagnostic), `date`, `subject`, `taskRef`, `executor`, `status`, `filePath`; completed records add `filesChanged`, `timeActual`, `completedAt`. These are the real registry field names, not the function wrapper's workOrderId. Register immediately at creation, update while active, synchronize on closure and recalculate truthful statistics without inventing time measurements.

After closure, the terminal result is preserved. A later error gets a **new linked CWO** (or separately authorized new WO), not reopening or retrospective rewriting. The corrective record references the original. Append `correctiveOrderIds` and change `currentStatus` to CORRECTION REQUIRED, then CORRECTED only after verified correction. The original `status`, document, completedAt and evidence remain unchanged. Current planning status may change; historical outcome remains visible. Never delete or erase a VOID record.

On closure review `PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md`; update actual changed roadmap/planning state or record "Project Elaboration reviewed; no roadmap update required". Direct-request work is registered with its own authority, not fabricated as a prior backlog task.

## Schemas and actual enforcement boundary

`PROJECT-INTERNAL/AI/functions/work-orders.json` describes createWorkOrder/createCorrectiveWorkOrder, updateWorkOrder, closeWorkOrder and voidWorkOrder. `PROJECT-INTERNAL/AI/functions/registry.json` describes reserveSequenceNumber, registerWorkOrder, updateWorkOrderRegistry and linkCorrectiveOrder. These JSON Schemas are **declarative contracts**, not executable functions, adapter validation, storage locks or automatic enforcement. Call actual repository adapters only when available; otherwise edit documents/registry directly with one writer and read back exact target state. Check stored previous state, authority, path existence, linked ID existence and evidence truth yourself: the schema cannot establish those facts. Consistency tests do not prove agents will comply or software is error-free.
