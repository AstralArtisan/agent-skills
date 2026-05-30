#!/usr/bin/env bash
# 把本仓库里的某个 skill 安装到 Claude Code 或 Codex / 跨工具的技能目录。
# 用法: ./install.sh <skill-name> [claude|codex]
#   claude        -> ~/.claude/skills/<skill>
#   codex|gemini  -> ~/.agents/skills/<skill>   (跨工具约定目录)
set -euo pipefail

SKILL="${1:-}"
TARGET="${2:-claude}"

if [ -z "$SKILL" ]; then
  echo "用法: ./install.sh <skill-name> [claude|codex]"
  echo "可用 skill:"
  ls -1 "$(cd "$(dirname "$0")" && pwd)/plugins" 2>/dev/null || true
  exit 1
fi

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$REPO_DIR/plugins/$SKILL/skills/$SKILL"

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "找不到 skill：$SRC/SKILL.md"
  exit 1
fi

case "$TARGET" in
  claude)              DEST_DIR="$HOME/.claude/skills" ;;
  codex|agents|gemini) DEST_DIR="$HOME/.agents/skills" ;;
  *) echo "未知目标 '$TARGET'（请用 claude 或 codex）"; exit 1 ;;
esac

DEST="$DEST_DIR/$SKILL"
mkdir -p "$DEST_DIR"
rm -rf "$DEST"
cp -r "$SRC" "$DEST"
echo "已安装：$SKILL -> $DEST"
echo "提示：Codex 等需重启会话以重新扫描技能；Claude Code 重启或重载即可。"
