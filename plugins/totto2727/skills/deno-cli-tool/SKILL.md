---
name: deno-cli-tool
description: >-
  Rules for creating single-file CLI tools with Deno and TypeScript. Covers
  shebang setup, argument parsing with Effect CLI, and installation conventions.
  MUST be applied when building CLI tools or command-line utilities.
---

# Deno CLI Tool

Rules for building single-file CLI tools with Deno.
For general scripting rules (imports, built-in API preference, prohibited technologies), see [script-rules](../script-rules/SKILL.md).

## Core Principles

1. **Single file** — one `.ts` file unless explicitly told otherwise
2. **Executable via shebang** — include permissions in shebang, install with `chmod +x`
3. **No build step** — Deno runs TypeScript directly

## Tech Stack

### Argument Parsing (REQUIRED: Effect CLI)

Always use Effect CLI for argument parsing:

| Purpose       | Package                 | Registry                                     |
| ------------- | ----------------------- | -------------------------------------------- |
| CLI framework | `@effect/cli`           | `jsr:@totto2727/fp@3.0/effect/cli`           |
| Core / Schema | `effect`                | `jsr:@totto2727/fp@3.0/effect`               |
| HTTP client   | `@effect/platform`      | `jsr:@totto2727/fp@3.0/effect/platform`      |
| Node runtime  | `@effect/platform-node` | `jsr:@totto2727/fp@3.0/effect/platform/node` |

### Other Libraries

| Purpose          | Package     | Registry        |
| ---------------- | ----------- | --------------- |
| Terminal spinner | `ora`       | `npm:ora`       |
| Terminal colors  | `ansis`     | `npm:ansis`     |
| YAML parsing     | `@std/yaml` | `jsr:@std/yaml` |
| Path utilities   | `@std/path` | `jsr:@std/path` |

## Shebang

Only request the minimum permissions needed:

```typescript
#!/usr/bin/env -S deno run --allow-read --allow-write --allow-net
```

Common flags: `--allow-read`, `--allow-write`, `--allow-net`, `--allow-env`, `--allow-run`, `--allow-ffi`

## Setup

```bash
chmod +x my-tool.ts
```

## Template

- [templates/effect.ts](./templates/effect.ts) — Effect CLI with subcommands, HTTP client, schema validation

## Reference

- [reference/c7.ts](./reference/c7.ts) — production example (Context7 CLI client using Effect)
