# Compound Engineering

**Make each Claude Code session smarter than the last.**

A zero-dependency system that captures learnings from every AI coding session and compounds them into persistent knowledge. Built for Claude Code.

## The Problem

Every Claude Code session starts from scratch. You hit the same bugs, rediscover the same patterns, and repeat the same mistakes. Context windows reset. Knowledge is lost.

## The Solution

Four slash commands that create a compound learning loop:

```
/boot → /plan → code → /review → /compound
         ↑                           |
         └───── CLAUDE.md ←──────────┘
```

Each `/compound` step writes learnings back to `CLAUDE.md`. Each `/boot` reads them. Knowledge compounds across sessions, across days, across team members.

## Quick Install

```bash
# From any git repo:
curl -sSL https://raw.githubusercontent.com/breverdbidder/compound-engineering/main/scripts/install.sh | bash
```

This adds:
- `.claude/commands/` — Four slash commands for Claude Code
- `CLAUDE.md` — Context file with compounded learnings section
- `TODO.md` — Task tracking
- `compound.sh` — Manual compound script (backup)

## Slash Commands

| Command | When | What it does |
|---------|------|-------------|
| `/boot` | Session start | Loads CLAUDE.md, TODO.md, git status. Outputs session briefing. |
| `/plan` | Before coding | Researches codebase, checks past learnings, creates implementation plan. |
| `/review` | Before committing | 4-agent code review: Security, Performance, Architecture, Tests. |
| `/compound` | Session end | Extracts learnings, appends to CLAUDE.md, commits. **MANDATORY.** |

## How It Works

### Session Flow

```
$ claude

> /boot
🚀 SESSION BOOT — zonewise-agents
📋 Current task: Add retry logic to BCPAO scraper
📚 Relevant learnings: 12 entries in CLAUDE.md
⚠️ Active pitfall: "BCPAO API times out after 10s — use 30s timeout"
🔄 Git status: clean, up to date
Ready to execute.

> /plan Add retry logic to BCPAO scraper
📋 PLAN: BCPAO Scraper Retry Logic
Context from CLAUDE.md:
- Per compound entry 2026-02-05: "BCPAO returns 503 during peak hours 9-11AM EST"
Steps:
1. Add tenacity retry decorator to bcpao_scraper.py
2. Configure: 3 retries, exponential backoff, 30s max timeout
3. Add circuit breaker for consecutive 503s
4. Write test with mocked 503 responses

> [code implementation]

> /review
🔍 CODE REVIEW — 2 files
🔒 Security: ✅ PASS
⚡ Performance: ✅ PASS
🏗️ Architecture: ✅ PASS
🧪 Tests: ✅ PASS
VERDICT: SHIP IT 🚀

> /compound
📚 Compounding learnings...
#### 2026-02-09: BCPAO Retry Pattern
- **What worked:** tenacity with exponential backoff + circuit breaker combo
- **What broke:** Initial retry without backoff caused rate limiting
- **Rule for next time:** Always use exponential backoff on government APIs

✅ Compounded → CLAUDE.md
```

### The Compound Effect

Session 1: CLAUDE.md has 0 learnings. You hit every gotcha fresh.
Session 10: CLAUDE.md has 30 learnings. `/boot` warns you about pitfalls before you hit them.
Session 50: CLAUDE.md is a comprehensive knowledge base. New tasks take half the time.

## Repo Structure

```
compound-engineering/
├── CLAUDE.md                          # Meta: this repo's own context
├── README.md                          # This file
├── .claude/commands/
│   ├── boot.md                        # /boot — session startup
│   ├── plan.md                        # /plan — research + plan
│   ├── review.md                      # /review — multi-agent review
│   └── compound.md                    # /compound — capture learnings
├── scripts/
│   ├── install.sh                     # Bootstrap into any repo
│   └── compound.sh                    # CLI compound (backup method)
├── templates/
│   ├── CLAUDE-generic.md              # Generic template
│   ├── CLAUDE-zonewise-agents.md      # FastAPI/LangGraph template
│   └── CLAUDE-zonewise-desktop.md     # Electron/React template
├── .github/workflows/
│   ├── compound-check.yml             # PR check: compound hygiene
│   └── sync-commands.yml              # Auto-sync commands to all repos
└── docs/
    └── methodology.md                 # Deep dive on the compound pattern
```

## GitHub Actions

### Compound Check (Reusable)
Add to any repo's CI to enforce compound hygiene:

```yaml
# .github/workflows/ci.yml
jobs:
  compound-check:
    uses: breverdbidder/compound-engineering/.github/workflows/compound-check.yml@main
```

### Auto-Sync
When slash commands are updated in this repo, they automatically sync to all repos in the matrix. Add new repos to `.github/workflows/sync-commands.yml`.

## Manual Compound (Fallback)

If you can't use slash commands, use the shell script:

```bash
./compound.sh \
  "BCPAO Retry Pattern" \
  "tenacity with exponential backoff works" \
  "retry without backoff caused rate limiting" \
  "Always use exponential backoff on gov APIs"
```

## FAQ

**Q: Do I need to install a plugin?**
No. Slash commands are plain markdown files in `.claude/commands/`. Claude Code reads them natively.

**Q: What if I forget to run /compound?**
The compound-check GitHub Action will warn you if it's been >7 days since last compound.

**Q: Can multiple people compound into the same CLAUDE.md?**
Yes. Each entry is dated. Git handles merge conflicts on append-only sections cleanly.

**Q: How is this different from the EveryInc plugin?**
The EveryInc plugin is a TypeScript CLI with npm dependencies. This is zero-dependency markdown files. Same methodology, simpler implementation. Works with any stack.

---

Built for the Shapira stack. Inspired by [Compound Engineering](https://every.to/guides/compound-engineering) from Every.to.
