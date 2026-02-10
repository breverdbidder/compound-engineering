# CLAUDE.md — [REPO_NAME]

> **Last compounded:** 2026-02-09 | **Sessions since last compound:** 0

## Repository Overview

- **Repo:** `breverdbidder/[REPO_NAME]`
- **Stack:** <!-- Python/FastAPI | TypeScript/React | Bash/Scripts -->
- **Deploys to:** <!-- Render | Vercel | Cloudflare Pages | GitHub Actions -->
- **Primary DB:** Supabase (`mocerqjnksmhcjzxrewo.supabase.co`)

## Architecture Rules

### Non-Negotiables
- Zero user actions — if blocked, try 3 alternatives before escalating
- All state persists to Supabase or GitHub — never local-only
- Secrets in GitHub Secrets only — never hardcoded, never in commits
- Commit frequently with descriptive messages
- Run tests before pushing

### Stack Conventions
<!-- Customize for this repo's stack -->
- Type hints / strict types on all functions
- Async for all I/O operations
- Circuit breakers on all external API calls
- Error handling: explicit try/catch, never silent failures

## Development Workflow

### Session Protocol
```
/boot → /plan → code → /review → /compound
```

Every session starts with `/boot` and ends with `/compound`. No exceptions.

### Before Starting Any Task
1. Pull latest from `main`
2. Load `TODO.md` — find current unchecked task
3. Check CLAUDE.md `## Compounded Learnings` for relevant past lessons
4. Execute task → test → commit → push → **COMPOUND**

## File Map

| Path | Purpose |
|------|---------|
| `src/` | Application source code |
| `tests/` | Test suite |
| `docs/` | Documentation |
| `.github/workflows/` | CI/CD automation |
| `.claude/commands/` | Claude Code slash commands |
| `TODO.md` | Current sprint tasks |
| `CLAUDE.md` | This file — READ FIRST every session |

## Common Pitfalls (Compounded)

> Add known gotchas here. These prevent repeated mistakes.

- **Supabase RLS:** Service role key bypasses RLS. Anon key does not. Know which you need.
- **GitHub Actions secrets:** `${{ secrets.KEY }}` syntax — not `$KEY` or `process.env.KEY`

---

## Compounded Learnings

> Append new entries at the TOP. Format: date, title, 3 bullets. This is the compound engine.

<!-- First real entry will appear here after running /compound -->

---

## Escalation

If blocked after 3 attempts:
1. Log to Supabase `insights` table with `type: 'blocker'`
2. Surface: `BLOCKED: [issue]. Tried: [attempts]. Recommend: [solution].`
3. Continue with other tasks — never wait idle
