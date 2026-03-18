# Git Operations Rules

## Rule (CRITICAL)

These rules MUST ALWAYS be followed when performing git operations.

### Command Execution

Execute git commands one at a time — do not chain with `&&`. This ensures each command's exit status is verified before proceeding to the next.

Pipes (`|`) and command substitution (`$(...)`) within a single git command are allowed, as they form a single logical operation.

```bash
# Good: one command at a time
git add file.txt
git commit -m "feat: add file"

# Good: pipe within a single command
git log --oneline | head -10

# Bad: chaining with &&
git add file.txt && git commit -m "feat: add file"
```

### git -C

Do not use `git -C <path>`. Always `cd` to the repository directory first, or use absolute paths within the current working directory.

### git unstage

Use `git unstage` to reset the staging area. Do not pass any options.

```bash
git unstage
```

### git undo

Use `git undo` to undo the last commit. Do not pass any options.

```bash
git undo
```

### git stash

Do not use shorthand. Use explicit commands:

- To save changes: `git stash push` (not `git stash`)
- To restore: `git stash apply` (not `git stash pop`)

Before stashing, stage any new (untracked) files with `git add` so they are tracked; otherwise they will not be included in the stash.

```bash
git add <new-files>
git stash push -m "<message>" -- <paths>
```
