# CLAUDE.md — Compound Engineering System

> **Last compounded:** 2026-02-09 | **Sessions since last compound:** 0

## Repository Overview

- **Repo:** `breverdbidder/compound-engineering`
- **Purpose:** Reusable compound engineering system for all Shapira repos
- **Stack:** Bash scripts + Claude Code slash commands + GitHub Actions
- **Installs into:** Any repo via `./scripts/install.sh`

## How This Repo Works

This is the **source of truth** for compound engineering across all repos:
- `templates/` — CLAUDE.md templates (generic + repo-specific)
- `scripts/` — `compound.sh` (append learnings), `install.sh` (bootstrap any repo)
- `.claude/commands/` — Slash commands Claude Code loads automatically
- `.github/workflows/` — Reusable compound automation

## Development Rules

- Every change must be backward-compatible with installed repos
- Templates use `{{PLACEHOLDERS}}` — install.sh replaces them
- Slash commands must work without any dependencies beyond Claude Code
- Test install.sh against a fresh repo before pushing changes

## Compounded Learnings

> Append new entries at the TOP.

