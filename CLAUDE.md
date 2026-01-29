# CLAUDE.md

This file provides guidance to Claude Code when working with this MCP configuration repository.

## Adding New MCP Servers

1. Add server config to `settings.json` (with empty/placeholder credentials)
2. Add corresponding entry to `settings.local.example.json` with placeholder values
3. Never commit real tokens - they go in `settings.local.json` (git-ignored)

## Naming Convention

- Multiple instances of same service: `{service}-{workspace}` (e.g., `atlassian-fxtec`, `github-work`)
- OAuth services: add `_comment` field explaining auth flow

## File Responsibilities

| File | Purpose | Contains Secrets |
|------|---------|------------------|
| `settings.json` | Base MCP server configurations | No (empty values) |
| `settings.local.json` | Actual credentials | Yes (git-ignored) |
| `settings.local.example.json` | Template for users | No (placeholders) |

## Common MCP Server Patterns

### API Token Auth
```json
"server-name": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-xxx"],
  "env": {
    "API_TOKEN": ""
  }
}
```

### OAuth (Remote MCP)
```json
"server-name": {
  "command": "npx",
  "args": ["-y", "mcp-remote", "https://mcp.service.com/sse"]
}
```

### With Headers
```json
"server-name": {
  "command": "npx",
  "args": ["-y", "@org/server-xxx"],
  "headers": {
    "Authorization": ""
  }
}
```
