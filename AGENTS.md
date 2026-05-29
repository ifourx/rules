# AGENTS.md

## Project Overview

A domain-based network traffic routing rule list for proxy tools (Clash, Surge, Quantumult, etc.). Maintains two rule files — `Direct.list` for direct-connection domains and `Proxy.list` for proxy-routed domains.

> **Note:** This is a data-only repository. There is no code to build, test, or run.

## Repository Structure

```
├── Direct.list        # Domains that should connect directly
├── Proxy.list         # Domains that should route through proxy
├── README.md          # Project documentation
├── docs/
│   ├── ARCHITECTURE.md   # Design decisions & data flow
│   ├── INTEGRATION.md    # Proxy tool configuration guides
│   └── METHODOLOGY.md    # Domain categorization research process
└── .github/
    ├── copilot-instructions.md
    ├── ISSUE_TEMPLATE/
    │   ├── bug_report.yml
    │   └── feature_request.yml
    ├── PULL_REQUEST_TEMPLATE.md
    └── workflows/          # CI/CD workflows (if any)
```

## Tech Stack

- **Format:** Plain text, one rule per line
- **Rule syntax:** `DOMAIN-SUFFIX,domain.name`
- **Comments:** Lines starting with `#`
- **Encoding:** UTF-8

## Conventions

- Each rule file uses `DOMAIN-SUFFIX` matching (subdomain + root domain)
- Blank lines are allowed for grouping
- Keep domains alphabetically sorted within each file
- One domain per rule line

## Documentation

The `README.md` at the repository root serves as the primary documentation. No additional documentation framework is needed for this project type.

## Common Pitfalls

- Do not use `DOMAIN` (exact match) unless specifically required — `DOMAIN-SUFFIX` is the standard
- Do not add trailing slashes or paths — only root domains
- Ensure new domains don't overlap between `Direct.list` and `Proxy.list`
- Verify a domain actually needs proxying before adding to `Proxy.list`
