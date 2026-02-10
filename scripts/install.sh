#!/bin/bash
# install.sh — Bootstrap Compound Engineering into any repo
#
# Usage: 
#   curl -sSL https://raw.githubusercontent.com/breverdbidder/compound-engineering/main/scripts/install.sh | bash
#   OR
#   git clone https://github.com/breverdbidder/compound-engineering.git /tmp/ce && /tmp/ce/scripts/install.sh
#
# What it does:
#   1. Creates .claude/commands/ with /plan, /review, /compound, /boot slash commands
#   2. Copies compound.sh to repo root
#   3. Creates CLAUDE.md from template if one doesn't exist
#   4. Adds compound files to .gitignore exceptions

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
CE_SOURCE="${SCRIPT_DIR}/.."

echo "🔧 Installing Compound Engineering into: ${REPO_ROOT}"
echo ""

# --- 1. Create .claude/commands/ directory ---
COMMANDS_DIR="${REPO_ROOT}/.claude/commands"
mkdir -p "$COMMANDS_DIR"
echo "✅ Created ${COMMANDS_DIR}"

# --- 2. Copy slash commands ---
if [ -d "${CE_SOURCE}/.claude/commands" ]; then
  # Local install from cloned repo
  cp "${CE_SOURCE}/.claude/commands/"*.md "$COMMANDS_DIR/"
  echo "✅ Installed slash commands: /boot, /plan, /review, /compound"
else
  # Remote install — download from GitHub
  BASE_URL="https://raw.githubusercontent.com/breverdbidder/compound-engineering/main/.claude/commands"
  for cmd in boot plan review compound; do
    curl -sSL "${BASE_URL}/${cmd}.md" -o "${COMMANDS_DIR}/${cmd}.md"
  done
  echo "✅ Downloaded slash commands: /boot, /plan, /review, /compound"
fi

# --- 3. Copy compound.sh ---
if [ -f "${CE_SOURCE}/scripts/compound.sh" ]; then
  cp "${CE_SOURCE}/scripts/compound.sh" "${REPO_ROOT}/compound.sh"
else
  curl -sSL "https://raw.githubusercontent.com/breverdbidder/compound-engineering/main/scripts/compound.sh" \
    -o "${REPO_ROOT}/compound.sh"
fi
chmod +x "${REPO_ROOT}/compound.sh"
echo "✅ Installed compound.sh"

# --- 4. Create CLAUDE.md if it doesn't exist ---
if [ ! -f "${REPO_ROOT}/CLAUDE.md" ]; then
  REPO_NAME=$(basename "$REPO_ROOT")
  
  if [ -f "${CE_SOURCE}/templates/CLAUDE-generic.md" ]; then
    cp "${CE_SOURCE}/templates/CLAUDE-generic.md" "${REPO_ROOT}/CLAUDE.md"
  else
    curl -sSL "https://raw.githubusercontent.com/breverdbidder/compound-engineering/main/templates/CLAUDE-generic.md" \
      -o "${REPO_ROOT}/CLAUDE.md"
  fi
  
  # Replace placeholder with actual repo name
  sed -i "s/\[REPO_NAME\]/${REPO_NAME}/g" "${REPO_ROOT}/CLAUDE.md"
  
  echo "✅ Created CLAUDE.md (customize for your repo)"
else
  echo "⏭️  CLAUDE.md already exists — skipping (won't overwrite)"
fi

# --- 5. Create TODO.md if it doesn't exist ---
if [ ! -f "${REPO_ROOT}/TODO.md" ]; then
  cat > "${REPO_ROOT}/TODO.md" << 'TODOEOF'
# TODO

## Current Sprint

- [ ] Review and customize CLAUDE.md for this repo
- [ ] Run first session with /boot → /plan → work → /review → /compound

## Backlog

TODOEOF
  echo "✅ Created TODO.md"
else
  echo "⏭️  TODO.md already exists — skipping"
fi

# --- 6. Ensure .claude/ is not gitignored ---
if [ -f "${REPO_ROOT}/.gitignore" ]; then
  if grep -q "^\.claude" "${REPO_ROOT}/.gitignore" 2>/dev/null; then
    # Add exception for .claude/commands
    if ! grep -q "!\.claude/commands" "${REPO_ROOT}/.gitignore" 2>/dev/null; then
      echo "!.claude/commands/" >> "${REPO_ROOT}/.gitignore"
      echo "✅ Added .claude/commands/ exception to .gitignore"
    fi
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Compound Engineering installed!"
echo ""
echo "Available slash commands in Claude Code:"
echo "  /boot      — Start session (loads context)"
echo "  /plan      — Research + create implementation plan"
echo "  /review    — Multi-agent code review"
echo "  /compound  — Capture learnings (run at END of every session)"
echo ""
echo "Workflow:  /boot → /plan → code → /review → /compound"
echo ""
echo "Next steps:"
echo "  1. Customize CLAUDE.md for your repo"
echo "  2. Open Claude Code and try: /boot"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
