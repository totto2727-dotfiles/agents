---
name: cloudflare-markdown
description: Renders web pages or raw HTML content to Markdown using Cloudflare Browser Rendering API. Use when converting URLs or HTML to Markdown format.
---

# Cloudflare Markdown Rendering

Renders web pages or raw HTML content to Markdown using Cloudflare Browser Rendering API.

## Usage

Convert a URL to Markdown:
```bash
bash render.bash --url "https://example.com"
```

Convert raw HTML to Markdown:
```bash
bash render.bash --html "<div>Hello World</div>"
```

## Options

| Option | Description |
|--------|-------------|
| `--url URL` | URL to fetch and convert to Markdown |
| `--html HTML` | Raw HTML content to convert to Markdown |
| `--wait-until TYPE` | Page load behavior: `load`, `domcontentloaded`, `networkidle0`, `networkidle2` |
| `--reject PATTERN` | Reject request patterns (regex, can be specified multiple times) |
| `--user-agent UA` | Custom user agent string |
| `--help` | Show help message |

## Examples

### Basic URL conversion
```bash
bash render.bash --url "https://developers.cloudflare.com/"
```

### JavaScript-heavy pages
For SPAs or JS-heavy pages, use `networkidle0` or `networkidle2`:
```bash
bash render.bash --url "https://spa-example.com" --wait-until networkidle0
```

### Exclude CSS requests
```bash
bash render.bash --url "https://example.com" --reject '/^.*\.(css)/'
```

### Custom user agent
```bash
bash render.bash --url "https://example.com" --user-agent "Mozilla/5.0 (compatible; MyBot/1.0)"
```

## Credentials

Credentials are retrieved from macOS Keychain:
- `CLOUDFLARE_ACCOUNT_ID` - Cloudflare account ID
- `CLOUDFLARE_MARKDOWN_API_KEY` - Cloudflare API token with Browser Rendering permissions

To store credentials:
```bash
security add-generic-password -s CLOUDFLARE_ACCOUNT_ID -a CLOUDFLARE_ACCOUNT_ID -w "your-account-id"
security add-generic-password -s CLOUDFLARE_MARKDOWN_API_KEY -a CLOUDFLARE_MARKDOWN_API_KEY -w "your-api-token"
```

## Output

Returns JSON response from Cloudflare API:
```json
{
  "success": true,
  "result": "# Example Domain\n\nThis domain is for use in illustrative examples..."
}
```

## Requirements

- `jq` for JSON processing
- `curl` for HTTP requests
- macOS Keychain with stored credentials
