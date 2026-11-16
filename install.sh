#!/bin/sh
# Installs the masterbuilt skill for Claude Code for the current user (macOS or Linux).
set -e
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$HOME/.claude/skills"
rm -rf "$HOME/.claude/skills/masterbuilt"
cp -R "$here/skills/masterbuilt" "$HOME/.claude/skills/masterbuilt"
echo "Installed to $HOME/.claude/skills/masterbuilt. Start a new Claude Code session to use it."
