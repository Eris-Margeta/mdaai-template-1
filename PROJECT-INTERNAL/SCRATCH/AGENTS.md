# AGENTS.md - Scratch Space Navigation

<!-- Parent: ../../AGENTS.md -->

This directory is a **temporary workspace** for active debugging and error resolution.

---

## Directory Purpose

The SCRATCH folder holds temporary task lists and notes created during Beta phase error handling workflow. Files here are ephemeral - created when analyzing issues and deleted after resolution.

**PERMISSION LEVEL:** Full AI read/write (temporary files only)

---

## Usage

### When to Use SCRATCH

Per BETA-PHASE-PROTOCOL.md, when an error is found:
1. Create a task list file: `SCRATCH/TASK-{issue-description}.md`
2. Document root cause analysis
3. List steps to fix
4. Track test creation/improvement
5. Delete file after issue resolved

### File Naming Convention

- `TASK-{short-description}.md` - Active task lists
- `ANALYSIS-{short-description}.md` - Root cause analysis notes

### Cleanup Rule

**All files in SCRATCH should be deleted after issue resolution.**
Do NOT commit SCRATCH files to version control (except AGENTS.md and .gitkeep).

---

## For AI Agents

1. Create task files here when entering Beta error workflow
2. Use clear, descriptive filenames
3. Delete files after completing the fix
4. Never leave stale task files
