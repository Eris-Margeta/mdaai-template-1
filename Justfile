# Justfile - Task automation for TEJL projects
# https://github.com/casey/just

# Default recipe - show help
default:
    @just --list

# =============================================================================
# TEMPLATE MANAGEMENT
# =============================================================================

# Validate project structure against template requirements
validate:
    @./.template/scripts/validate.sh .

# Sync updates from template repository
sync-downstream:
    @./.template/scripts/sync-downstream.sh .

# Check for contributions to send upstream
sync-upstream:
    @./.template/scripts/sync-upstream.sh .

# =============================================================================
# DEVELOPMENT
# =============================================================================

# Install dependencies (override per project)
install:
    @echo "Override this recipe in your project's Justfile"

# Build the project (override per project)
build:
    @echo "Override this recipe in your project's Justfile"

# Run development server (override per project)
dev:
    @echo "Override this recipe in your project's Justfile"

# Run tests (override per project)
test:
    @echo "Override this recipe in your project's Justfile"

# Run linter (override per project)
lint:
    @echo "Override this recipe in your project's Justfile"

# Format code (override per project)
fmt:
    @echo "Override this recipe in your project's Justfile"

# =============================================================================
# DOCUMENTATION
# =============================================================================

# Render Mermaid diagrams from docs/diagrams/*.mmd into docs/assets/*.svg
diagrams:
    #!/usr/bin/env bash
    set -euo pipefail

    if ! command -v mmdc >/dev/null 2>&1; then
        if ! command -v pnpm >/dev/null 2>&1; then
            echo "ERROR: Mermaid CLI is required. Install mmdc or pnpm."
            echo "Install option: pnpm add -g @mermaid-js/mermaid-cli"
            exit 1
        fi
        RENDERER="pnpm dlx --allow-build=puppeteer @mermaid-js/mermaid-cli"
    else
        RENDERER="mmdc"
    fi

    if [ -z "${PUPPETEER_EXECUTABLE_PATH:-}" ]; then
        if [ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
            export PUPPETEER_EXECUTABLE_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
            export PUPPETEER_SKIP_DOWNLOAD=true
        else
            browser="$(find "$HOME/.cache/puppeteer" "$HOME/Library/Caches/ms-playwright" -type f -name chrome-headless-shell -perm -111 2>/dev/null | sort | tail -n 1 || true)"
            if [ -n "$browser" ]; then
                export PUPPETEER_EXECUTABLE_PATH="$browser"
                export PUPPETEER_SKIP_DOWNLOAD=true
            fi
        fi
    fi

    mkdir -p docs/assets

    shopt -s nullglob
    sources=(docs/diagrams/*.mmd)
    if [ ${#sources[@]} -eq 0 ]; then
        echo "No Mermaid source files found in docs/diagrams/"
        exit 0
    fi

    for source in "${sources[@]}"; do
        name="$(basename "${source%.mmd}")"
        target="docs/assets/${name}.svg"
        echo "Rendering ${source} -> ${target}"
        ${RENDERER} -i "${source}" -o "${target}" -c docs/diagrams/mermaid-config.json --backgroundColor transparent
    done

# Show current project status
status:
    @echo "=== Project Status ==="
    @echo ""
    @echo "Version: $(cat VERSION 2>/dev/null || echo 'Not set')"
    @echo ""
    @echo "Recent Work Orders:"
    @cat PROJECT-INTERNAL/WORK-ORDERS/registry.json 2>/dev/null | head -20 || echo "No registry found"

# Show work order count
wo-count:
    @echo "Work Orders:"
    @ls -1 PROJECT-INTERNAL/WORK-ORDERS/WO-*.md 2>/dev/null | wc -l | xargs echo "  Standard:"
    @ls -1 PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/CWO-*.md 2>/dev/null | wc -l | xargs echo "  Corrective:"

# =============================================================================
# UTILITIES
# =============================================================================

# Clean build artifacts (override per project)
clean:
    @echo "Override this recipe in your project's Justfile"

# Show all AGENTS.md files
agents:
    @echo "=== AGENTS.md Files ==="
    @find . -name "AGENTS.md" -type f | sort
