---
name: realpath
description: >-
  Cross-platform path operations using realpath. On macOS, use `grealpath` (GNU
  coreutils); on Linux, use `realpath` directly. MUST ALWAYS be applied when
  calculating relative paths, converting to absolute paths, or resolving
  symlinks.
---

# Cross-Platform Path Operations with realpath

## Platform Rule (CRITICAL)

| Platform  | Command     | Notes                                                                                                                               |
| --------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **macOS** | `grealpath` | Requires GNU coreutils (`brew install coreutils`). See [macos-cli-rules](../macos-cli-rules/SKILL.md) for full GNU coreutils usage. |
| **Linux** | `realpath`  | Available by default in GNU/Linux.                                                                                                  |

All examples below use `realpath`. **On macOS, replace every `realpath` with `grealpath`.**

## When to Use

**ALWAYS** use `realpath` for:

- Calculating relative paths between files/directories
- Converting relative paths to absolute paths
- Resolving symbolic links to absolute paths

**NEVER** manually calculate relative paths, use `cd`/`pwd` combinations, or use string manipulation for paths.

## Relative Path Calculation

Use `realpath --relative-to=<base>` to calculate relative paths:

```bash
# Calculate relative path from base directory to target
realpath --relative-to=/home/user /home/user/test
# Output: test

# Calculate relative path from current directory
realpath --relative-to=. ./subdir/file.txt
# Output: subdir/file.txt

# Calculate relative path between two specific paths
realpath --relative-to=/path/to/base /path/to/base/subdir/file.txt
# Output: subdir/file.txt
```

## Absolute Path Conversion

```bash
# Convert relative path to absolute path
realpath ./subdir/file.txt
# Output: /home/user/project/subdir/file.txt

# Resolve symbolic links to absolute paths
realpath symlink
# Output: /home/user/project/actual/path
```

## Common Use Cases

```bash
# From file A to file B
realpath --relative-to=/path/to/fileA /path/to/fileB

# Simple conversion
realpath relative/path/to/file

# Resolve all symbolic links
realpath symlink
```

## Key Notes

- The `--relative-to` option is a GNU extension — BSD `realpath` does not support it
- Paths are normalized (removes `.` and `..` components)
