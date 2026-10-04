# PROJECT-RULES.md

**FACTORY OF ELECTRONIC UNITS AND LOGIC – TEJL d.o.o.**

---

## Purpose

This document contains **project-specific hard rules** that ALL AI agents must follow without exception. These rules are IMMUTABLE and supplement the global governance in `GOVERNANCE/AI-INSTRUCTIONS.md`.

**Authority Level:** BINDING - equivalent to GOVERNANCE documents
**Sync Status:** NEVER SYNCS - project-specific, not from template

---

## Article 1: Scope

(1) These rules apply to THIS PROJECT ONLY.

(2) These rules are ADDITIONS to global governance, not replacements.

(3) In case of conflict between PROJECT-RULES.md and AI-INSTRUCTIONS.md, AI-INSTRUCTIONS.md takes precedence UNLESS the project rule is more restrictive.

(4) More restrictive project rules ALWAYS win.

---

## Article 2: Project-Specific Coding Rules

(1) **[Add project-specific coding rules here]**

Example entries (customize for your project):
```
- All API responses must include request_id for tracing
- Database queries must use prepared statements only
- No raw SQL strings allowed
- All external API calls must have timeout of 30 seconds max
- Error messages must never expose internal paths or stack traces
```

---

## Article 3: Project-Specific Testing Rules

(1) **[Add project-specific testing rules here]**

Example entries (customize for your project):
```
- All public functions must have unit tests
- Integration tests must use test database, never production
- Test coverage must be >= 80% for new code
- All tests must pass before any checkpoint
- Mock external services, never call real APIs in tests
```

---

## Article 4: Project-Specific Security Rules

(1) **[Add project-specific security rules here]**

Example entries (customize for your project):
```
- All user input must be sanitized
- Passwords must be hashed with bcrypt, cost >= 12
- API keys must never be logged
- Sessions expire after 24 hours
- Rate limiting required on all public endpoints
```

---

## Article 5: Project-Specific Architecture Rules

(1) **[Add project-specific architecture rules here]**

Example entries (customize for your project):
```
- All services must be stateless
- Configuration via environment variables only
- No hardcoded URLs or paths
- All inter-service communication via defined interfaces
- Database migrations must be reversible
```

---

## Article 6: Project-Specific Deployment Rules

(1) **[Add project-specific deployment rules here]**

Example entries (customize for your project):
```
- All deployments require passing CI pipeline
- Blue-green deployment strategy required
- Rollback plan must exist before deployment
- Health checks required on all services
- Logs must be structured JSON
```

---

## Article 7: Custom Project Rules

(1) **[Add any other project-specific rules here]**

---

## Modification History

| Date | Article | Change | Authorized By |
|------|---------|--------|---------------|
| DD.MM.YYYY | Initial | Document created | [Operator Name] |

---

## Related Documents

- [AI-INSTRUCTIONS.md](../GOVERNANCE/AI-INSTRUCTIONS.md) - Global governance
- [ENVIRONMENT.md](./ENVIRONMENT.md) - System environment details
- [project-meta.yaml](../../project-meta.yaml) - Project identity
