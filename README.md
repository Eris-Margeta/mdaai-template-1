# MDAAI 1 template

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brand/logo-white.svg">
  <source media="(prefers-color-scheme: light)" srcset="assets/brand/logo-black.svg">
  <img alt="MDAAI coiled guardian emblem" src="assets/brand/logo-black.svg" width="112" height="112">
</picture>

For any agent system, point its entry instructions to the nearest AGENTS.md. Applicable parent and scoped governance files are cumulative.

Canonical public template by Eris Margeta Kurdali. Apache-2.0; inherited MIT notices are retained in `licenses/legacy-MIT.txt`. Owner-authorized licensing revision, not a literal original source license.

Read `AGENTS.md` before adoption. Review-before-adoption: uninitialized scaffolds and known source cross-reference gaps are deliberately retained. Copy only selected payloads and reconcile existing project authority. No installer or automatic rollout is provided. Inherited scripts are not run by our checks.

Named template **MDAAI 1.0**, correction release **1.0.1** (RELEASE), constitution internal revision **1.8**. `TEMPLATE-IDENTITY.json` is the single package identity, independent of the standalone MDAAI protocol and derived-project versions. Historical VERSION 1.0.0 / constitution revision 1.7 are retained as origin metadata, not equated.

Active Work Orders are editable; COMPLETE/VOID results are preserved. Register direct bounded authority and OPEN before implementation; CLOSE only with real evidence. Later defects get linked records and current-status updates. Schemas are declarative contracts, not implemented enforcement. Catalog admission is separate and requires a reviewed immutable-source PR; this package does not claim downstream adoption.

Development and CI pin: Python **3.13.14**, read from `.python-version`. Catalog validators retain Python 3.11+ compatibility; protocol historical language examples are provenance, not active packaging pins. No global Python replacement is required.

Validate: `python scripts/validate_template.py`; `python -m unittest discover -s tests -v`.

Propose changes here first. Catalog registration is a separately reviewed PR to https://github.com/Eris-Margeta/mdaai-templates with immutable commit and hashes. Website: https://www.mdaai.internet.technology/templates/ . Original per-file provenance and adaptations: `export-manifest.json`.
