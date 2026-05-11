# Copilot instructions for this repository

Purpose

- This repo is a data-only repository containing newline-separated domain lists (Direct.list, Proxy.list). There is no application code, build system, or test suite.

Build / test / lint commands

- No build/test/lint commands detected.
- Useful lightweight checks (run locally or in CI):
  - Verify files exist and are non-empty: [ -s Direct.list ] && [ -s Proxy.list ]
  - Line counts and sample: wc -l Direct.list Proxy.list && head -n 10 Direct.list
  - Minimal CI validation (shell): |
    for f in Direct.list Proxy.list; do
    if [ ! -s "$f" ]; then
    echo "ERROR: $f is missing or empty"; exit 1; fi
        echo "$f has $(wc -l < "$f") lines"
    done

High-level architecture

- Single-purpose data repo: two primary artifacts (Direct.list, Proxy.list).
- Consumers are external systems that fetch these lists; this repo tracks authoritative content only.
- No build pipeline or runtime in this repository; treat it as content only.

Key conventions

- Files are plain UTF-8 text, one domain per line.
- Keep filenames and line formatting stable. Avoid rewriting the entire file when making small updates—use targeted edits.
- Commits should be small and descriptive (e.g., "Add domain X to Proxy.list").
- When adding or removing many entries, prefer a brief commit message describing the source or reason.

AI / Copilot guidance

- Do not propose adding language-specific tooling, tests, or dependencies unless requested.
- For PRs: prefer patches that modify only the list files and include a one-line explanation in the PR description.
- Suggested validation to include in CI: the minimal shell check above (existence and non-empty).

Other assistant configs

- No CLAUDE.md, .cursorrules, AGENTS.md, or other AI assistant config files were found.

Summary

- This file documents repository intent (data-only), quick validation commands, and conventions for future Copilot sessions.
