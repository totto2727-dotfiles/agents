---
name: doc-research
description: This skill should be used when the user asks to "search documentation", "find docs for", "look up API reference", "how to use [library]", or needs up-to-date information about a library, framework, or technology. Performs prioritized documentation research using Context7, cloudflare-docs, WebSearch, and cloudflare-browser.
context: fork
allowed-tools: mcp__plugin_totto2727_context7__resolve-library-id, mcp__plugin_totto2727_context7__query-docs, mcp__plugin_totto2727_cloudflare-docs__search_cloudflare_documentation, mcp__plugin_totto2727_cloudflare-browser__get_url_markdown, WebSearch
---

# Documentation Research

Perform prioritized documentation research and return only relevant results.

## Available Tools

| Priority | Tool | Use Case |
|---|---|---|
| Special | `mcp__plugin_totto2727_cloudflare-docs__search_cloudflare_documentation` | Cloudflare product queries only |
| Primary | `mcp__plugin_totto2727_context7__resolve-library-id` → `mcp__plugin_totto2727_context7__query-docs` | General library/framework official docs |
| Fallback | `WebSearch` | When above sources are insufficient |
| Fallback | `mcp__plugin_totto2727_cloudflare-browser__get_url_markdown` | Extract clean markdown from URLs found via WebSearch |

## Workflow

1. **Determine query type**
   - Cloudflare-related → Use `search_cloudflare_documentation`
   - General library/framework → Use Context7 (`resolve-library-id` then `query-docs`)

2. **Evaluate results**
   - Sufficient information found → Return results
   - Insufficient → Proceed to step 3

3. **Fallback: WebSearch**
   - Search with keywords targeting official sources (official docs, official blogs)
   - Prefer results from official documentation sites

4. **Deep content extraction (if needed)**
   - Use `get_url_markdown` to extract clean markdown from promising URLs
   - Only fetch URLs that are likely to contain the needed information

## Guidelines

- Always start with the highest-priority source for the query type
- Prefer official documentation over third-party content
- Return concise, relevant results only — do not include excessive raw output
- When using WebSearch, construct queries that target official sources
- When multiple results are found, summarize the key information rather than dumping raw content
