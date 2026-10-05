# Corrective Work Order CWO-YYYY-NNN — [description]

Class: [project-meta.yaml work_orders.class_prefix]
Reference Number: [project-meta.yaml work_orders.reference_prefix + year/type/unique sequence]
Date: [DD.MM.YYYY]
Executor: [project-meta.yaml operator.name]
Subject: [bounded planned work]
Status: PENDING
Created: [ISO date-time]
Last Updated: [ISO date-time]

## AUTHORIZATION
Source: [project-elaboration OR direct-operator-request]
Task Reference: [PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md section OR exact dated operator request]
Authorized By: [human operator]
Scope and exclusions: [bounded authorized changes; no unrelated external authority]
Related ADR / dependencies: [actual links if applicable, otherwise N/A with reason]

## INCIDENT CLASSIFICATION
[Severity, category, discovery method and observed error]

## RELATED ORIGINAL WORK ORDER
[Exact original ID/path if known; do not rewrite terminal original]

## ROOT CAUSE AND PREVENTION
Pending investigation; actual root cause/prevention required on closure.

## OBJECTIVE
[Measurable goal]

## TECHNICAL SPECIFICATION
[Exact authorized files and planned changes]

## RATIONALE
[Reasoning]

## VERIFICATION STEPS
[Exact commands/checks and acceptance criteria; plans, not executed effects]

## EXPECTED OUTCOME
[Measurable criteria]

## PROGRESS
[Timestamped active updates; editable while PENDING, IN PROGRESS or BLOCKED]

## FILES CHANGED
Pending execution; record actual paths/actions/diff counts after work.

## VERIFICATION RESULTS
Pending execution; record actual commands, exit codes, output/evidence and criterion outcomes.

## EXPENDITURE
Estimated: [human effort estimate, optional]
Actual: pending execution; do not substitute estimate.
Material: Consumables [list actual external resources if used]

## ELABORATION REVIEW
Pending closure; update actual planning impact or record no roadmap update required.

## CLOSURE
Completed: [empty until verified closure]
Void reason: [only for abandonment]

## Usage contract
Reserve -> save -> register -> OPEN as IN PROGRESS before implementation. No completed tests/results are required at creation. Update active document and registry while executing. Close COMPLETE only with actual files, checks, satisfied criteria, expenditure, completed timestamp and Elaboration review. Failure blocks successful closure; record blocker and BLOCKED instead. VOID retains file and reason. Preserve COMPLETE/VOID terminal results; later defects require linked corrective/new records and current registry status updates, never rewriting closed evidence. Full state mapping, paths and schemas: `PROJECT-INTERNAL/GOVERNANCE/WORK-ORDER-PROTOCOL.md`. This is an unexecuted template, not an execution example.
