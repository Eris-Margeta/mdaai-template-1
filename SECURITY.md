# Security Policy

## Supported Versions

Each project created from this template must define its supported versions before public release.

| Version | Supported |
|---------|-----------|
| Current stable release | Yes |
| Development snapshots | No, unless explicitly stated |
| End-of-life releases | No |

## Reporting a Vulnerability

Do not report security vulnerabilities through public issue trackers.

Use one of these private channels:

1. GitHub private vulnerability reporting, when enabled for the repository.
2. The maintainer contact listed in `project-meta.yaml` under `operator.email`.
3. The organization security contact, if the project defines one in its public documentation.

Include the following information when possible:

- Clear description of the vulnerability and potential impact.
- Affected version, commit, branch, or deployment environment.
- Steps to reproduce.
- Relevant logs, screenshots, requests, payloads, or proof-of-concept code.
- Whether the issue is actively exploitable or already publicly known.
- Preferred name or alias for acknowledgment, if credit is desired.

## Response Process

Maintainers should:

1. Acknowledge the report within two business days.
2. Triage severity and affected versions.
3. Create private remediation work as needed.
4. Release a fix or mitigation before public disclosure when feasible.
5. Credit the reporter unless anonymity is requested.

## Safe Harbor

Good-faith security research is welcome when it:

- Avoids privacy violations, data destruction, and service disruption.
- Uses only the access necessary to demonstrate the issue.
- Keeps vulnerability details private until maintainers have had reasonable time to respond.
- Complies with applicable law.

Maintainers should not pursue legal action against good-faith researchers who follow this policy.

## AI Assistant Requirements

AI assistants working in this repository must:

- Consider security implications for proposed changes.
- Avoid exposing secrets, credentials, private keys, tokens, or private customer data.
- Never manually edit dependency lockfiles or version manifests unless the package manager or project protocol explicitly requires it.
- Use official package manager commands for dependency changes.
- Create a Corrective Work Order if a security-relevant error is introduced or discovered during implementation.
