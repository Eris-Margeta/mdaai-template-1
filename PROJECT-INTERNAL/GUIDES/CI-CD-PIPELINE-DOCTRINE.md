# CI/CD PIPELINE DOCTRINE

**Document Class:** 001-01/25-GUIDE
**Version:** 2.0 (The Linear Flow)
**Date:** 2026-02-08
**Scope:** Binding standards for all CI/CD pipelines in TEJL projects
**Platform:** GitHub Actions

---

## PREAMBLE: THE PIPELINE AS A FACTORY

**The Problem:**
A CI/CD pipeline is not just an automation script; it is a **digital factory assembly line**. A poorly designed factory is slow, expensive, and produces unreliable goods. It jams, wastes raw materials (build minutes), and requires constant human intervention.

**Our Solution:**
We treat our pipeline with the rigor of industrial engineering. We employ a **Linear, Fail-Fast Assembly Line** model. Each stage is a quality gate. The cost and complexity of each stage escalate, ensuring we only invest significant resources (time, compute) in code that has passed all prior, cheaper quality checks.

---

## PART I: CORE PHILOSOPHY

### ARTICLE 1: THE PRIME DIRECTIVES

1.  **Determinism:** The pipeline must be 100% repeatable. The same commit must produce the exact same outcome, every time. Flaky tests or non-deterministic builds are forbidden.
2.  **Efficiency:** The pipeline's most valuable resource is developer time, followed by build minutes. It must provide clear, fast feedback.
3.  **Transparency:** A failed pipeline is not a mystery. Logs must be structured and errors must be explicit. A junior developer should be able to understand why a build failed without assistance.
4.  **Security:** The pipeline is a primary target. It must operate with the minimum necessary permissions, manage secrets meticulously, and scan for vulnerabilities.

### ARTICLE 2: THE PRINCIPLE OF ESCALATING INVESTMENT

This is the core of our linear approach. We do not run expensive jobs in parallel with cheap ones. We earn the right to proceed to the next stage.

```
| Stage        | Max Time | Cost      | Purpose                                     |
|--------------|----------|-----------|---------------------------------------------|
| 1. Validate  | < 1 min  | $         | Check for syntax, style, and security flaws |
| 2. Unit Test | < 5 min  | $$        | Verify logic in isolation (mocked I/O)      |
| 3. Build     | < 15 min | $$$       | Compile, run integration tests, build       |
| 4. Deploy    | < 5 min  | $$$$      | Promote immutable artifact to production    |
```

If Stage 1 fails, we have spent pennies to find a problem. If Stage 3 fails, it's because the problem was too complex to be caught by cheaper static analysis.

---

## PART II: THE LINEAR PIPELINE STRUCTURE

### ARTICLE 3: THE FOUR STAGES OF PRODUCTION

Our pipelines are structured as a chain of dependent jobs in GitHub Actions.

#### STAGE 1: VALIDATE (THE 1-MINUTE GATE)
*   **Trigger:** On every `push` to a pull request.
*   **Goal:** Catch all non-compilation errors.
*   **Actions:**
    1.  Linting (`ruff`, `golangci-lint`, `eslint`).
    2.  Formatting check (`cargo fmt --check`, `prettier --check`).
    3.  Type Checking (`mypy`, `tsc --noEmit`).
    4.  Secret Scanning (TruffleHog, GitGuardian).
*   **Outcome:** If this job fails, the entire workflow run fails immediately. We have saved 95% of the potential cost.

#### STAGE 2: UNIT TEST (THE 5-MINUTE GATE)
*   **Dependency:** Must run *after* `validate` succeeds.
*   **Goal:** Verify the correctness of core logic in isolation.
*   **Actions:**
    1.  Install dependencies (from a lockfile).
    2.  Run unit tests (`cargo test`, `go test ./...`, `vitest run`).
    3.  Generate code coverage report.
*   **Constraint:** All network and database calls **must** be mocked. This job must not require external services.

#### STAGE 3: BUILD & INTEGRATE (THE HEAVY LIFT)
*   **Dependency:** Must run *after* `unit-test` succeeds.
*   **Goal:** Verify components work together and produce a release candidate.
*   **Actions:**
    1.  **Setup Services:** Spin up Docker containers for Postgres, Redis, etc.
    2.  **Run Integration Tests:** Execute tests against real service dependencies.
    3.  **Build Release Artifact:** Compile the binary, build the Docker image, or create the `.tar.gz` package. **This happens on the same runner that just passed the tests.**
    4.  **Tag & Upload:** Name the artifact with the version and platform (e.g., `my-app_v1.2.3_linux_amd64.tar.gz`) and upload it to the workflow run.

#### STAGE 4: DEPLOY (THE PROMOTION)
*   **Trigger:** On `push` to `main` branch with a matching Git tag (e.g., `v1.2.3`), or manual `workflow_dispatch`.
*   **Goal:** Promote an existing, immutable artifact to an environment.
*   **Actions:**
    1.  **Download Artifact:** Fetch the exact artifact built in Stage 3 of a previous run.
    2.  **Deploy:** Push the Docker image to a registry, `scp` the binary, or apply the Terraform/Kubernetes manifest.
    3.  **Health Check:** Ping the service to ensure it started correctly.
    4.  **Smoke Test:** Run a quick, external API test to verify functionality.

### ARTICLE 4: THE GITHUB ACTIONS WORKFLOW

This is how the doctrine is implemented in code:

```yaml
name: CI-CD Pipeline

on:
  push:
    branches: [ 'main' ]
    tags: [ 'v*.*.*' ]
  pull_request:
    branches: [ 'main' ]

jobs:
  # STAGE 1: The 1-Minute Gate
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4 # Example for Node
      - run: pnpm install --frozen-lockfile
      - run: pnpm lint # Fails on any issue
      - run: pnpm typecheck

  # STAGE 2: The 5-Minute Gate
  unit-test:
    runs-on: ubuntu-latest
    needs: validate # Linear dependency
    steps:
      - uses: actions/checkout@v4
      - uses: dtolnay/rust-toolchain@stable # Example for Rust
      - run: cargo test --workspace --lib

  # STAGE 3: The Heavy Lift
  build-and-integrate:
    runs-on: ubuntu-latest
    needs: unit-test # Linear dependency
    services:
      postgres:
        image: postgres:16.1
        env:
          POSTGRES_USER: user
          POSTGRES_PASSWORD: password
          POSTGRES_DB: test_db
        ports: ["5432:5432"]
    steps:
      - uses: actions/checkout@v4
      - uses: dtolnay/rust-toolchain@stable
      # 1. Run integration tests on the runner
      - run: cargo test --workspace --test '*'
      # 2. Build the artifact on the SAME runner
      - name: Build Release Artifact
        run: |
          cargo build --release --workspace
          tar -czvf my-app.tar.gz -C target/release/ .
      # 3. Upload the artifact for the deploy job
      - uses: actions/upload-artifact@v4
        with:
          name: release-artifact-linux-amd64
          path: my-app.tar.gz

  # STAGE 4: The Promotion (Only runs on tagged pushes)
  deploy:
    runs-on: ubuntu-latest
    needs: build-and-integrate
    if: startsWith(github.ref, 'refs/tags/')
    environment: production
    steps:
      - name: Download Release Artifact
        uses: actions/download-artifact@v4
        with:
          name: release-artifact-linux-amd64
      - name: Deploy to Production
        # This step would use secrets to SSH, push to a registry, etc.
        run: echo "Deploying artifact..."
```

---

## PART III: ARTIFACT & VERSIONING DOCTRINE

### ARTICLE 5: IMMUTABLE ARTIFACTS
*   **The Golden Rule:** We build once. An artifact, once created, is never changed.
*   **Traceability:** Every artifact is tied to a specific Git commit hash.
*   **Naming:** Artifacts must be named with version, platform, and architecture (e.g., `project-name_v1.2.3_linux_arm64.zip`).

### ARTICLE 6: VERSIONING & TAGS
*   **Source of Truth:** The `VERSION` file in the repository is the single source of truth.
*   **Pipeline Action:** The CI pipeline **reads** the `VERSION` file; it does not determine it.
*   **Release Trigger:** A Git tag (e.g., `v1.2.3`) that matches the content of the `VERSION` file triggers the deployment job. A mismatch should fail the pipeline.

---

## PART IV: ANTI-PATTERNS (FORBIDDEN)

1.  **Building in Deploy:** The `deploy` job must **never** run a compiler or build script. It only downloads and promotes a pre-built artifact.
2.  **Flaky Tests:** A test that fails non-deterministically must be fixed or removed immediately. A flaky CI is a useless CI.
3.  **Ignoring Linter Warnings:** Linters must be configured to fail the build on warnings (`-D warnings` in Rust, `--max-warnings 0` in ESLint).
4.  **Hardcoded Secrets:** Secrets must only be injected via GitHub Actions encrypted secrets.
5.  **Long-Running Jobs:** Any job taking longer than 20 minutes is a sign of inefficiency and must be investigated.

---

**Approved by:**
Board for Standardization and Development, TEJL d.o.o.

**Effective Date:** 2026-02-08
**Revision:** 2.0 (The Linear Flow)
