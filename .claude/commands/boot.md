# /boot — Start a New Claude Code Session

You are starting a fresh Claude Code session. Follow this startup protocol to load context and avoid cold-start mistakes.

## Instructions

1. **Read CLAUDE.md** — Full file. This is your primary context. Pay attention to:
   - Architecture rules and conventions
   - Common pitfalls (these are mistakes already made — don't repeat them)
   - Compounded learnings (newest first — most relevant)
   - File map (know where things are)

2. **Read TODO.md** — Find the first unchecked `[ ]` task. This is your current objective.

3. **Read PROJECT_STATE.json** (if exists) — Check:
   - `recent_decisions` — understand recent architectural choices
   - `blockers` — know what's stuck and why
   - `current_sprint` — understand the broader context

4. **Check git status** — Run `git status` and `git log --oneline -5` to understand:
   - Any uncommitted changes from a previous session
   - Recent commit history for context

5. **Output session briefing:**

```
🚀 SESSION BOOT — {{repo name}}

📋 Current task: {{from TODO.md}}
📚 Relevant learnings: {{count}} entries in CLAUDE.md
⚠️ Active pitfalls: {{list any relevant ones}}
🔄 Git status: {{clean | uncommitted changes | ahead/behind}}
🕐 FL: {{time}} EST

Ready to execute. Starting with: {{first action}}
```

6. **Begin work immediately** — don't wait for permission.

## Rules
- NEVER skip reading CLAUDE.md. It exists to prevent repeated mistakes.
- If CLAUDE.md doesn't exist, warn the user and offer to run install.
- If TODO.md has no unchecked tasks, ask the user what to work on.
- Session boot should take <30 seconds. Don't over-analyze — start working.
