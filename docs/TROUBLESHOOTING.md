# Troubleshooting

## Port allocation

### `port-script says 'neither shasum nor sha256sum is available'`

Windows native shells don't ship either. Use:

- The PowerShell variant: `pwsh scripts/worktree-port.ps1 <name>`.
- Or WSL: all POSIX tools, including `sha256sum`, work under WSL.

### Two worktrees collide on the same port

The hash bucket is 100 slots wide, so ~20% chance of collision at 10 simultaneous worktrees (birthday paradox). When Phase 2 detects a conflict:

```
Port 8139 already in use. Another worktree may be hashing to the same slot.
Rename this branch or run /flutter-golden-cycle-cleanup to free ports.
```

Rename the branch — the new name will hash to a different bucket.

### I need more than 100 slots

Edit `PORT_FLOOR` / `BUCKETS` in both `scripts/worktree-port.sh` and `scripts/worktree-port.ps1`. **They must match.** Consider the trade-off: higher `BUCKETS` reduces collision probability but eats into ports used by other dev servers.

## Goldens

### First test of a new widget fails red

That's expected — there's no baseline yet. Run:

```bash
/flutter-golden-cycle-baseline <path-to-test-file>
```

It runs `--update-goldens` under the uiPackage, previews the PNGs, asks for your approval, and commits the approved baselines. Never run `flutter test --update-goldens` by hand — the dual-gate protects you from freezing a regression.

### Goldens pass on macOS but fail on Linux CI

Skia anti-aliasing drifts across OSes. The default tolerance is 2%, which covers most Material 3 widgets. If you're still seeing failures:

1. Check which pixel bucket is drifting — `flutter_test_config.dart` logs every tolerated diff.
2. If the drift is localized to one widget (gradients / shaders / text shadows), switch that one to per-platform goldens rather than raising the global tolerance.
3. Raising `goldenTolerance` above 2% hides real regressions. Don't.

### `matchesGoldenFile` path is wrong

Golden paths are relative to the test file, not the project root. The example in `examples/minimal-flutter/test/widgets/primary_button_test.dart` uses `../goldens/primary_button/default.png` — that's `test/goldens/...` from the test file's point of view.

## Figma

See [`FIGMA_SETUP.md`](FIGMA_SETUP.md).

## Config / Install

### `doctor` says the config is missing

Run `/flutter-golden-cycle-init`. If the project was previously initialized, it may have been on a different branch — check `.claude/` is not in your `.gitignore`.

### `init` overwrote my custom `golden_host.dart`

It shouldn't — default is `--skip-existing`. If you ran with `--force`, look for `golden_host.dart.bak.<timestamp>` next to it.

### Plugin version mismatch

`CHANGELOG.md` lists breaking changes. For upgrades across schema-changing versions, see [`MIGRATION.md`](MIGRATION.md).

## Uninstall

Removing the plugin does **not** remove files from your project. `golden_host.dart`, `flutter_test_config.dart`, and `.claude/flutter-golden-cycle.config.json` stay because they're yours. Delete by hand if you want a clean slate.
