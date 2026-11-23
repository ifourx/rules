# Copilot Instructions — ifourx/rules

## Repository Type

This is a data-only repository that publishes domain routing rule lists for proxy tools. There is no application runtime.

Primary data files:

- `Direct.list`: domains that should route `DIRECT`
- `Proxy.list`: domains that should route `PROXY`

## Build, Test, and Lint Commands

No build, test, or lint pipeline exists in this repository.

Use these data-validation commands after edits:

```bash
# 1) Detect domains that exist in both files (must return no output)
comm -12 \
  <(grep '^DOMAIN-SUFFIX,' Direct.list | cut -d, -f2 | sort -u) \
  <(grep '^DOMAIN-SUFFIX,' Proxy.list | cut -d, -f2 | sort -u)

# 2) Detect invalid rule lines (must return no output)
grep -nEv '^(#|$|DOMAIN-SUFFIX,[A-Za-z0-9.-]+)$' Direct.list Proxy.list
```

Single-test command: not applicable (no test framework in this repo).

## High-Level Architecture

The repository works as a rule-data distribution pipeline:

1. Rule entries are maintained in `Direct.list` / `Proxy.list` as `DOMAIN-SUFFIX` lines.
2. Users and clients fetch these files (typically from `raw.githubusercontent.com`) via proxy tool rule-provider configs.
3. Proxy clients evaluate rules in order and choose outbound policy (`DIRECT` or `PROXY`).

Decision logic for where a domain belongs is documented and split across docs:

- `docs/METHODOLOGY.md`: reachability/performance workflow (`dig`, direct/proxy `curl`, dependency checks)
- `docs/ARCHITECTURE.md`: format/matching strategy and list maintenance choices
- `docs/INTEGRATION.md`: tool-specific loading and ordering behavior (Clash/Surge/Quantumult X/Loon/Stash/Shadowrocket)
- `CHANGELOG.md`: user-facing release notes (Keep a Changelog + SemVer style)

## Key Conventions

- Always use `DOMAIN-SUFFIX,domain.name` unless there is an explicit reason to use a different matcher.
- Keep domain entries alphabetically sorted within their logical comment group.
- Use `#` headers and blank lines for grouping; preserve existing grouping style.
- A domain must exist in exactly one list (no overlap between `Direct.list` and `Proxy.list`).
- Use root domains only (no scheme, path, query, fragment, or port).
- For domain moves, remove from source list and insert into destination list in sorted position.
- Evaluate placement using the methodology criteria:
  - `Proxy.list`: inaccessible/degraded direct path, better proxy performance, or proxied-service dependency
  - `Direct.list`: reachable with acceptable direct performance and no proxied dependency
- Keep integration rule order semantics in mind when editing docs/examples: direct rules before proxy rules, catch-all last.
- Follow conventional commit style for rule changes and update `CHANGELOG.md` for notable user-facing updates.
