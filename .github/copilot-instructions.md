# Copilot Instructions — ifourx/rules

## Rule Format Conventions

This repository manages domain-based routing rules for proxy tools.

- **File format:** Plain text, one rule per line, UTF-8 encoded
- **Rule syntax:** `DOMAIN-SUFFIX,domain.name`
- **Comments:** Lines starting with `#` — use for grouping and notes
- **Grouping:** Separate logical groups of domains with a blank line and a comment header (e.g., `# Social Media`)

## Domain Rules

- Use `DOMAIN-SUFFIX` for all rules (matches the domain and all subdomains)
- Do NOT use `DOMAIN` (exact match) unless explicitly justified
- Do NOT add paths, protocols, or ports — only root domains
- Keep domains alphabetically sorted within each file and group
- One domain per line — never comma-separate multiple domains on one line

## Adding Domains

1. Determine whether the domain should be direct or proxied
2. Add to the correct file (`Direct.list` or `Proxy.list`)
3. Place in alphabetical order within the relevant group
4. Ensure no duplicate entries exist
5. Verify the domain doesn't already exist in the other list (no overlap)

## Maintenance Matrix

When making changes to this repository, the following files may need coordinated updates:

| Change                       | Files to update                                          |
| ---------------------------- | -------------------------------------------------------- |
| Add/remove a direct domain   | `Direct.list`, `Proxy.list` (check for conflict)         |
| Add/remove a proxy domain    | `Proxy.list`, `Direct.list` (check for conflict)         |
| Move domain between lists    | `Direct.list` (remove), `Proxy.list` (add) or vice versa |
| Update project documentation | `README.md`                                              |
| Record notable changes       | `CHANGELOG.md`                                           |
| Update AI agent context      | `AGENTS.md`, `.github/copilot-instructions.md`           |

## Test Conventions

No automated tests exist for this data-only repository. However:

- **Manual verification:** After adding/changing domains, verify the domain resolves correctly and confirm its routing behavior with your proxy tool
- **Duplicate check:** Before submitting, quickly scan both rule files to ensure no domain appears in both lists
- **Format check:** Ensure each line follows the `DOMAIN-SUFFIX,domain` format
