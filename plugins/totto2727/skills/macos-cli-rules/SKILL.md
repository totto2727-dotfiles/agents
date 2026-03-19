---
name: macos-cli-rules
description: >-
  Enforces GNU coreutils with 'g' prefix on macOS instead of BSD defaults. MUST
  ALWAYS be applied when using coreutils commands (ls, find, sed, awk, grep,
  etc.) on macOS. On Linux, use standard commands directly.
---

# macOS CLI Rules

## Rule (CRITICAL)

**ALWAYS** use GNU coreutils commands with `g` prefix instead of Mac default BSD commands.

**NEVER** use Mac standard commands directly.

## Command Mapping

| GNU Command (Use) | Mac BSD Command (Prohibited) | Description                                          |
| ----------------- | ---------------------------- | ---------------------------------------------------- |
| `gls`             | `ls`                         | List directory contents                              |
| `gfind`           | `find`                       | Find files                                           |
| `gsed`            | `sed`                        | Stream editor                                        |
| `gawk`            | `awk`                        | Pattern scanning and processing                      |
| `ggrep`           | `grep`                       | Search patterns                                      |
| `gcat`            | `cat`                        | Concatenate files                                    |
| `gcp`             | `cp`                         | Copy files                                           |
| `gmv`             | `mv`                         | Move files                                           |
| `grm`             | `rm`                         | Remove files                                         |
| `gmkdir`          | `mkdir`                      | Create directories                                   |
| `gchmod`          | `chmod`                      | Change file permissions                              |
| `gchown`          | `chown`                      | Change file ownership                                |
| `gdate`           | `date`                       | Display/set date                                     |
| `gtouch`          | `touch`                      | Change file timestamps                               |
| `ghead`           | `head`                       | Display first lines                                  |
| `gtail`           | `tail`                       | Display last lines                                   |
| `gsort`           | `sort`                       | Sort lines                                           |
| `guniq`           | `uniq`                       | Remove duplicate lines                               |
| `gwc`             | `wc`                         | Word count                                           |
| `gcut`            | `cut`                        | Cut fields                                           |
| `gtr`             | `tr`                         | Translate characters                                 |
| `gxargs`          | `xargs`                      | Build and execute commands                           |
| `gstat`           | `stat`                       | Display file status                                  |
| `greadlink`       | `readlink`                   | Read symbolic links                                  |
| `gln`             | `ln`                         | Create links                                         |
| `gshuf`           | `shuf`                       | Shuffle lines                                        |
| `gsplit`          | `split`                      | Split files                                          |
| `gbase64`         | `base64`                     | Base64 encode/decode                                 |
| `gmd5sum`         | `md5`                        | MD5 checksum                                         |
| `gsha256sum`      | `shasum`                     | SHA256 checksum                                      |
| `grealpath`       | `realpath`                   | Resolve paths (see [realpath](../realpath/SKILL.md)) |

## Examples

### Good: Using GNU Commands

```bash
# List files with GNU ls
gls -la

# Find files with GNU find
gfind . -name "*.ts" -type f

# Text processing with GNU sed
gsed -i 's/old/new/g' file.txt

# Pattern matching with GNU grep
ggrep -r "pattern" .

# File operations
gcp source.txt dest.txt
gmv old.txt new.txt
grm -rf directory/
```

### Bad: Using Mac BSD Commands

```bash
# DO NOT USE Mac standard commands
ls -la
find . -name "*.ts"
sed -i '' 's/old/new/g' file.txt
grep -r "pattern" .
cp source.txt dest.txt
```

## Common Patterns

### File Operations

```bash
# Copy with GNU cp
gcp -r source/ dest/

# Move with GNU mv
gmv file.txt newdir/

# Remove with GNU rm
grm -rf directory/
```

### Text Processing

```bash
# Search and replace with GNU sed
gsed -i 's/pattern/replacement/g' file.txt

# Pattern matching with GNU grep
ggrep -E "pattern1|pattern2" file.txt

# Process with GNU awk
gawk '{print $1, $3}' file.txt
```

### File Finding

```bash
# Find files with GNU find
gfind . -type f -name "*.ts" -exec ggrep -l "pattern" {} \;

# Find and process
gfind . -name "*.log" -mtime +30 -delete
```

## Path Operations

For path calculations (relative paths, absolute path conversion, symlink resolution), see the dedicated [realpath](../realpath/SKILL.md) skill.

## Platform Note

- **macOS**: Use this skill — all coreutils commands require the `g` prefix.
- **Linux**: Use standard coreutils commands directly (no prefix needed). This skill does not apply.

## Installation Note

GNU coreutils can be installed via Homebrew:

```bash
brew install coreutils
```

After installation, commands are available with `g` prefix.

## Rationale

- GNU coreutils provide consistent behavior across platforms
- Better compatibility with Linux systems
- More features and options than BSD versions
- Consistent behavior in scripts across different environments
