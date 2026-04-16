# flutter-golden-cycle

> **Flutter dev cycle that treats visual output as part of the test contract.**
> Golden-test TDD · deterministic per-worktree web ports · component-reuse discipline · Figma-driven visual review.

**Language:** **English** · [한국어](README.ko.md) · [Español](README.es.md) · [简体中文](README.zh.md)

---

## Why

UI quality gates — goldens, visual review, design-system reuse — aren't optional polish. They're part of RED/GREEN. Most Flutter workflows skip them because the tooling friction is too high. This plugin makes them the default path.

## What it gives you

- **Golden-test TDD.** A `/flutter-golden-cycle-baseline` command that wraps `flutter test --update-goldens` in a dual-gate review (AI reads the PNG, user approves) before committing baselines.
- **Deterministic web ports per worktree.** Same worktree name → same `flutter run -d chrome --web-port=...` forever. Parallel feature branches stop colliding on port 8080.
- **Reuse discovery first.** The workflow grep-s your design-system package and Material 3 baselines *before* letting you hand-roll a `Container + GestureDetector`.
- **Figma visual review.** If you paste a Figma URL, the plugin freezes the design (screenshot + tokens + context) into `.figma-refs/` and runs a side-by-side checklist against your rendered goldens.
- **Self-check.** `/flutter-golden-cycle-doctor` tells you within a second whether the install is healthy.

## Quick start

```bash
# 1. Add the marketplace
/plugin marketplace add happinessee/flutter-golden-cycle

# 2. Install
/plugin install flutter-golden-cycle

# 3. Initialize your project (once)
/flutter-golden-cycle-init

# 4. Verify
/flutter-golden-cycle-doctor

# 5. Start a feature
/flutter-golden-cycle
```

See [`docs/INSTALL.md`](docs/INSTALL.md) for the manual install path (git clone).

## What gets installed

- `.claude/flutter-golden-cycle.config.json` — your project-local config (commit it for team sharing).
- `<uiPackage>/test/helpers/golden_host.dart` — `setUpGoldenFonts` / `useGoldenViewport` / `goldenHost` helpers.
- `<uiPackage>/test/flutter_test_config.dart` — cross-OS pixel-diff tolerance (default 2%).
- Entries appended to `.gitignore` for per-worktree artifacts (`.figma-refs/`, `.web-port`, etc.).

Files added to your project stay there even if you uninstall the plugin — they're yours.

## Requirements

- Flutter SDK ≥ `3.16.0`.
- Git ≥ `2.5` (for worktree support).
- macOS, Linux, or Windows (PowerShell or WSL).

**Optional peers:**
- `figma` plugin — enables the Figma visual-review phase. Without it, the workflow just skips that phase.
- `superpowers` bundle — the skill inlines the patterns it uses (git worktree, TDD, verification, code review), so installing superpowers is for parity, not necessity.

## Docs

| Doc | Purpose |
|---|---|
| [`docs/INSTALL.md`](docs/INSTALL.md) | Marketplace vs git-clone installation |
| [`docs/CONFIG.md`](docs/CONFIG.md) | Config schema reference |
| [`docs/FIGMA_SETUP.md`](docs/FIGMA_SETUP.md) | Wiring up the Figma MCP plugin + `.figma-refs/` sharing |
| [`docs/TROUBLESHOOTING.md`](docs/TROUBLESHOOTING.md) | Windows shasum, port collisions, first-golden red, etc. |
| [`docs/MIGRATION.md`](docs/MIGRATION.md) | Version-to-version config changes |

## Commands

| Command | What it does |
|---|---|
| `/flutter-golden-cycle` | Run the full 7-phase cycle |
| `/flutter-golden-cycle-init` | Generate config + install helpers (idempotent) |
| `/flutter-golden-cycle-baseline` | Dual-gate `--update-goldens` wrapper |
| `/flutter-golden-cycle-doctor` | Health check (11 items) |
| `/flutter-golden-cycle-cleanup` | Recover from interrupted workflows |

## Status

**v0.1 — MVP.** Manual issue source only (Linear/GitHub adapters arrive in v0.2). Widgetbook-based UI gate and dark-mode/locale golden matrices are also deferred. See [`CHANGELOG.md`](CHANGELOG.md).

## Attribution

Generalized from a private Flutter monorepo skill. Inspired by the Claude Code `superpowers` bundle, but depends on none of it at runtime.

## License

MIT — see [`LICENSE`](LICENSE).
