# CLAUDE.md — ZoneWise Agents

> **Last compounded:** 2026-02-09 | **Sessions since last compound:** 0

## Repository Overview

- **Repo:** `breverdbidder/zonewise-agents`
- **Stack:** Python 3.11+ / FastAPI / LangGraph / httpx
- **Deploys to:** Render.com (auto-deploy from `main`)
- **Primary DB:** Supabase (`mocerqjnksmhcjzxrewo.supabase.co`)
- **Tables:** `multi_county_auctions`, `master_index`, `insights`, `claude_context_checkpoints`

## Architecture Rules

### Non-Negotiables
- Zero user actions — if blocked, try 3 alternatives before escalating
- All state persists to Supabase or GitHub — never local-only
- Async everywhere: `httpx.AsyncClient`, `asyncio`, async FastAPI endpoints
- Type hints on every function. Pydantic models for all API contracts.
- Circuit breakers on all external API calls (RealForeclose, BCPAO, AcclaimWeb, AgentQL)

### LangGraph Patterns
- Agents communicate via typed JSON state objects — never raw strings
- Max 3 retries per node before routing to fallback
- Token budget: 800K per graph run, then checkpoint and resume
- State checkpoints go to `claude_context_checkpoints` table
- Each agent node must be independently testable

### API Design
- All endpoints return `{"status": "ok|error", "data": {...}, "meta": {...}}`
- Rate limit all public endpoints
- OpenAPI docs auto-generated at `/docs`
- Health check at `/health` — Render monitors this

### Key Integrations
- **Supabase:** Service role for writes, anon for reads. RLS active on public tables.
- **AgentQL:** Semantic scraping. Key in GitHub Secrets as `AGENTQL_API_KEY`.
- **LiteLLM:** Smart Router proxy. Sonnet 4.5 default, DeepSeek V3.2 for ULTRA_CHEAP tier.
- **GitHub Actions:** `master_scraper.yml` daily 11PM EST. Credentials in GitHub Secrets.

## Development Workflow

### Before Starting Any Task
1. `git pull origin main`
2. Load `TODO.md` — find current unchecked task
3. Check `PROJECT_STATE.json` for recent decisions
4. Execute → test → commit → push → **COMPOUND**

### Running Locally
```bash
pip install -r requirements.txt
uvicorn src.main:app --reload --port 8000
```

### Testing
```bash
pytest tests/ -v --tb=short
```

### Deploying
Push to `main` → Render auto-deploys. Verify at `/health` endpoint.

## File Map

| Path | Purpose |
|------|---------|
| `src/agents/` | LangGraph agent nodes |
| `src/scrapers/` | Data collection (RealForeclose, BCPAO, AcclaimWeb, AgentQL) |
| `src/routers/` | FastAPI route handlers |
| `src/models/` | Pydantic data models |
| `src/utils/` | Shared utilities, Supabase client, LiteLLM router |
| `tests/` | pytest test suite |
| `.github/workflows/` | CI/CD and master_scraper |
| `TODO.md` | Current sprint tasks |
| `PROJECT_STATE.json` | Session state persistence |

## Common Pitfalls (Compounded)

- **Supabase RLS:** Service role key bypasses RLS. Use it for server-side inserts. Anon key for client-facing reads.
- **Render cold starts:** Free tier sleeps after 15 min. Use `/health` ping in GitHub Actions to keep warm.
- **httpx vs requests:** Never use `requests` — always `httpx.AsyncClient` with timeout=(10, 30).
- **LangGraph state:** Always use `TypedDict` for graph state, never plain dicts. Serialization breaks otherwise.
- **67 counties at scale:** Render.com required at 50+ counties. Test with 3 counties first, batch at 10.

---

## Compounded Learnings

> Append new entries at the TOP. This is the compound engine — each session makes the next one better.

<!-- 
#### YYYY-MM-DD: [Title]
- **What worked:** 
- **What broke:** 
- **Rule for next time:** 
-->

---

## Escalation

If blocked after 3 attempts:
1. Log to Supabase `insights` table with `type: 'blocker'`
2. Surface: `BLOCKED: [issue]. Tried: [attempts]. Recommend: [solution].`
3. Continue with other tasks — never wait idle
