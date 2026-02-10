# /compound — Capture Session Learnings

You are ending a Claude Code development session. Your job is to capture what was learned and append it to CLAUDE.md so the next session starts smarter.

## Instructions

1. **Review this session's work.** Look at all commits, file changes, errors encountered, and solutions found.

2. **Extract exactly 3 learnings** in this format:
   - **What worked:** A pattern, tool, or approach that succeeded
   - **What broke:** An error, antipattern, or gotcha encountered
   - **Rule for next time:** A one-liner directive for future sessions

3. **Append to CLAUDE.md** under the `## Compounded Learnings` section. Insert at the TOP of that section (newest first). Use this exact format:

```markdown
#### {{TODAY_DATE}}: {{BRIEF_TITLE}}
- **What worked:** {{description}}
- **What broke:** {{description}}
- **Rule for next time:** {{one-liner}}
```

4. **Update the header** timestamp: change `Last compounded:` to today's date and reset sessions counter to 0.

5. **Update TODO.md** — mark completed tasks `[x]`, add any new tasks discovered.

6. **Commit and push** with message: `compound: {{BRIEF_TITLE}}`

## Rules
- Be specific and actionable — "API was slow" is bad, "BCPAO API times out after 10s on parcel lookups, use 30s timeout" is good
- Never compound generic knowledge ("Python is good") — only session-specific discoveries
- If nothing broke, write "Nothing broke this session" — don't invent problems
- Keep each bullet to 1-2 sentences max
- This commit should be the LAST commit of every session
