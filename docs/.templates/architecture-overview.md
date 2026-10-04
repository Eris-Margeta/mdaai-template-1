# Architecture Overview

<!--
TEMPLATE: Architecture Documentation
Use this template for documenting system architecture.
Delete this comment block when using.
-->

This document describes the high-level architecture of [Project Name].

---

## System Overview

[Brief description of what the system does and its main components]

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        Client Layer                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐                  │
│  │   Web    │  │  Mobile  │  │   CLI    │                  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘                  │
└───────┼─────────────┼─────────────┼─────────────────────────┘
        │             │             │
        └─────────────┼─────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                        API Layer                             │
│  ┌──────────────────────────────────────────────────┐      │
│  │              REST / GraphQL API                   │      │
│  └──────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                     Service Layer                            │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐                  │
│  │ Service  │  │ Service  │  │ Service  │                  │
│  │    A     │  │    B     │  │    C     │                  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘                  │
└───────┼─────────────┼─────────────┼─────────────────────────┘
        │             │             │
        └─────────────┼─────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                      Data Layer                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐                  │
│  │ Database │  │  Cache   │  │  Queue   │                  │
│  └──────────┘  └──────────┘  └──────────┘                  │
└─────────────────────────────────────────────────────────────┘
```

---

## Components

### Component A: [Name]

**Purpose:** What this component does

**Responsibilities:**
- Responsibility 1
- Responsibility 2
- Responsibility 3

**Key Technologies:**
- Technology 1
- Technology 2

**Location:** `/src/component-a/`

### Component B: [Name]

**Purpose:** What this component does

**Responsibilities:**
- Responsibility 1
- Responsibility 2

**Key Technologies:**
- Technology 1

**Location:** `/src/component-b/`

---

## Data Flow

### Request Flow

1. Client sends request to API Gateway
2. API Gateway authenticates and routes request
3. Service processes request
4. Data layer is queried/updated
5. Response flows back through layers

### Example: [Specific Flow]

```
User Request
    │
    ▼
┌───────────┐
│   Auth    │ ──▶ Validate token
└─────┬─────┘
      │
      ▼
┌───────────┐
│  Router   │ ──▶ Route to handler
└─────┬─────┘
      │
      ▼
┌───────────┐
│  Service  │ ──▶ Business logic
└─────┬─────┘
      │
      ▼
┌───────────┐
│    DB     │ ──▶ Persist data
└───────────┘
```

---

## Key Design Decisions

| Decision | Rationale | ADR |
|----------|-----------|-----|
| [Decision 1] | [Brief rationale] | [ADR-001](../PROJECT-INTERNAL/ARCHITECTURE/ADR-001.md) |
| [Decision 2] | [Brief rationale] | [ADR-002](../PROJECT-INTERNAL/ARCHITECTURE/ADR-002.md) |

---

## Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| Frontend | [Tech] | [Purpose] |
| API | [Tech] | [Purpose] |
| Backend | [Tech] | [Purpose] |
| Database | [Tech] | [Purpose] |
| Cache | [Tech] | [Purpose] |
| Queue | [Tech] | [Purpose] |

---

## Security

### Authentication

[How authentication works]

### Authorization

[How authorization works]

### Data Protection

[How data is protected]

---

## Scalability

### Horizontal Scaling

[How the system scales horizontally]

### Performance Considerations

[Key performance optimizations]

---

## Deployment

### Infrastructure

```
┌─────────────────────────────────────────┐
│              Load Balancer               │
└─────────────────┬───────────────────────┘
                  │
    ┌─────────────┼─────────────┐
    │             │             │
    ▼             ▼             ▼
┌───────┐   ┌───────┐   ┌───────┐
│ App 1 │   │ App 2 │   │ App N │
└───────┘   └───────┘   └───────┘
```

### Environments

| Environment | Purpose | URL |
|-------------|---------|-----|
| Development | Local development | localhost |
| Staging | Pre-production testing | staging.example.com |
| Production | Live system | example.com |

---

## Related Documentation

- [API Reference](../api/index.md)
- [User Guide](../guide/index.md)
- [ADRs](../PROJECT-INTERNAL/ARCHITECTURE/)
