# CLAUDE.md — ZoneWise Desktop

> **Last compounded:** 2026-02-09 | **Sessions since last compound:** 0

## Repository Overview

- **Repo:** `breverdbidder/zonewise-desktop`
- **Stack:** TypeScript / Electron or Tauri / React / CraftAgents
- **Purpose:** Desktop app for non-developers — CraftAgents skill execution, file/task automation
- **Deploys to:** GitHub Releases (desktop builds)
- **DB:** Supabase (`mocerqjnksmhcjzxrewo.supabase.co`)
- **Greptile indexed:** Yes (repo: zonewise-desktop)

## Architecture Rules

### Non-Negotiables
- Zero user actions during dev — if blocked, try 3 alternatives before escalating
- TypeScript strict mode everywhere
- React functional components with hooks only — no class components
- Tailwind for all styling — no CSS modules, no styled-components
- All interactive guides: HTML with clickable links, copy-blocks, checkboxes (never markdown)

### UI Principles
- Split-screen layout: chat left, artifacts/reports right (like Claude AI / Manus AI)
- NLP chatbot interface for user interactions
- React (.jsx) for summaries and visualizations
- DOCX outputs: LevelFormat.BULLET, dual widths, ShadingType.CLEAR, LANDSCAPE orientation

### CraftAgents / Skills
- Skills live in `skills/` directory
- Each skill: self-contained, independently executable
- Skill manifest: `skill.json` with name, description, inputs, outputs
- Skills can call Supabase, GitHub API, external services

## Development Workflow

### Before Starting Any Task
1. `git pull origin main`
2. Load `TODO.md` — find current unchecked task
3. Execute → test → commit → push → **COMPOUND**

### Running Locally
```bash
bun install
bun run dev
```

### Testing
```bash
bun test
```

## File Map

| Path | Purpose |
|------|---------|
| `src/` | Application source — React components, main process |
| `skills/` | CraftAgents skill definitions |
| `src/components/` | React UI components |
| `src/services/` | API clients, Supabase, LLM routing |
| `tests/` | Test suite |
| `TODO.md` | Sprint tasks |
| `PROJECT_STATE.json` | Session state |

## Common Pitfalls (Compounded)

- **Electron vs Tauri:** Check which runtime is active before assuming Node.js APIs are available.
- **Tailwind in Electron:** Ensure Tailwind CSS is properly bundled — JIT doesn't work without PostCSS config.
- **Mapbox token:** `pk.eyJ1...` (account: everest18). Set as env var, never inline in components.
- **Greptile:** Use verified key `ukH9Hf1y...` for code search QA. Old key `BWwjcZ6e...` is EXPIRED.

---

## Compounded Learnings

> Append new entries at the TOP.

---

## Escalation

If blocked after 3 attempts → log to Supabase `insights` → surface to Ariel → continue other tasks.
