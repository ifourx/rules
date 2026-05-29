# Architecture

## Overview

This repository maintains two plain-text rule files (`Direct.list`, `Proxy.list`) that proxy tools consume at startup or via `rule-providers` polling. No build step, no runtime — pure data distribution.

## Data Flow

```
Rule Files (Direct.list / Proxy.list)
    │
    ├── HTTP fetch ──► Proxy Tool (Clash / Surge / Quantumult / ...)
    │                      │
    │                      ├── DOMAIN-SUFFIX matching
    │                      ├── Rule chain evaluation
    │                      └── Outbound interface selection (DIRECT / PROXY)
    │
    └── git push ──► GitHub
                         │
                         └── raw.githubusercontent.com
```

## Rule File Format

- **Syntax:** `DOMAIN-SUFFIX,<domain>`  
- **Encoding:** UTF-8  
- **Comments:** Lines starting with `#`  

`DOMAIN-SUFFIX` matches the specified domain **and all its subdomains** (e.g., `example.com` also matches `api.example.com`). This is the preferred match type for proxy tools — it covers the full namespace with a single rule.

See [INTEGRATION.md](./INTEGRATION.md) for tool-specific behaviour details.

## Repository Structure

```
./
├── Direct.list         # Domains that bypass the proxy (DIRECT)
├── Proxy.list          # Domains that route through the proxy (PROXY)
├── CHANGELOG.md        # Semantic-versioned release log
├── AGENTS.md           # AI agent context (setup, style, PR instructions)
├── README.md           # End-user quick-start
├── docs/
│   ├── ARCHITECTURE.md # This file — design & decisions
│   ├── INTEGRATION.md  # Tool-specific configuration
│   └── METHODOLOGY.md  # Domain research & categorization
└── .github/
    ├── copilot-instructions.md  # AI assistant rules
    ├── agents/                  # Custom Copilot agent definitions
    ├── hooks/                   # Git / session hooks
    ├── ISSUE_TEMPLATE/          # Bug report & feature request forms
    └── PULL_REQUEST_TEMPLATE.md # PR checklist
```

## Design Decisions

| Decision | Rationale |
|----------|-----------|
| Plain text over structured formats (YAML, JSON) | Zero tool dependency; any editor can edit; human-readable diffs |
| `DOMAIN-SUFFIX` over `DOMAIN` | One rule covers the full domain tree — fewer rules, less maintenance |
| No paths / protocols in rules | Proxy tools match at the domain level; path routing belongs in the client |
| Alphabetical ordering | Prevents duplicates, simplifies manual review, ensures predictable diffs |
| Grouped by comment headers | Organises domains by category (e.g., `# Social Media`) for maintainability |
