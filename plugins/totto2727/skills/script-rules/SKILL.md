---
name: script-rules
description: >-
  Script creation rules: prefer shell one-liners, use TypeScript with Deno
  for complex logic, prohibit Node.js and Python. Includes Deno disposable
  script conventions (npm:/jsr: imports, no URL imports). MUST ALWAYS be
  applied when creating scripts or automation tasks.
---

# Script Rules

## Rule (CRITICAL)

When creating scripts, follow this priority order:

1. **First choice**: Shell script one-liners
2. **Second choice**: TypeScript with Deno (only when variables or complex branching are necessary)
3. **Prohibited**: Node.js and Python

## Decision Flow

1. **Can it be done with a shell one-liner?** -> Use shell script
2. **Does it need variables or complex logic?** -> Use TypeScript with Deno (execute with `deno run <file>`)
3. **Never use Node.js or Python**

## Shebang (REQUIRED)

All script files MUST include a shebang line. This ensures scripts are executable with the correct interpreter.

### Bash

```bash
#!/bin/bash
```

### Deno

Include required permissions directly in the shebang:

```typescript
#!/usr/bin/env -S deno run --allow-read --allow-write
```

After adding the shebang, make the script executable with `chmod +x <file>`.

## Priority 1: Shell Script One-Liners (PREFERRED)

Use shell script one-liners for simple operations:

```bash
# File operations
find . -name "*.js" -type f | xargs grep "pattern"

# Text processing
cat file.txt | grep "pattern" | sed 's/old/new/g'

# File counting
ls -1 | wc -l

# Directory operations
mkdir -p path/to/dir && cd path/to/dir

# Conditional execution
[ -f file.txt ] && echo "exists" || echo "not found"
```

## Priority 2: TypeScript with Deno (When Necessary)

Use TypeScript with Deno only when:

- Variables are needed for complex logic
- Complex branching/conditionals are required
- Error handling beyond simple shell constructs is needed

**Execution**: Always use `deno run <file>` to execute Deno scripts.

```typescript
// Example: Complex script with variables and branching
const files = Deno.readDirSync(".");
const results: string[] = [];

for (const file of files) {
  if (file.isFile && file.name.endsWith(".ts")) {
    const content = Deno.readTextFileSync(file.name);
    if (content.includes("pattern")) {
      results.push(file.name);
    }
  }
}

console.log(results.join("\n"));
```

Execute with:

```bash
deno run --allow-read script.ts
```

### Deno Import Rules

Three principles for Deno scripts:

1. **Avoid URL imports** — never import from `https://deno.land/...`
2. **Use `npm:` / `jsr:` prefixes** — for all external packages
   - Prefer `jsr:` over `npm:` when the package is available on both registries
3. **Minimize dependencies** — prefer Deno built-in APIs

#### Correct Import Format

```typescript
// npm packages
import { z } from "npm:zod@3.22.4";

// jsr packages
import { Hono } from "jsr:@hono/hono@4.0.0";
import { HttpException } from "jsr:@hono/hono@4.0.0/http-exception";

// Deno standard library (via jsr)
import { join } from "jsr:@std/path@1.0.0";
import { parse } from "jsr:@std/yaml@1.0.0";

// npm packages
import { Hono } from "npm:hono@4.0.0";
import { HttpException } from "npm:hono@4.0.0/http-exception";
```

#### Incorrect Import Format

```typescript
// NG: URL imports
import { serve } from "https://deno.land/std@0.208.0/http/server.ts";
import { z } from "https://deno.land/x/zod@v3.22.4/mod.ts";
```

### Prefer Deno Built-in APIs

Before using external packages, check if Deno built-in APIs can accomplish the task:

```typescript
// File operations
const content = await Deno.readTextFile("./data.json");
await Deno.writeTextFile("./output.txt", result);

// Directory operations
await Deno.mkdir("./output", { recursive: true });
for await (const entry of Deno.readDir("./src")) {
  console.log(entry.name);
}

// Environment variables
const apiKey = Deno.env.get("API_KEY");

// Command execution
const command = new Deno.Command("git", {
  args: ["status"],
  stdout: "piped",
});
const { stdout } = await command.output();
```

## Prohibited Technologies

The following are **strictly prohibited**:

- **Node.js**: `node script.js`, `npm run`, etc.
- **Python**: `python script.py`, `python3 script.py`, `pip install`, etc.

## Additional Resources

- [Deno.\* API Reference](https://docs.deno.com/api/deno/all_symbols) - Deno built-in API reference
