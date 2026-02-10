# /review — AI Code Review Before Committing

You are reviewing code changes made in this session before they get committed.

## Instructions

Run through these review agents sequentially. For each, check the relevant files changed in this session.

### 1. 🔒 Security Agent
Check for:
- Hardcoded secrets, API keys, tokens (MUST be in env vars or GitHub Secrets)
- SQL injection vectors (use parameterized queries)
- Unvalidated user input
- Exposed internal endpoints
- CORS misconfiguration
- Missing authentication on protected routes

### 2. ⚡ Performance Agent
Check for:
- N+1 query patterns
- Missing async/await on I/O operations
- Unbounded loops or recursion
- Missing timeouts on external API calls (require explicit timeout)
- Large payloads without pagination
- Missing caching where appropriate

### 3. 🏗️ Architecture Agent
Check for:
- Consistency with patterns in CLAUDE.md
- Violation of repo conventions (type hints, error handling, naming)
- God functions (>50 lines) — recommend splitting
- Missing error handling on external calls
- Dead code or unused imports
- Hardcoded values that should be config

### 4. 🧪 Test Agent
Check for:
- New code without corresponding tests
- Tests that don't assert anything meaningful
- Missing edge case coverage
- Tests that depend on external services (should be mocked)
- Flaky test patterns (timing, ordering)

## Output Format

```
🔍 CODE REVIEW — {{number of files changed}} files

🔒 Security: {{✅ PASS | ⚠️ WARNING | ❌ FAIL}}
   {{findings or "No issues"}}

⚡ Performance: {{✅ PASS | ⚠️ WARNING | ❌ FAIL}}
   {{findings or "No issues"}}

🏗️ Architecture: {{✅ PASS | ⚠️ WARNING | ❌ FAIL}}
   {{findings or "No issues"}}

🧪 Tests: {{✅ PASS | ⚠️ WARNING | ❌ FAIL}}
   {{findings or "No issues"}}

VERDICT: {{SHIP IT 🚀 | FIX THEN SHIP ⚠️ | DO NOT SHIP ❌}}
```

## Rules
- Be specific: "Line 42 in scraper.py: httpx.get without timeout" not "some calls lack timeouts"
- ❌ FAIL means: do not commit until fixed. Fix it now.
- ⚠️ WARNING means: commit but create a TODO for follow-up
- After fixing ❌ issues, re-run /review to confirm
- If VERDICT is SHIP IT, proceed to commit. Then run /compound.
