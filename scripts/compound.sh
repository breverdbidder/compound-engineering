#!/bin/bash
# compound.sh — Append session learnings to CLAUDE.md
#
# Usage (manual):
#   ./compound.sh "Title" "What worked" "What broke" "Rule for next time"
#
# Usage (Claude Code — preferred):
#   Just run /compound in Claude Code. It handles everything.
#
# Example:
#   ./compound.sh \
#     "Supabase RLS debugging" \
#     "Using service role key for migration scripts" \
#     "Anon key silently returned empty arrays instead of errors" \
#     "Always test with both keys when debugging empty responses"

set -euo pipefail

CLAUDE_MD="CLAUDE.md"
DATE=$(date +%Y-%m-%d)

# --- Validate inputs ---
TITLE="${1:?Usage: ./compound.sh 'Title' 'What worked' 'What broke' 'Rule'}"
WORKED="${2:?Missing: What worked}"
BROKE="${3:?Missing: What broke}"
RULE="${4:?Missing: Rule for next time}"

# --- Check CLAUDE.md exists ---
if [ ! -f "$CLAUDE_MD" ]; then
  echo "❌ ${CLAUDE_MD} not found. Run install.sh first."
  exit 1
fi

# --- Build learning entry ---
ENTRY="#### ${DATE}: ${TITLE}
- **What worked:** ${WORKED}
- **What broke:** ${BROKE}
- **Rule for next time:** ${RULE}"

# --- Find insertion point ---
MARKER="## Compounded Learnings"
LINE_NUM=$(grep -n "$MARKER" "$CLAUDE_MD" | head -1 | cut -d: -f1)

if [ -z "$LINE_NUM" ]; then
  echo "❌ '${MARKER}' section not found in ${CLAUDE_MD}"
  exit 1
fi

# Insert after the marker line + description line (2 lines down)
INSERT_AFTER=$((LINE_NUM + 2))

# --- Insert entry into CLAUDE.md ---
{
  head -n "$INSERT_AFTER" "$CLAUDE_MD"
  echo ""
  echo "$ENTRY"
  echo ""
  tail -n +"$((INSERT_AFTER + 1))" "$CLAUDE_MD"
} > "${CLAUDE_MD}.tmp"

mv "${CLAUDE_MD}.tmp" "$CLAUDE_MD"

# --- Update header timestamp ---
sed -i "s/Last compounded:.*/Last compounded:** ${DATE} | **Sessions since last compound:** 0/" "$CLAUDE_MD"

# --- Count total learnings ---
COUNT=$(grep -c "^####" "$CLAUDE_MD" 2>/dev/null || echo "0")

echo "✅ Compounded: '${TITLE}' → ${CLAUDE_MD}"
echo "📚 Total learnings: ${COUNT}"
echo ""
echo "Don't forget to commit:"
echo "  git add CLAUDE.md && git commit -m 'compound: ${TITLE}' && git push"
