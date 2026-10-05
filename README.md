# MDAAI 1 template

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brand/logo-white.svg">
  <source media="(prefers-color-scheme: light)" srcset="assets/brand/logo-black.svg">
  <img alt="MDAAI coiled guardian emblem" src="assets/brand/logo-black.svg" width="112" height="112">
</picture>

## How to use this template

1. **Choose one template, not both.** This separate, independently versioned repository is a concrete governance layer **over the MDAAI protocol**, intended to apply that protocol to your project. It is not the protocol monorepo or a coding harness. Do not overlay MDAAI 1.0 and MDAAI 2.0 on the same project.
2. **Read the protocol alongside the template.** The public monorepo is [Eris-Margeta/mdaai](https://github.com/Eris-Margeta/mdaai). If cloned as `mdaai/`, its `README.md` is the entry point, `website/content.json` holds the published protocol guidance, and `docs/publication/` explains publication/provenance; `website/` and `tests/` are documentation-site tooling, not files to install in your application. Use the [protocol website](https://www.mdaai.internet.technology/) and [how files work together](https://www.mdaai.internet.technology/how-files-work-together/) as references. Keep the monorepo checkout separate from your project; **do not copy the whole monorepo**.
3. **Copy the governance payload below into your project root after review.** For a new project, add the listed files to its own repository. For an existing project, review a diff and merge applicable instructions and scaffolds; never overwrite its `AGENTS.md`, governance, task history, `README.md`, version or license. Retain the template revision you adopted in your project documentation.

| Action | Files at this template root | Purpose |
| --- | --- | --- |
| Copy (core) | `PROJECT-INTERNAL/` (entire tracked scaffold), `.template/agent-rules.yaml`, `.template/sync-manifest.yaml` | Governance protocols, planning, knowledge, ADR/analysis/WO/checkpoint templates, empty WO registry and declarative function schemas. Keep scoped `AGENTS.md` files. |
| Copy for new project; merge for existing | `AGENTS.md`, `project-meta.yaml`, `SECURITY.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md` | Agent entry, project/operator identity and policies referenced by governance. Replace template-specific contribution text with your project's workflow. |
| Optional; merge if used | `.gitignore`, `.gitattributes`, `Justfile`, `.template/scripts/`, `docs/`, `.github/dependabot.example`, `.github/workflows/.ci.example`, `.github/workflows/.release.example`, `.github/workflows/.sync-repo.example` | Ignore rules, automation and documentation examples. If adopting `Justfile` template-management recipes, also retain `.template/scripts/` and its YAML files; diagram recipes need `docs/diagrams/` and `docs/assets/`. Review dependencies before running scripts. Examples are not active CI; do not enable automatic sync. |
| Retain notices with copied material | `LICENSE`, `NOTICE`, `licenses/legacy-MIT.txt` | Preserve these terms/notices for template-derived files; keep an existing project's root license and store template terms separately if needed. |
| Skip as project payload | `README.md`, `README.source.md`, `VERSION`, `TEMPLATE-IDENTITY.json`, `export-manifest.json`, `.python-version`, `scripts/`, `tests/`, `tools/`, `.github/workflows/template.yml`, `assets/brand/` | Template packaging, source reference, branding and package validation—not your application's identity, CI or runtime. Write your own README/version. |

4. **Initialize before activation.** Set your operator, project, classification and WO numbering in `project-meta.yaml`; replace example scope/lifecycle, planning and knowledge content in `PROJECT-INTERNAL/`. Initialize `PROJECT-INTERNAL/WORK-ORDERS/registry.json` for your project (identity, timestamps, sequence; keep it empty until your own work starts). The exported scaffold has no completed project WOs; do not import upstream/private execution history. Review [known source-link gaps](tests/known-source-link-gaps.json) and resolve relevant references; an export is not an initialized project.
5. **Use it with your agent or manually.** Point agent entry instructions to the nearest `AGENTS.md`; applicable parent and scoped instructions are cumulative. Read `PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md` and task-relevant protocols. `PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md` owns authorized scope; save, register and OPEN a WO before implementation, update it while active, verify the work, then CLOSE it with real evidence and review Elaboration. Preserve terminal results; later defects get linked corrective records. Function schemas describe contracts, not installed tools.
6. **Adopt future changes explicitly.** Review this repository's changes and merge only approved updates. Publication, catalog listing and inherited sync scripts do not authorize rollout. Browse alternatives in the [template catalog](https://github.com/Eris-Margeta/mdaai-templates) or [template directory](https://www.mdaai.internet.technology/templates/).


Canonical public template by Eris Margeta Kurdali. Apache-2.0; inherited MIT notices are retained in `licenses/legacy-MIT.txt`. Owner-authorized licensing revision, not a literal original source license.

Read `AGENTS.md` before adoption. Review-before-adoption: uninitialized scaffolds and known source cross-reference gaps are deliberately retained. Copy only selected payloads and reconcile existing project authority. No installer or automatic rollout is provided. Inherited scripts are not run by our checks.

Named template **MDAAI 1.0**, correction release **1.0.1** (RELEASE), constitution internal revision **1.8**. `TEMPLATE-IDENTITY.json` is the single package identity, independent of the standalone MDAAI protocol and derived-project versions. Historical VERSION 1.0.0 / constitution revision 1.7 are retained as origin metadata, not equated.

Active Work Orders are editable; COMPLETE/VOID results are preserved. Register direct bounded authority and OPEN before implementation; CLOSE only with real evidence. Later defects get linked records and current-status updates. Schemas are declarative contracts, not implemented enforcement. Catalog admission is separate and requires a reviewed immutable-source PR; this package does not claim downstream adoption.

Development and CI pin: Python **3.13.14**, read from `.python-version`. Catalog validators retain Python 3.11+ compatibility; protocol historical language examples are provenance, not active packaging pins. No global Python replacement is required.

Validate: `python scripts/validate_template.py`; `python -m unittest discover -s tests -v`.

Propose changes here first. Catalog registration is a separately reviewed PR to https://github.com/Eris-Margeta/mdaai-templates with immutable commit and hashes. Website: https://www.mdaai.internet.technology/templates/ . Original per-file provenance and adaptations: `export-manifest.json`.
