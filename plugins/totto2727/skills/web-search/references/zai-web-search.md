# Z AI Web Search (web_search_prime)

Search the web with real-time results via the Z AI MCP server.

## MCP Server

- **Server name:** `plugin:totto2727:web-search-prime` (or local MCP configuration)
- **Tool name:** `web_search_prime`
- **Endpoint:** `https://api.z.ai/api/mcp/web_search_prime/mcp`

## Usage

The `web_search_prime` tool accepts a natural language search query and returns results including titles, URLs, summaries, site names, and icons.

### Example Queries

- "Latest React 19 documentation and new features"
- "Python asyncio best practices 2026"
- "Cloudflare Workers KV API reference"

### Result Fields

Each result includes:

- **Title** — Page title
- **URL** — Direct link to the page
- **Summary** — Brief description of the content
- **Site name** — Source website name
- **Icon** — Site favicon

## Parameters

| Parameter               | Required | Default   | Description                                                                         |
| ----------------------- | -------- | --------- | ----------------------------------------------------------------------------------- |
| `search_query`          | Yes      | —         | Search query (recommended: under 70 characters)                                     |
| `location`              | No       | `us`      | **Always set to `us`**. Available: `cn` (Chinese region), `us` (non-Chinese region) |
| `content_size`          | No       | `medium`  | Summary size: `medium` (400-600 words), `high` (2500 words)                         |
| `search_recency_filter` | No       | `noLimit` | Time range: `oneDay`, `oneWeek`, `oneMonth`, `oneYear`, `noLimit`                   |
| `search_domain_filter`  | No       | —         | Limit results to a specific domain (e.g. `react.dev`)                               |

## Tips

- **Always set `location` to `us`**
- Use specific, descriptive queries for better results
- Include version numbers or year when searching for documentation
- Target official sources by including "official docs" or the domain name in the query
- Sensitive information (API keys, passwords, credentials) must not be included in queries

## Quota Limits

Usage is subject to the Z AI plan quota. If quota is exhausted, inform the user and suggest they check their Z AI plan.
