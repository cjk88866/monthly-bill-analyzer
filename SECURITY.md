# Security Policy

## Sensitive Data

This project is designed for local bill analysis. Real statements, screenshots,
generated reports, and API keys should never be committed.

Ignored local data paths:

```text
data/uploads
data/reports
.env
.env.local
```

## Reporting

If you find a security or privacy issue, please open a private report through
GitHub's security advisory feature if available. If not, open an issue with a
minimal description and avoid attaching real financial data.

## Scope

Security-sensitive areas include:

- File upload handling
- Generated reports
- AI provider configuration and API keys
- Docker/Nginx proxy behavior
- Any code path that sends bill content to an external model provider
