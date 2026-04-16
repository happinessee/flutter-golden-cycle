---
description: Recover from interrupted flutter-golden-cycle workflows — kill dangling flutter run processes, prune stale worktrees, and free their ports.
argument-hint: "[--dry-run]"
---

# /flutter-golden-cycle-cleanup

Finds leftovers from interrupted sessions and cleans them up with user confirmation. Safe by default — `--dry-run` lists what would happen without touching anything.

## What it finds

1. **Worktrees under `.claude/worktrees/`** whose branch no longer exists (merged + branch deleted, or manually removed).
2. **`.flutter-run.pid` files** pointing to processes that may still be alive.
3. **Ports from `.web-port` files** that are still in `LISTEN` state.
4. **`.figma-refs/` folders** larger than 50 MB (oversized cache).

## Flow

1. **Enumerate** — list candidates from each category. Skip if nothing found.
2. **Present plan** — show the user a numbered list of proposed actions. Use `AskUserQuestion` to confirm (multiSelect):
   - *"Kill these flutter processes"*
   - *"Remove these worktrees"*
   - *"Archive large .figma-refs/"*
3. **Execute selected actions:**
   - Kill: `kill <pid> || kill -9 <pid>`, then `rm .flutter-run.pid .flutter-run.log`.
   - Worktree removal: `git worktree remove --force <path>`. Refuses if worktree has uncommitted changes unless `--force` is re-confirmed.
   - Archive: move `.figma-refs/` to `.figma-refs.archive.<timestamp>/` (user can delete later).
4. **Report** — summary of actions taken.

## --dry-run

Lists everything in step 1 + the proposed plan from step 2, then exits. No killing, no removing, no moving.

## Safety rails

- Never touches worktrees outside `.claude/worktrees/`.
- Never removes the current worktree (the one you're in).
- Never deletes `.figma-refs/` — only renames to `.archive`.
- Never force-kills a PID if the regular SIGTERM succeeds.
