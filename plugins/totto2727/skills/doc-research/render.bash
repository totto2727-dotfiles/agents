#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<EOF
Usage: bash render.bash [OPTIONS]

Cloudflare Browser Rendering Markdown API client.

Required (one of):
  --url URL          URL to fetch and convert to Markdown
  --html HTML        Raw HTML content to convert to Markdown

Optional:
  --wait-until TYPE  Page load behavior: load, domcontentloaded, networkidle0, networkidle2
  --reject PATTERN   Reject request patterns (JSON array string, can be specified multiple times)
  --user-agent UA    Custom user agent string
  --help             Show this help message

Examples:
  bash render.bash --url "https://example.com"
  bash render.bash --url "https://example.com" --wait-until networkidle0
  bash render.bash --html "<div>Hello World</div>"
  bash render.bash --url "https://example.com" --reject '/^.*\\.(css)/'

Credentials are retrieved from macOS Keychain:
  - CLOUDFLARE_ACCOUNT_ID (service: CLOUDFLARE_ACCOUNT_ID)
  - CLOUDFLARE_MARKDOWN_API_KEY (service: CLOUDFLARE_MARKDOWN_API_KEY)
EOF
  exit 0
}

get_credential() {
  local service="$1"
  security find-generic-password -s "$service" -a "$service" -w 2>/dev/null
}

ACCOUNT_ID=$(get_credential "CLOUDFLARE_ACCOUNT_ID")
API_TOKEN=$(get_credential "CLOUDFLARE_MARKDOWN_API_KEY")

if [[ -z "$ACCOUNT_ID" ]]; then
  echo "Error: CLOUDFLARE_ACCOUNT_ID not found in keychain" >&2
  exit 1
fi

if [[ -z "$API_TOKEN" ]]; then
  echo "Error: CLOUDFLARE_MARKDOWN_API_KEY not found in keychain" >&2
  exit 1
fi

URL=""
HTML=""
WAIT_UNTIL=""
REJECT_PATTERNS=()
USER_AGENT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --url)
      URL="$2"
      shift 2
      ;;
    --html)
      HTML="$2"
      shift 2
      ;;
    --wait-until)
      WAIT_UNTIL="$2"
      shift 2
      ;;
    --reject)
      REJECT_PATTERNS+=("$2")
      shift 2
      ;;
    --user-agent)
      USER_AGENT="$2"
      shift 2
      ;;
    --help|-h)
      usage
      ;;
    *)
      echo "Error: Unknown option: $1" >&2
      usage
      ;;
  esac
done

if [[ -z "$URL" && -z "$HTML" ]]; then
  echo "Error: Either --url or --html is required" >&2
  usage
fi

if [[ -n "$URL" && -n "$HTML" ]]; then
  echo "Error: Cannot use both --url and --html" >&2
  usage
fi

JSON_PARTS=()

if [[ -n "$URL" ]]; then
  JSON_PARTS+=("\"url\": $(jq -Rs . <<< "$URL")")
else
  JSON_PARTS+=("\"html\": $(jq -Rs . <<< "$HTML")")
fi

if [[ -n "$WAIT_UNTIL" ]]; then
  JSON_PARTS+=("\"gotoOptions\": {\"waitUntil\": $(jq -Rs . <<< "$WAIT_UNTIL")}")
fi

if [[ ${#REJECT_PATTERNS[@]} -gt 0 ]]; then
  REJECT_JSON=$(printf '%s\n' "${REJECT_PATTERNS[@]}" | jq -R . | jq -s .)
  JSON_PARTS+=("\"rejectRequestPattern\": $REJECT_JSON")
fi

if [[ -n "$USER_AGENT" ]]; then
  JSON_PARTS+=("\"userAgent\": $(jq -Rs . <<< "$USER_AGENT")")
fi

JSON_BODY=$(IFS=,; echo "{${JSON_PARTS[*]}}")

curl -s -X POST \
  "https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/browser-rendering/markdown" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${API_TOKEN}" \
  -d "$JSON_BODY" \
  | jq -r '.result'
