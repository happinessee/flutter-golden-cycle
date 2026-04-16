---
description: Bootstrap goldens for a new or modified test file — runs flutter test --update-goldens inside the uiPackage, previews the generated PNGs, and asks for approval before committing.
argument-hint: "<test-file-path>"
---

# /flutter-golden-cycle-baseline

Wrapper around `flutter test --update-goldens` with a **dual-gate approval**: the AI reads the generated PNGs and the user approves. Required before any new golden is committed.

## Why

Running `--update-goldens` blindly is how regressions get frozen into the baseline. This command forces a review gate so what lands in `test/goldens/` is intentional.

## Flow

1. **Validate argument** — the path must exist, end in `_test.dart`, and live under `<uiPackage>/test/`.
2. **Read config** — `.claude/flutter-golden-cycle.config.json` → `uiPackage`.
3. **Snapshot pre-state** — record which PNGs currently exist under the corresponding `test/goldens/` subtree (for diff).
4. **Run update:**
   ```sh
   cd <uiPackage>
   flutter test --update-goldens <relative-test-path>
   ```
5. **Collect new/changed PNGs** — anything added or modified since step 3.
6. **AI visual review** — `Read` each PNG in the changeset. Describe what it shows in one sentence. Flag anything that looks like a regression (cropped content, missing states, text overflow, placeholder assets).
7. **User approval** — via `AskUserQuestion`:
   - *"Approve all as baseline"*
   - *"Approve some"* (follow-up: which)
   - *"Reject all — delete and restore"*
8. **Apply decision:**
   - Approve all: leave files staged, suggest `git add <uiPackage>/test/goldens && git commit -m "test(ui): add <widget> goldens baseline"`.
   - Approve some: `git checkout -- <rejected paths>` to revert; keep approved.
   - Reject all: `git checkout -- <all changed paths>` + `git clean -f <untracked new paths>`.

## Safety rails

- Refuses to run outside a worktree under `.claude/worktrees/` unless `--allow-main` is passed (prevents accidentally updating goldens on `main`).
- Refuses to run if working tree has unrelated uncommitted changes to `test/goldens/` — asks the user to stash or commit first.
- Never invokes `flutter test --update-goldens` at project root — always inside `<uiPackage>` to limit blast radius.
