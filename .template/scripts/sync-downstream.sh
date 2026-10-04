#!/bin/bash
# sync-downstream.sh
# Syncs template updates INTO a project
#
# Usage: ./sync-downstream.sh [project-path]
#        TEMPLATE_REPO=url ./sync-downstream.sh [project-path]

set -e

# Configuration
PROJECT_ROOT="${1:-.}"
TEMPLATE_REPO="${TEMPLATE_REPO:-https://github.com/your-org/repo-template-core.git}"
BACKUP_DIR=".template/sync-backups/$(date +%Y%m%d_%H%M%S)"

echo "==============================================="
echo "DOWNSTREAM SYNC - Template to Project"
echo "==============================================="
echo "Project: $PROJECT_ROOT"
echo "Template: $TEMPLATE_REPO"
echo ""

# Check if project-meta.yaml exists
if [ ! -f "$PROJECT_ROOT/project-meta.yaml" ]; then
  echo "ERROR: project-meta.yaml not found in $PROJECT_ROOT"
  echo "This doesn't appear to be a valid project directory."
  exit 1
fi

# Read project language - extract quoted value, strip comments
LANGUAGE=$(grep -E "^\s+language:" "$PROJECT_ROOT/project-meta.yaml" | sed 's/.*: *"\([^"]*\)".*/\1/' | head -1)
echo "Detected language: $LANGUAGE"
echo ""

# Create temp directory for template
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

echo "Cloning template repository..."
git clone --depth 1 "$TEMPLATE_REPO" "$TEMP_DIR" 2>/dev/null || {
  echo "ERROR: Failed to clone template repository"
  echo "Please set TEMPLATE_REPO environment variable to a valid URL"
  exit 1
}

# Create backup directory
echo "Creating backup at: $BACKUP_DIR"
mkdir -p "$PROJECT_ROOT/$BACKUP_DIR"

# Files that always sync
ALWAYS_FILES=(
  "AGENTS.md"
  "SECURITY.md"
  "CONTRIBUTING.md"
  "CODE_OF_CONDUCT.md"
  "PROJECT-INTERNAL/AGENTS.md"
  "PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md"
  "PROJECT-INTERNAL/GOVERNANCE/MULTI-AGENT-PROTOCOL.md"
  "PROJECT-INTERNAL/GOVERNANCE/WORK-ORDER-PROTOCOL.md"
  "PROJECT-INTERNAL/GOVERNANCE/CHECKPOINT-PROTOCOL.md"
  "PROJECT-INTERNAL/GOVERNANCE/DOCUMENTATION-PROTOCOL.md"
  "PROJECT-INTERNAL/GOVERNANCE/LIFECYCLE-PHASES-PROTOCOL.md"
  "PROJECT-INTERNAL/GOVERNANCE/BETA-PHASE-PROTOCOL.md"
  "PROJECT-INTERNAL/GOVERNANCE/AGENTS.md"
  "PROJECT-INTERNAL/ANALYSIS/AGENTS.md"
  "PROJECT-INTERNAL/ANALYSIS/analysis-report-template.md"
  "PROJECT-INTERNAL/ARCHITECTURE/adr-template.md"
  "PROJECT-INTERNAL/ARCHITECTURE/ADR-000-record-architecture-decisions.md"
  "PROJECT-INTERNAL/ARCHITECTURE/AGENTS.md"
  "PROJECT-INTERNAL/WORK-ORDERS/work-order-template.md"
  "PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/corrective-work-order-template.md"
  "PROJECT-INTERNAL/WORK-ORDERS/AGENTS.md"
  "PROJECT-INTERNAL/CHECKPOINTS/checkpoint-template.md"
  "PROJECT-INTERNAL/CHECKPOINTS/AGENTS.md"
  "PROJECT-INTERNAL/KNOWLEDGE/AGENTS.md"
  "PROJECT-INTERNAL/MANAGEMENT/AGENTS.md"
  "PROJECT-INTERNAL/GUIDES/AGENTS.md"
  "PROJECT-INTERNAL/GUIDES/CODE-PHILOSOPHY.md"
  "PROJECT-INTERNAL/GUIDES/TESTING-PHILOSOPHY.md"
  "PROJECT-INTERNAL/SCRATCH/AGENTS.md"
  "PROJECT-INTERNAL/SCRATCH/.gitkeep"
  "PROJECT-INTERNAL/SCRATCH/TASK-TEMPLATE.md"
  "PROJECT-INTERNAL/AI/AGENTS.md"
  "PROJECT-INTERNAL/AI/functions/work-orders.json"
  "PROJECT-INTERNAL/AI/functions/registry.json"
  "PROJECT-INTERNAL/AI/functions/reporting.json"
  "docs/AGENTS.md"
  "docs/diagrams/mermaid-config.json"
  ".template/agent-rules.yaml"
  ".template/sync-manifest.yaml"
)

echo ""
echo "Syncing core protocol files..."
for file in "${ALWAYS_FILES[@]}"; do
  if [ -f "$TEMP_DIR/$file" ]; then
    # Create directory if needed
    mkdir -p "$(dirname "$PROJECT_ROOT/$file")"

    # Backup existing file if present
    if [ -f "$PROJECT_ROOT/$file" ]; then
      mkdir -p "$(dirname "$PROJECT_ROOT/$BACKUP_DIR/$file")"
      cp "$PROJECT_ROOT/$file" "$PROJECT_ROOT/$BACKUP_DIR/$file"
    fi

    # Copy from template
    cp "$TEMP_DIR/$file" "$PROJECT_ROOT/$file"
    echo "  ✓ $file"
  fi
done

# Sync language-specific files
echo ""
echo "Syncing $LANGUAGE-specific files..."

case "$LANGUAGE" in
rust)
  if [ -f "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/RUST-ENTERPRISE-CODE-DOCTRINE.md" ]; then
    cp "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/RUST-ENTERPRISE-CODE-DOCTRINE.md" \
      "$PROJECT_ROOT/PROJECT-INTERNAL/GUIDES/"
    echo "  ✓ RUST-ENTERPRISE-CODE-DOCTRINE.md"
  fi
  ;;
go)
  if [ -f "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/GO-ENTERPRISE-CODE-DOCTRINE.md" ]; then
    cp "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/GO-ENTERPRISE-CODE-DOCTRINE.md" \
      "$PROJECT_ROOT/PROJECT-INTERNAL/GUIDES/"
    echo "  ✓ GO-ENTERPRISE-CODE-DOCTRINE.md"
  fi
  ;;
python)
  if [ -f "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/PYTHON-ENTERPRISE-CODE-DOCTRINE.md" ]; then
    cp "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/PYTHON-ENTERPRISE-CODE-DOCTRINE.md" \
      "$PROJECT_ROOT/PROJECT-INTERNAL/GUIDES/"
    echo "  ✓ PYTHON-ENTERPRISE-CODE-DOCTRINE.md"
  fi
  ;;
node)
  if [ -f "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/NODE-ENTERPRISE-CODE-DOCTRINE.md" ]; then
    cp "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/NODE-ENTERPRISE-CODE-DOCTRINE.md" \
      "$PROJECT_ROOT/PROJECT-INTERNAL/GUIDES/"
    echo "  ✓ NODE-ENTERPRISE-CODE-DOCTRINE.md"
  fi
  if [ -f "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/HTML-CSS-ENTERPRISE-CODE-DOCTRINE.md" ]; then
    cp "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/HTML-CSS-ENTERPRISE-CODE-DOCTRINE.md" \
      "$PROJECT_ROOT/PROJECT-INTERNAL/GUIDES/"
    echo "  ✓ HTML-CSS-ENTERPRISE-CODE-DOCTRINE.md"
  fi
  ;;
polyglot)
  for guide in RUST-ENTERPRISE-CODE-DOCTRINE.md GO-ENTERPRISE-CODE-DOCTRINE.md PYTHON-ENTERPRISE-CODE-DOCTRINE.md NODE-ENTERPRISE-CODE-DOCTRINE.md HTML-CSS-ENTERPRISE-CODE-DOCTRINE.md; do
    if [ -f "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/$guide" ]; then
      cp "$TEMP_DIR/PROJECT-INTERNAL/GUIDES/$guide" \
        "$PROJECT_ROOT/PROJECT-INTERNAL/GUIDES/"
      echo "  ✓ $guide"
    fi
  done
  ;;
esac

# Copy sync scripts
echo ""
echo "Syncing sync scripts..."
mkdir -p "$PROJECT_ROOT/.template/scripts"
cp "$TEMP_DIR/.template/scripts/"*.sh "$PROJECT_ROOT/.template/scripts/" 2>/dev/null || true
chmod +x "$PROJECT_ROOT/.template/scripts/"*.sh 2>/dev/null || true
echo "  ✓ Sync scripts updated"

echo ""
echo "==============================================="
echo "SYNC COMPLETE"
echo "==============================================="
echo ""
echo "Backup created at: $BACKUP_DIR"
echo ""
echo "Review changes with: git diff"
echo "Commit with: git add . && git commit -m 'sync: update from template'"
