#!/bin/bash
# sync-to-claude.sh
# 合併 settings.json + settings.local.json → ~/.claude/settings.json
#
# 使用方式：
#   ./sync-to-claude.sh
#
# 此腳本會將基本設定 (settings.json) 與本地憑證 (settings.local.json)
# 深度合併後輸出到 Claude Code 的設定檔

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.claude/settings.json"

# 確保 ~/.claude 目錄存在
mkdir -p "$HOME/.claude"

# 檢查必要檔案是否存在
if [[ ! -f "$SCRIPT_DIR/settings.json" ]]; then
    echo "錯誤：找不到 settings.json"
    exit 1
fi

if [[ ! -f "$SCRIPT_DIR/settings.local.json" ]]; then
    echo "錯誤：找不到 settings.local.json"
    echo "請先複製 settings.local.example.json 並填入您的憑證："
    echo "  cp settings.local.example.json settings.local.json"
    exit 1
fi

# 深度合併 JSON 並輸出
jq -s '
  def deepmerge:
    if type == "array" then
      .[0] as $a | .[1] as $b |
      if ($a | type) == "object" and ($b | type) == "object" then
        $a * $b | to_entries | map({(.key): .value}) | add
      else
        $b // $a
      end
    else
      .
    end;
  .[0] * .[1]
' "$SCRIPT_DIR/settings.json" "$SCRIPT_DIR/settings.local.json" > "$TARGET"

echo "✅ 已同步到 $TARGET"
