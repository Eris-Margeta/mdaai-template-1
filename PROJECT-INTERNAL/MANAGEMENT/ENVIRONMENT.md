# ENVIRONMENT.md

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**

---

## Purpose

This document grounds AI agents to the actual system environment. AI agents MUST be aware of these details when performing operations, writing documentation, and creating Work Orders.

**Authority Level:** REFERENCE - required reading before system operations
**Sync Status:** NEVER SYNCS - project and environment specific

---

## Current Date

**Today's Date:** DD.MM.YYYY

> **AI Agent Instruction:** When creating Work Orders, Checkpoints, or any dated documents, use the CURRENT DATE in DD.MM.YYYY format. Do not use placeholder dates.

---

## Development Environment

| Property | Value |
|----------|-------|
| **Machine** | [Machine name/identifier] |
| **Operating System** | macOS |
| **OS Version** | [Version number] |
| **Architecture** | Apple Silicon (M1/M2/M3/M4) |
| **Shell** | zsh |
| **User** | [Username] |

### Development Tools

| Tool | Version | Notes |
|------|---------|-------|
| Go | 1.25.4 | |
| Rust | 1.92.0 | |
| Python | 3.13 | |
| Node.js | 24.12.0 | |
| pnpm | 10+ | Package manager |
| Docker | [version] | Container runtime |
| Git | [version] | |

### Local Paths

| Purpose | Path |
|---------|------|
| Project Root | /path/to/project |
| Go Modules | ~/go/pkg/mod |
| Cargo | ~/.cargo |
| Node Modules | ./node_modules |

---

## Deployment Environment

| Property | Value |
|----------|-------|
| **Machine** | VPS |
| **Provider** | [Provider name] |
| **Operating System** | Debian 13 (Trixie) |
| **Architecture** | x86_64 / amd64 |
| **Shell** | bash |

### Deployment Specifications

| Resource | Specification |
|----------|---------------|
| CPU | [cores] |
| RAM | [GB] |
| Storage | [GB] |
| Network | [bandwidth] |

---

## Access Commands

### SSH Access

```bash
# Development machine (if remote)
ssh user@dev-hostname

# Deployment server
ssh user@production-hostname
```

### Common Operations

```bash
# Check deployment status
ssh user@hostname "systemctl status service-name"

# View logs
ssh user@hostname "journalctl -u service-name -f"

# Deploy (example)
ssh user@hostname "cd /path/to/app && git pull && ./deploy.sh"
```

---

## Environment Variables

### Required for Development

```bash
# Example - customize for your project
export DATABASE_URL="postgres://user:pass@localhost:5432/dbname"
export REDIS_URL="redis://localhost:6379"
export API_KEY="development-key"
export LOG_LEVEL="debug"
```

### Required for Production

```bash
# These are loaded from secure secrets management
# DATABASE_URL - from secrets
# API_KEY - from secrets
# etc.
```

---

## Network Configuration

### Development

| Service | Host | Port |
|---------|------|------|
| Application | localhost | 8080 |
| Database | localhost | 5432 |
| Redis | localhost | 6379 |
| Frontend | localhost | 3000 |

### Production

| Service | Host | Port |
|---------|------|------|
| Application | [domain] | 443 |
| Database | [internal] | 5432 |
| Redis | [internal] | 6379 |

---

## AI Agent Instructions

### Before System Operations

1. **Read this document** to understand the environment
2. **Verify paths** exist before file operations
3. **Check tool versions** match expected versions
4. **Never assume** - verify environment state

### Date Handling

- **Always use DD.MM.YYYY format** for all dates
- **Get current date** from system when creating documents
- **Never use placeholder dates** like YYYY-MM-DD in final documents

### Environment Awareness

- **Development:** Safe for experimentation, local only
- **Production:** NEVER access directly without explicit instruction
- **Credentials:** NEVER log, commit, or expose

---

## Last Updated

**Date:** DD.MM.YYYY
**By:** [Operator Name]
