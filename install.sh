#!/bin/bash
# researcher — installer
#
# Copies the research agent into ~/.claude/agents/. That is all it does.
# It downloads nothing and installs no packages.
#
#   ./install.sh              install
#   ./install.sh --uninstall  remove

set -euo pipefail

AGENT_NAME="researcher"
AGENTS_DIR="$HOME/.claude/agents"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$SCRIPT_DIR/agents/$AGENT_NAME.md"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

if [[ "${1:-}" == "--uninstall" ]]; then
    if [[ -f "$AGENTS_DIR/$AGENT_NAME.md" ]]; then
        rm -f "$AGENTS_DIR/$AGENT_NAME.md"
        info "Removed $AGENTS_DIR/$AGENT_NAME.md"
    else
        warn "Not installed."
    fi
    exit 0
fi

[[ -f "$SOURCE" ]] || { error "Source not found: $SOURCE"; exit 1; }

mkdir -p "$AGENTS_DIR"
cp "$SOURCE" "$AGENTS_DIR/"
info "Installed the research agent to $AGENTS_DIR/$AGENT_NAME.md"

echo ""
info "Done. Restart Claude Code, then ask it, for example:"
echo '    استخدم وكيل researcher وابحث لي عن أنظمة كشف وصدّ المسيّرات المتاحة تجارياً'
echo ""
echo "  The agent uses Claude Code's built-in web search — no API key needed."
