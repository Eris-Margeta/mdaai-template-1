#!/bin/bash
# validate.sh
# Validates project structure against template requirements
#
# Usage: ./validate.sh [project-path]

set -e

PROJECT_ROOT="${1:-.}"
ERRORS=0
WARNINGS=0

echo "==============================================="
echo "PROJECT STRUCTURE VALIDATION"
echo "==============================================="
echo "Project: $PROJECT_ROOT"
echo ""

# Helper functions
check_file() {
  local file="$1"
  local required="$2"

  if [ -f "$PROJECT_ROOT/$file" ]; then
    echo "  ✓ $file"
    return 0
  else
    if [ "$required" = "required" ]; then
      echo "  ✗ $file (MISSING - REQUIRED)"
      ((ERRORS++))
    else
      echo "  ⚠ $file (missing - optional)"
      ((WARNINGS++))
    fi
    return 0
  fi
}

check_dir() {
  local dir="$1"
  local required="$2"

  if [ -d "$PROJECT_ROOT/$dir" ]; then
    echo "  ✓ $dir/"
    return 0
  else
    if [ "$required" = "required" ]; then
      echo "  ✗ $dir/ (MISSING - REQUIRED)"
      ((ERRORS++))
    else
      echo "  ⚠ $dir/ (missing - optional)"
      ((WARNINGS++))
    fi
    return 0
  fi
}

# Check root files
echo "Root Files:"
echo "-----------"
check_file "AGENTS.md" "required"
check_file "project-meta.yaml" "required"
check_file "VERSION" "required"
check_file "README.md" "required"
check_file "LICENSE" "optional"
check_file "SECURITY.md" "required"
check_file "CONTRIBUTING.md" "required"
check_file "CODE_OF_CONDUCT.md" "required"
check_file "Justfile" "optional"

# Check directories
echo ""
echo "Directory Structure:"
echo "--------------------"
check_dir "PROJECT-INTERNAL" "required"
check_dir "PROJECT-INTERNAL/GOVERNANCE" "required"
check_dir "PROJECT-INTERNAL/MANAGEMENT" "required"
check_dir "PROJECT-INTERNAL/ANALYSIS" "required"
check_dir "PROJECT-INTERNAL/ARCHITECTURE" "required"
check_dir "PROJECT-INTERNAL/GUIDES" "required"
check_dir "PROJECT-INTERNAL/KNOWLEDGE" "required"
check_dir "PROJECT-INTERNAL/WORK-ORDERS" "required"
check_dir "PROJECT-INTERNAL/CHECKPOINTS" "required"
check_dir ".template" "required"

# Check governance files
echo ""
echo "Governance Documents:"
echo "--------------------"
check_file "PROJECT-INTERNAL/GOVERNANCE/AI-INSTRUCTIONS.md" "required"
check_file "PROJECT-INTERNAL/GOVERNANCE/MULTI-AGENT-PROTOCOL.md" "required"
check_file "PROJECT-INTERNAL/GOVERNANCE/WORK-ORDER-PROTOCOL.md" "required"
check_file "PROJECT-INTERNAL/GOVERNANCE/CHECKPOINT-PROTOCOL.md" "required"
check_file "PROJECT-INTERNAL/GOVERNANCE/AGENTS.md" "required"

# Check management files
echo ""
echo "Management Documents:"
echo "--------------------"
check_file "PROJECT-INTERNAL/MANAGEMENT/PROJECT-ELABORATION.md" "required"
check_file "PROJECT-INTERNAL/MANAGEMENT/VISION.md" "optional"
check_file "PROJECT-INTERNAL/MANAGEMENT/ROADMAP.md" "optional"
check_file "PROJECT-INTERNAL/MANAGEMENT/AGENTS.md" "required"

# Check analysis files
echo ""
echo "Analysis Documents:"
echo "------------------"
check_file "PROJECT-INTERNAL/ANALYSIS/AGENTS.md" "required"
check_file "PROJECT-INTERNAL/ANALYSIS/analysis-report-template.md" "required"

# Check architecture files
echo ""
echo "Architecture Documents:"
echo "----------------------"
check_file "PROJECT-INTERNAL/ARCHITECTURE/adr-template.md" "required"
check_file "PROJECT-INTERNAL/ARCHITECTURE/ADR-000-record-architecture-decisions.md" "required"
check_file "PROJECT-INTERNAL/ARCHITECTURE/AGENTS.md" "required"

# Check knowledge files
echo ""
echo "Knowledge Documents:"
echo "-------------------"
check_file "PROJECT-INTERNAL/KNOWLEDGE/DEVELOPER-GUIDE.md" "required"
check_file "PROJECT-INTERNAL/KNOWLEDGE/DEVELOPMENT-PRACTICES.md" "required"
check_file "PROJECT-INTERNAL/KNOWLEDGE/GOTCHAS.md" "required"
check_file "PROJECT-INTERNAL/KNOWLEDGE/ERROR-CATALOG.md" "required"
check_file "PROJECT-INTERNAL/KNOWLEDGE/TOOL-NOTES.md" "optional"
check_file "PROJECT-INTERNAL/KNOWLEDGE/AGENTS.md" "required"

# Check work order files
echo ""
echo "Work Order System:"
echo "-----------------"
check_file "PROJECT-INTERNAL/WORK-ORDERS/registry.json" "required"
check_file "PROJECT-INTERNAL/WORK-ORDERS/work-order-template.md" "required"
check_file "PROJECT-INTERNAL/WORK-ORDERS/AGENTS.md" "required"
check_dir "PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE" "required"
check_file "PROJECT-INTERNAL/WORK-ORDERS/CORRECTIVE/corrective-work-order-template.md" "required"

# Check checkpoint files
echo ""
echo "Checkpoint System:"
echo "-----------------"
check_file "PROJECT-INTERNAL/CHECKPOINTS/checkpoint-template.md" "required"
check_file "PROJECT-INTERNAL/CHECKPOINTS/AGENTS.md" "required"

# Check AI configuration files
echo ""
echo "AI Configuration:"
echo "----------------"
check_dir "PROJECT-INTERNAL/AI" "required"
check_dir "PROJECT-INTERNAL/AI/functions" "required"
check_file "PROJECT-INTERNAL/AI/AGENTS.md" "required"
check_file "PROJECT-INTERNAL/AI/functions/work-orders.json" "required"
check_file "PROJECT-INTERNAL/AI/functions/registry.json" "required"
check_file "PROJECT-INTERNAL/AI/functions/reporting.json" "required"

# Check template files
echo ""
echo "Template Management:"
echo "-------------------"
check_file ".template/agent-rules.yaml" "required"
check_file ".template/sync-manifest.yaml" "required"
check_dir ".template/scripts" "optional"

# Check style guides based on language
echo ""
echo "Style Guides:"
echo "------------"
if [ -f "$PROJECT_ROOT/project-meta.yaml" ]; then
  # Extract language - handle quoted values and strip comments
  LANGUAGE=$(grep -E "^\s+language:" "$PROJECT_ROOT/project-meta.yaml" | sed 's/.*: *"\([^"]*\)".*/\1/' | head -1)

  # Check if this is the template repo itself (not a derived project)
  PROJECT_NAME=$(grep -E "^name:" "$PROJECT_ROOT/project-meta.yaml" | sed 's/.*: *"\([^"]*\)".*/\1/' | head -1)
  IS_TEMPLATE=$(grep -E "^\s+- \"template\"" "$PROJECT_ROOT/project-meta.yaml" || true)

  if [ "$PROJECT_NAME" = "project-name" ] || [ -n "$IS_TEMPLATE" ]; then
    echo "  [TEMPLATE REPO DETECTED]"
    echo "  This is the template repository itself, not a derived project."
    echo "  All style guides are included as reference:"
    check_file "PROJECT-INTERNAL/GUIDES/RUST-ENTERPRISE-CODE-DOCTRINE.md" "optional"
    check_file "PROJECT-INTERNAL/GUIDES/GO-ENTERPRISE-CODE-DOCTRINE.md" "optional"
    check_file "PROJECT-INTERNAL/GUIDES/PYTHON-ENTERPRISE-CODE-DOCTRINE.md" "optional"
    check_file "PROJECT-INTERNAL/GUIDES/NODE-ENTERPRISE-CODE-DOCTRINE.md" "optional"
    check_file "PROJECT-INTERNAL/GUIDES/HTML-CSS-ENTERPRISE-CODE-DOCTRINE.md" "optional"
  else
    echo "  Language: $LANGUAGE"

    case "$LANGUAGE" in
    rust)
      check_file "PROJECT-INTERNAL/GUIDES/RUST-ENTERPRISE-CODE-DOCTRINE.md" "required"
      ;;
    go)
      check_file "PROJECT-INTERNAL/GUIDES/GO-ENTERPRISE-CODE-DOCTRINE.md" "required"
      ;;
    python)
      check_file "PROJECT-INTERNAL/GUIDES/PYTHON-ENTERPRISE-CODE-DOCTRINE.md" "required"
      ;;
    node)
      check_file "PROJECT-INTERNAL/GUIDES/NODE-ENTERPRISE-CODE-DOCTRINE.md" "required"
      ;;
    polyglot)
      check_file "PROJECT-INTERNAL/GUIDES/RUST-ENTERPRISE-CODE-DOCTRINE.md" "optional"
      check_file "PROJECT-INTERNAL/GUIDES/GO-ENTERPRISE-CODE-DOCTRINE.md" "optional"
      check_file "PROJECT-INTERNAL/GUIDES/PYTHON-ENTERPRISE-CODE-DOCTRINE.md" "optional"
      check_file "PROJECT-INTERNAL/GUIDES/NODE-ENTERPRISE-CODE-DOCTRINE.md" "optional"
      ;;
    *)
      echo "  WARNING: Unknown language '$LANGUAGE'"
      ((WARNINGS++))
      ;;
    esac
  fi
fi

# Summary
echo ""
echo "==============================================="
echo "VALIDATION SUMMARY"
echo "==============================================="
echo ""
echo "Errors:   $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "STATUS: FAILED"
  echo ""
  echo "Please fix the required missing files before proceeding."
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "STATUS: PASSED WITH WARNINGS"
  echo ""
  echo "Consider adding the optional files for completeness."
  exit 0
else
  echo "STATUS: PASSED"
  echo ""
  echo "Project structure is valid."
  exit 0
fi
