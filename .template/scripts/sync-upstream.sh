#!/bin/bash
# sync-upstream.sh
# Contributes learnings from project TO template
#
# Usage: ./sync-upstream.sh [project-path]

set -e

PROJECT_ROOT="${1:-.}"
TEMPLATE_REPO="${TEMPLATE_REPO:-https://github.com/your-org/repo-template-core.git}"

echo "==============================================="
echo "UPSTREAM CONTRIBUTION - Project to Template"
echo "==============================================="
echo "Project: $PROJECT_ROOT"
echo "Template: $TEMPLATE_REPO"
echo ""

# Check for DEVELOPMENT-PRACTICES.md
PRACTICES_FILE="$PROJECT_ROOT/PROJECT-INTERNAL/KNOWLEDGE/DEVELOPMENT-PRACTICES.md"

if [ ! -f "$PRACTICES_FILE" ]; then
    echo "No DEVELOPMENT-PRACTICES.md found."
    echo "Nothing to contribute upstream."
    exit 0
fi

# Clone template to compare
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

echo "Cloning template for comparison..."
git clone --depth 1 "$TEMPLATE_REPO" "$TEMP_DIR" 2>/dev/null || {
    echo "ERROR: Failed to clone template repository"
    exit 1
}

TEMPLATE_PRACTICES="$TEMP_DIR/PROJECT-INTERNAL/KNOWLEDGE/DEVELOPMENT-PRACTICES.md"

# Count articles in each
LOCAL_ARTICLES=$(grep -c "^## \*\*Article" "$PRACTICES_FILE" 2>/dev/null || echo "0")
TEMPLATE_ARTICLES=$(grep -c "^## \*\*Article" "$TEMPLATE_PRACTICES" 2>/dev/null || echo "0")

echo ""
echo "Local articles: $LOCAL_ARTICLES"
echo "Template articles: $TEMPLATE_ARTICLES"

if [ "$LOCAL_ARTICLES" -gt "$TEMPLATE_ARTICLES" ]; then
    NEW_COUNT=$((LOCAL_ARTICLES - TEMPLATE_ARTICLES))
    echo ""
    echo "Found $NEW_COUNT new article(s) that could be contributed!"
    echo ""

    # Show the diff
    echo "Differences found:"
    echo "=================="
    diff "$TEMPLATE_PRACTICES" "$PRACTICES_FILE" || true
    echo ""

    read -p "Would you like to create a PR to contribute these learnings? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        echo "To contribute, please:"
        echo "1. Fork the template repository"
        echo "2. Copy your DEVELOPMENT-PRACTICES.md updates"
        echo "3. Create a PR with title: 'contrib: Add articles from [project-name]'"
        echo ""
        echo "Template repo: $TEMPLATE_REPO"
    fi
else
    echo ""
    echo "No new contributions detected."
    echo "Your project's DEVELOPMENT-PRACTICES.md is in sync with or behind the template."
fi

echo ""
echo "==============================================="
echo "UPSTREAM CHECK COMPLETE"
echo "==============================================="
