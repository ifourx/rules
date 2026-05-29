# Copilot Instructions — ifourx/rules

## Overview

This is a **data-only** repository — no code to build, test, or run. It maintains two plain-text rule files for proxy tools (Clash, Surge, Quantumult, etc.) to route network traffic: `Direct.list` (direct connection) and `Proxy.list` (proxy-routed).

## Rule Format Conventions

- **Syntax:** `DOMAIN-SUFFIX,domain.name` — one rule per line, UTF-8 encoded
- **Comments:** Lines starting with `#` — use for grouping and notes
- **Grouping:** Separate logical groups of domains with a blank line and a comment header (e.g., `# Social Media`)
- **Matching:** `DOMAIN-SUFFIX` matches the domain and all subdomains. Do NOT use `DOMAIN` (exact match) unless explicitly justified.
- **No paths, protocols, or ports** — only root domains
- **Alpha-sorted** within each file and group

## Adding or Moving Domains

1. Determine routing: run `dig <domain> +short`, then `curl -o /dev/null -s -w "%{http_code} %{time_total}" <url>` with and without proxy. See `docs/METHODOLOGY.md` for detailed research process.
2. Add to correct file (`Direct.list` or `Proxy.list`) in alphabetical order within the relevant group.
3. Check both files — a domain must never appear in both lists.
4. For moves: remove from one file, add to the other.
5. If notable, update `CHANGELOG.md` following Keep a Changelog format and SemVer.

## Repository Structure

```
Direct.list         # Domains that bypass the proxy
Proxy.list          # Domains that route through the proxy
CHANGELOG.md        # Semantic-versioned release log
AGENTS.md           # AI agent context
README.md           # End-user quick-start
docs/
├── ARCHITECTURE.md # Design decisions & data flow
├── INTEGRATION.md  # Proxy tool configuration guides
└── METHODOLOGY.md  # Domain research & categorization process
.github/
├── copilot-instructions.md  # This file
├── agents/                  # Custom Copilot agent definitions
├── hooks/                   # Session hooks (tool-guardian, session-logger, secrets-scanner)
├── ISSUE_TEMPLATE/          # Bug report & feature request forms
└── PULL_REQUEST_TEMPLATE.md # PR checklist
```

## Key Conventions

- **No overlap** — domain in `Direct.list` must not also appear in `Proxy.list` and vice versa
- **Prefers plain text** over YAML/JSON for zero-tool-dependency editing
- **Commit messages** use conventional commits (e.g., `feat: add some domains`)
- **Pull Requests** must include completed checklist from the PR template (format, alphabetical order, no duplicates, CHANGELOG if needed)
- **Issues** use the bug report template — specify affected domain, current vs. expected placement

## Domain Categorization Principles (from docs/METHODOLOGY.md)

| Principle     | Description                                             |
| ------------- | ------------------------------------------------------- |
| Accessibility | Proxy only if domain is inaccessible or degraded direct |
| Performance   | Proxy if faster through proxy; CDN-heavy stays direct   |
| Neutrality    | Categorization based purely on reachability, not bias   |

## Available Custom Agents

- **gem-documentation-writer**: Technical documentation, READMEs, API docs
- **markdown-scribe**: Markdown formatting, editing, and creation

## CI / Hooks

- **No CI workflows** exist currently
- **Tool Guardian** (`.github/hooks/tool-guardian/`): Pre-hook that blocks dangerous operations (destructive file ops, force pushes to main/master, DB drops). Set `GUARD_MODE=warn` to log without blocking.
- **Session Logger** (`.github/hooks/session-logger/`): Logs session start/end and prompts
- **Secrets Scanner** (`.github/hooks/secrets-scanner/`): Scans diffs for secrets on session end

## Design Decisions (from docs/ARCHITECTURE.md)

| Decision                      | Rationale                                                 |
| ----------------------------- | --------------------------------------------------------- |
| Plain text over YAML/JSON     | Any editor works; human-readable diffs                    |
| `DOMAIN-SUFFIX` over `DOMAIN` | One rule covers full domain tree — fewer rules            |
| Alphabetical ordering         | Prevents duplicates, simplifies review, predictable diffs |
| Comment-header grouping       | Organises domains by category for maintainability         |
