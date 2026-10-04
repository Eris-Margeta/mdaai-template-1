# [Monorepo Project Name]

<!--
TEMPLATE: README.md for Monorepos
Use this template for monorepo root README files.
Delete this comment block when using.

IMPORTANT:
- Each package has its own VERSION file
- Root VERSION is for the overall release
- Tables reference package VERSION files
-->

<!-- BADGES: Root level badges -->
![Version](https://img.shields.io/badge/dynamic/regex?url=https://raw.githubusercontent.com/ORG/REPO/main/VERSION&regex=(.*)&label=version&color=blue)
![Build Status](https://img.shields.io/github/actions/workflow/status/ORG/REPO/ci.yml?branch=main&label=build)
![License](https://img.shields.io/badge/license-MIT-green)

> Brief description of the monorepo and its purpose.

---

## Packages

| Package | Version | Description | Status |
|---------|---------|-------------|--------|
| [@project/core](./packages/core) | `cat packages/core/VERSION` | Core library | ![Build](https://img.shields.io/github/actions/workflow/status/ORG/REPO/core.yml) |
| [@project/cli](./packages/cli) | `cat packages/cli/VERSION` | CLI tool | ![Build](https://img.shields.io/github/actions/workflow/status/ORG/REPO/cli.yml) |
| [@project/server](./packages/server) | `cat packages/server/VERSION` | Server component | ![Build](https://img.shields.io/github/actions/workflow/status/ORG/REPO/server.yml) |

> **Note:** Each package has its own VERSION file as the single source of truth.

---

## Quick Start

### Prerequisites

- [Runtime] (version X.Y+)
- [Package manager] (version X.Y+)

### Clone and Setup

```bash
# Clone the monorepo
git clone https://github.com/ORG/REPO.git
cd REPO

# Install all dependencies
[package manager workspace install]

# Build all packages
[build all command]
```

### Working with Specific Packages

```bash
# Build specific package
[build command] --package @project/core

# Run tests for specific package
[test command] --package @project/cli

# Run specific package
[run command] --package @project/server
```

---

## Repository Structure

```
.
├── VERSION                    # Root version (overall release)
├── packages/
│   ├── core/
│   │   ├── VERSION           # Core package version
│   │   ├── README.md         # Core documentation
│   │   └── src/
│   ├── cli/
│   │   ├── VERSION           # CLI package version
│   │   ├── README.md         # CLI documentation
│   │   └── src/
│   └── server/
│       ├── VERSION           # Server package version
│       ├── README.md         # Server documentation
│       └── src/
├── shared/                    # Shared code (if any)
├── docs/                      # Root documentation
├── tools/                     # Build and dev tools
└── PROJECT-INTERNAL/          # Governance (not for end users)
```

---

## Documentation

### Per-Package Documentation

| Package | README | API Docs |
|---------|--------|----------|
| @project/core | [README](./packages/core/README.md) | [API](./docs/api/core.md) |
| @project/cli | [README](./packages/cli/README.md) | [CLI Reference](./docs/cli.md) |
| @project/server | [README](./packages/server/README.md) | [API](./docs/api/server.md) |

### General Documentation

- [Architecture Overview](./docs/architecture/index.md)
- [Contributing Guide](./CONTRIBUTING.md)
- [Development Setup](./docs/guide/development.md)

---

## Version Management

### Single Source of Truth

Each package has a `VERSION` file that is the authoritative source:

```
packages/core/VERSION    → 1.2.3
packages/cli/VERSION     → 2.0.1
packages/server/VERSION  → 1.5.0
VERSION                  → 2024.01 (release version)
```

### How Versions Sync

1. **Package versions:** Managed independently in each `VERSION` file
2. **Dependency versions:** Workspace protocols (e.g., `workspace:*`)
3. **README badges:** Auto-generated from VERSION files via CI
4. **Releases:** Tagged with root VERSION, includes all package versions

### Updating Versions

```bash
# Update specific package version
echo "1.3.0" > packages/core/VERSION

# The CI will:
# - Update package manifest (Cargo.toml, package.json, etc.)
# - Update README badges
# - Update CHANGELOG
```

---

## Development

### Build All

```bash
[build all command]
```

### Test All

```bash
[test all command]
```

### Build Specific Package

```bash
[build command] -p @project/core
```

### Adding a New Package

1. Create `packages/newpkg/` directory
2. Add `VERSION` file with initial version
3. Add `README.md` using package template
4. Add to workspace configuration
5. Update this README's package table

---

## Release Process

1. Update VERSION files for changed packages
2. Update CHANGELOG.md
3. CI validates version consistency
4. Create release tag
5. CI publishes packages with updated versions

---

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

When contributing to monorepos:
- Changes should be scoped to specific packages when possible
- Cross-package changes require more careful review
- Each package has its own test suite

---

## License

MIT License - see [LICENSE](./LICENSE)

---

<p align="center">
  <strong>FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.</strong>
</p>
