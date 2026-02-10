# Compound Engineering Methodology

## Core Principle

**Each unit of engineering work should make the next unit easier.**

Traditional AI coding is stateless — every session starts from zero. Compound Engineering adds a persistent memory layer via `CLAUDE.md` that grows with every session.

## The Four Phases

### 1. Boot (Context Load)
Read everything the system has learned before touching code. This prevents:
- Repeating known mistakes
- Violating established patterns
- Wasting time rediscovering solutions

### 2. Plan (Research Before Code)
Investigate the codebase and check compounded learnings before writing code. This prevents:
- Architectural drift
- Conflicting patterns
- Missing existing utilities

### 3. Review (Multi-Agent QA)
Four specialized review passes before committing:
- **Security:** Secrets, injection, auth gaps
- **Performance:** N+1 queries, missing async, unbounded operations
- **Architecture:** Pattern consistency, conventions, code quality
- **Tests:** Coverage, assertions, reliability

### 4. Compound (Knowledge Capture)
Extract what was learned and persist it. Three data points per session:
- **What worked** — reinforce good patterns
- **What broke** — prevent repeated mistakes
- **Rule for next time** — actionable directive

## Why CLAUDE.md (Not a Database)

1. **Zero dependencies.** No plugin to install, no service to configure.
2. **Version controlled.** Every learning is in git history.
3. **Human readable.** Any team member can read and contribute.
4. **Claude Code native.** Automatically loaded at session start.
5. **Portable.** Works across repos, across machines, across team members.

## Compound Growth Math

If each session captures 3 learnings:
- Week 1 (5 sessions): 15 learnings
- Month 1 (20 sessions): 60 learnings
- Quarter 1 (60 sessions): 180 learnings

At 180 learnings, your AI has a comprehensive knowledge base of your codebase's patterns, pitfalls, and preferences. New features that took 2 hours in Month 1 take 45 minutes in Month 3.

## Anti-Patterns to Avoid

- **Compound inflation:** "Everything worked great!" — don't compound when there's nothing to learn
- **Generic learnings:** "Python is good" — only session-specific discoveries
- **Skipping /boot:** Starting without reading CLAUDE.md defeats the entire purpose
- **Never compounding:** Installing but never running /compound — all setup, no flywheel
