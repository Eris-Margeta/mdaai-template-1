# MDAAI 1 template

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brand/logo-white.svg">
  <source media="(prefers-color-scheme: light)" srcset="assets/brand/logo-black.svg">
  <img alt="MDAAI coiled guardian emblem" src="assets/brand/logo-black.svg" width="112" height="112">
</picture>

For any agent system, point its entry instructions to the nearest AGENTS.md. Applicable parent and scoped governance files are cumulative.

Canonical public template by Eris Margeta Kurdali. Apache-2.0; inherited MIT notices are retained in `licenses/legacy-MIT.txt`. Owner-authorized licensing revision, not a literal original source license.

Read `AGENTS.md` before adoption. Review-before-adoption: uninitialized scaffolds and known source cross-reference gaps are deliberately retained. Copy only selected payloads and reconcile existing project authority. No installer or automatic rollout is provided. Inherited scripts are not run by our checks.

First-generation family: VERSION 1.0.0, AI-INSTRUCTIONS subject 1.7; not a pristine v1.0 release.

Development and CI pin: Python **3.13.14**, read from `.python-version`. Catalog validators retain Python 3.11+ compatibility; protocol historical language examples are provenance, not active packaging pins. No global Python replacement is required.

Validate: `python scripts/validate_template.py`; `python -m unittest discover -s tests -v`.

Propose changes here first. Catalog registration is a separately reviewed PR to https://github.com/Eris-Margeta/mdaai-templates with immutable commit and hashes. Website: https://www.mdaai.internet.technology/templates/ . Original per-file provenance and adaptations: `export-manifest.json`.
