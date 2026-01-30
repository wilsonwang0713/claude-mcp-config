# Claude Code MCP Configuration

[English](#english) | [繁體中文](#繁體中文)

---

## English

A curated collection of MCP (Model Context Protocol) server configurations for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

### Included MCP Servers

| Server | Description | Auth Type |
|--------|-------------|-----------|
| **github-personal** | GitHub API for personal repositories | API Token |
| **github-work** | GitHub API for work repositories | API Token |
| **gitlab** | GitLab API integration | API Token |
| **atlassian-luffydesign** | Jira & Confluence (luffydesign workspace) | API Token |
| **atlassian-fxtec** | Jira & Confluence (fxtec workspace) | API Token |
| **postman-luffydesign** | Postman API collections | Bearer Token |
| **postman-rapidlink** | Postman API collections | Bearer Token |
| **plane** | Plane project management | API Key |
| **vercel** | Vercel deployment platform | OAuth |
| **supabase** | Supabase database & auth | OAuth |
| **memory** | Local knowledge graph storage | None |
| **gdrive** | Google Drive file access | OAuth |

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/wilsonwang0713/claude-mcp-config.git ~/antigravity/Claude-mcp
   cd ~/antigravity/Claude-mcp
   ```

2. Copy the example file and add your credentials:
   ```bash
   cp settings.local.example.json settings.local.json
   ```

3. Edit `settings.local.json` with your API keys and tokens.

4. Run the sync script to apply settings:
   ```bash
   ./sync-to-claude.sh
   ```

### File Structure

```
.
├── settings.json               # Base MCP server configurations
├── settings.local.json         # Your credentials (git-ignored)
├── settings.local.example.json # Template for credentials
└── sync-to-claude.sh           # Sync script to merge configs → ~/.claude.json
```

> **Note:** Claude Code reads MCP server configurations from `~/.claude.json`, not `~/.claude/settings.json`. The sync script merges your settings into the correct location while preserving other Claude Code settings.

### Adding a New MCP Server

1. Add the server configuration to `settings.json` (with empty credentials):
   ```json
   "new-server": {
     "command": "npx",
     "args": ["-y", "@org/server-package"],
     "env": {
       "API_KEY": ""
     }
   }
   ```

2. Add your credentials to `settings.local.json`:
   ```json
   "new-server": {
     "env": {
       "API_KEY": "your-actual-api-key"
     }
   }
   ```

3. Run the sync script:
   ```bash
   ./sync-to-claude.sh
   ```

4. Restart Claude Code to load the new server.

### Security

- `settings.local.json` is git-ignored to protect your credentials
- Never commit API keys or tokens to version control
- Use environment variables or secure vaults for production

---

## 繁體中文

為 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 精心整理的 MCP（Model Context Protocol）伺服器配置集合。

### 包含的 MCP 伺服器

| 伺服器 | 說明 | 認證方式 |
|--------|------|----------|
| **github-personal** | 個人 GitHub 儲存庫 API | API Token |
| **github-work** | 工作用 GitHub 儲存庫 API | API Token |
| **gitlab** | GitLab API 整合 | API Token |
| **atlassian-luffydesign** | Jira 與 Confluence（luffydesign 工作區）| API Token |
| **atlassian-fxtec** | Jira 與 Confluence（fxtec 工作區）| API Token |
| **postman-luffydesign** | Postman API 集合 | Bearer Token |
| **postman-rapidlink** | Postman API 集合 | Bearer Token |
| **plane** | Plane 專案管理 | API Key |
| **vercel** | Vercel 部署平台 | OAuth |
| **supabase** | Supabase 資料庫與認證 | OAuth |
| **memory** | 本地知識圖譜儲存 | 無需認證 |
| **gdrive** | Google Drive 檔案存取 | OAuth |

### 安裝方式

1. 複製此儲存庫：
   ```bash
   git clone https://github.com/wilsonwang0713/claude-mcp-config.git ~/antigravity/Claude-mcp
   cd ~/antigravity/Claude-mcp
   ```

2. 複製範例檔案並新增您的憑證：
   ```bash
   cp settings.local.example.json settings.local.json
   ```

3. 編輯 `settings.local.json`，填入您的 API 金鑰和 Token。

4. 執行同步腳本以套用設定：
   ```bash
   ./sync-to-claude.sh
   ```

### 檔案結構

```
.
├── settings.json               # 基本 MCP 伺服器配置
├── settings.local.json         # 您的憑證（已加入 git-ignore）
├── settings.local.example.json # 憑證範本
└── sync-to-claude.sh           # 同步腳本，合併設定到 ~/.claude.json
```

> **注意：** Claude Code 從 `~/.claude.json` 讀取 MCP 伺服器設定，而非 `~/.claude/settings.json`。同步腳本會將您的設定合併到正確的位置，同時保留 Claude Code 的其他既有設定。

### 新增 MCP 伺服器

1. 在 `settings.json` 新增伺服器設定（憑證留空）：
   ```json
   "new-server": {
     "command": "npx",
     "args": ["-y", "@org/server-package"],
     "env": {
       "API_KEY": ""
     }
   }
   ```

2. 在 `settings.local.json` 新增您的憑證：
   ```json
   "new-server": {
     "env": {
       "API_KEY": "your-actual-api-key"
     }
   }
   ```

3. 執行同步腳本：
   ```bash
   ./sync-to-claude.sh
   ```

4. 重新啟動 Claude Code 以載入新伺服器。

### 安全性說明

- `settings.local.json` 已加入 git-ignore，保護您的憑證安全
- 切勿將 API 金鑰或 Token 提交至版本控制
- 正式環境請使用環境變數或安全金鑰管理服務

---

## License

MIT
