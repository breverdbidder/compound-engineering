# /plan — Research Codebase and Create Implementation Plan

You are starting a new task in Claude Code. Before writing any code, you must plan.

## Instructions

1. **Read CLAUDE.md first.** Load the full file. Check `## Compounded Learnings` for relevant past lessons. Check `## Common Pitfalls` for known gotchas.

2. **Read TODO.md.** Find the current unchecked task. If the user specified a task, use that instead.

3. **Research the codebase.** Investigate relevant files before proposing changes:
   - Find existing patterns that relate to the task
   - Check for tests that cover the area
   - Identify dependencies and imports
   - Look for related TODO/FIXME/HACK comments

4. **Check Compounded Learnings.** Search for any past learnings relevant to this task. Apply them proactively.

5. **Output an implementation plan** in this format:

```
📋 PLAN: {{Task Title}}

Context from CLAUDE.md:
- {{relevant learning or pitfall}}

Files to modify:
- {{path}} — {{what changes}}

Files to create:
- {{path}} — {{purpose}}

Steps:
1. {{step}}
2. {{step}}
3. {{step}}

Tests needed:
- {{test description}}

Risks:
- {{potential issue and mitigation}}
```

6. **Wait for confirmation** before executing. If the user says "go" or "do it", proceed to implementation.

## Rules
- NEVER skip reading CLAUDE.md — it contains hard-won knowledge
- NEVER propose changes without checking existing patterns first
- Plans should have 3-7 steps. If more, break into sub-tasks.
- Always include at least one test in the plan
- If a Compounded Learning is relevant, cite it explicitly: "Per compound entry {{date}}: {{rule}}"
