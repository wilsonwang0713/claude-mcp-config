#!/bin/bash
# sync-to-claude.sh
# 合併 settings.json + settings.local.json 的 mcpServers 到 ~/.claude.json
#
# 使用方式：
#   ./sync-to-claude.sh
#
# 此腳本會將基本設定 (settings.json) 與本地憑證 (settings.local.json)
# 深度合併後，更新到 Claude Code 的主設定檔 ~/.claude.json

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.claude.json"

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

# 如果目標檔案不存在，建立空的 JSON
if [[ ! -f "$TARGET" ]]; then
    echo "{}" > "$TARGET"
fi

# 深度合併 mcpServers：
# 1. 先合併 settings.json 和 settings.local.json 的 mcpServers
# 2. 再將結果合併到 ~/.claude.json，保留其他既有設定
jq -s '
  # 合併兩個 mcpServers 物件（settings.json + settings.local.json）
  (.[0].mcpServers // {}) as $base |
  (.[1].mcpServers // {}) as $local |

  # 深度合併每個 server 的設定
  ($base | keys) as $baseKeys |
  ($local | keys) as $localKeys |
  ($baseKeys + $localKeys | unique) as $allKeys |

  reduce $allKeys[] as $key ({};
    . + {($key): (($base[$key] // {}) * ($local[$key] // {}))}
  ) as $mergedServers |

  # 將合併後的 mcpServers 更新到目標檔案
  .[2] * {mcpServers: $mergedServers}
' "$SCRIPT_DIR/settings.json" "$SCRIPT_DIR/settings.local.json" "$TARGET" > "$TARGET.tmp"

mv "$TARGET.tmp" "$TARGET"

echo "✅ 已同步 MCP 伺服器設定到 $TARGET"
echo ""
echo "已設定的 MCP 伺服器："
jq -r '.mcpServers | keys[]' "$TARGET" | sed 's/^/  - /'
