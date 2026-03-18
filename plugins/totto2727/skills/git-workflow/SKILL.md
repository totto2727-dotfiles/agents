---
name: git-workflow
description: >-
  MUST ALWAYS be loaded before executing ANY git command (commit, add, stash,
  push, pull, checkout, merge, rebase, reset, rm, diff, log, etc.). Covers
  Conventional Commits with GPG signing, staging/unstaging/stash rules, safe
  file deletion via git stash, multi-branch PR splitting, and command execution
  discipline. If the task involves git in any way, load this skill first.
context: fork
---

# Git Workflow

This is a unified git workflow skill that combines commit rules, operations rules, file deletion rules, and branch-split workflows into a single reference. It MUST ALWAYS be applied when performing any git operations.

## Decision Flow

When performing git operations, determine which reference applies:

### "I need to create a commit"

Follow [references/commit-rules.md](references/commit-rules.md):

- Analyze changes with `git status`, `git diff`, `git diff --staged`
- Detect commit message language from `git log --oneline -10`
- Group related changes into granular commits
- Use Conventional Commits format: `type(scope): description`
- GPG signing is required (see below)

### "I need to stage, unstage, undo, or stash"

Follow [references/operations-rules.md](references/operations-rules.md):

- Use `git unstage` (no options) to reset staging area
- Use `git undo` (no options) to undo the last commit
- Use `git stash push` (not shorthand `git stash`) to save changes
- Use `git stash apply` (not `git stash pop`) to restore
- Do not use `git -C <path>`

### "I need to delete files"

Follow [references/file-deletion-rules.md](references/file-deletion-rules.md):

- NEVER use `rm` or `unlink` directly
- ALWAYS stash files before deletion to preserve them
- For tracked files: `git stash push` then `git rm`
- For untracked files: `git add` then `git stash push`
- Before performing destructive file operations, confirm the target files with the user if the scope is large (>5 files)

### "I need to split work into multiple branches and PRs"

Follow [references/branch-split-workflow.md](references/branch-split-workflow.md) and use [assets/plan-template.md](assets/plan-template.md):

- Create a plan analyzing file dependencies
- Execute per-branch workflow: stage all, stash, switch, apply, unstage, selective add, commit
- Push and create PRs for each branch
- Present PR URL list when complete

## Universal Rules

These rules apply to ALL git operations without exception:

### GPG Signing (Required)

All commits must be GPG-signed. Never use `--no-gpg-sign` or disable signing. The user may override this requirement explicitly if needed.

If a GPG signing error or hang occurs:

1. Report the error message and current state
2. Request user guidance on how to proceed
3. Do not attempt workarounds or unsigned commits unless the user instructs otherwise

### Conventional Commits Format

Use format: `type(scope): description`

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `build`, `ci`, `perf`

**Scope**: Optional, indicates what is being modified (e.g., `auth`, `cart`)

**Description**: Concise, present tense, lowercase (except proper nouns)

### Language Detection

Analyze recent commit messages from `git log --oneline -10` to determine the language pattern used in the repository. Follow the same language for new commit messages.

### Prohibited Commands

- **`git reset` is prohibited** — use `git unstage` or `git undo` instead (see [references/operations-rules.md](references/operations-rules.md))

### Staging Operations

- Use `git unstage` to reset the staging area (no options)
- Use `git undo` to undo the last commit (no options)
- Use `git stash push -m "<message>"` to save changes (never shorthand)
- Use `git stash apply` to restore (never `git stash pop`)
- Do not use `git -C <path>` — always work from the repository directory

### File Deletion Safety

- Never use `rm`, `unlink`, or any direct file deletion
- Always use git stash to preserve files before deletion
- Before performing destructive file operations on a large scope (>5 files), confirm the target files with the user

### Error Handling

- On conflicts, push failures, or git errors: halt work, report the current state, and request instructions
- Do not attempt to resolve errors autonomously

### Command Execution

- Execute git commands one at a time — do not chain with `&&`
- Pipes (`|`) and command substitution (`$(...)`) within a single git command are allowed
- This ensures each command's exit status is verified before proceeding to the next

## Reference Files

| File                                                                       | Description                                                              |
| -------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| [references/commit-rules.md](references/commit-rules.md)                   | Commit creation workflow, granularity rules, Conventional Commits format |
| [references/operations-rules.md](references/operations-rules.md)           | Rules for unstage, undo, stash push/apply, and git -C prohibition        |
| [references/file-deletion-rules.md](references/file-deletion-rules.md)     | File deletion via git stash, prohibited commands, deletion process       |
| [references/branch-split-workflow.md](references/branch-split-workflow.md) | Multi-branch PR splitting workflow with phases                           |
| [assets/plan-template.md](assets/plan-template.md)                         | Template for branch-split plans                                          |
