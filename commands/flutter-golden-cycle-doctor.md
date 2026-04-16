---
description: Self-check the flutter-golden-cycle install in this project. Reports Flutter SDK, config validity, helper presence, Figma MCP availability, and port-script usability.
---

# /flutter-golden-cycle-doctor

Runs a non-destructive environment check. No files are modified. Exits with ✅ / ⚠️ / ❌ per item and a final summary.

## Checks

| # | Check | Pass criteria | Fix hint on fail |
|---|---|---|---|
| 1 | Flutter SDK | `flutter --version` reports ≥ `3.16.0` | Upgrade Flutter. See `docs/TROUBLESHOOTING.md#flutter-sdk`. |
| 2 | Dart SDK | `dart --version` reports ≥ `3.2.0` | Bundled with Flutter — same fix as above. |
| 3 | Config file | `.claude/flutter-golden-cycle.config.json` exists and validates against `config.schema.json` | Run `/flutter-golden-cycle-init` |
| 4 | `uiPackage` path | The `uiPackage` from config resolves to an existing directory with a `pubspec.yaml` | Fix path in config or `mkdir` |
| 5 | Golden helper | `<uiPackage>/test/helpers/golden_host.dart` exists | Run `/flutter-golden-cycle-init --force` |
| 6 | Tolerance config | `<uiPackage>/test/flutter_test_config.dart` exists | Run `/flutter-golden-cycle-init --force` |
| 7 | `flutter_test` dep | `<uiPackage>/pubspec.yaml` lists `flutter_test` in `dev_dependencies` | Add to pubspec and re-run `flutter pub get` |
| 8 | Figma MCP | `ToolSearch("figma screenshot")` returns ≥ 1 result | Optional — install the `figma` plugin to enable Phase 3a-0 |
| 9 | Port script | `bash ${CLAUDE_PLUGIN_ROOT}/scripts/worktree-port.sh test` returns an integer in [8080, 8179] | Check that `shasum` or `sha256sum` is on PATH |
| 10 | Git worktree support | `git worktree --help` exits 0 | Upgrade Git to ≥ 2.5 (worktree added in 2.5) |
| 11 | `.gitignore` fragment | `.gitignore` contains the `# --- flutter-golden-cycle` marker | Re-run `/flutter-golden-cycle-init` |

## Output format

```
flutter-golden-cycle doctor — project /path/to/repo

✅  Flutter SDK  3.22.0
✅  Dart SDK     3.4.0
✅  Config       .claude/flutter-golden-cycle.config.json (schema v0.1)
✅  uiPackage    packages/ui → found
✅  Golden host  packages/ui/test/helpers/golden_host.dart
✅  Tolerance    packages/ui/test/flutter_test_config.dart (0.02)
⚠️  flutter_test dev dep missing from packages/ui/pubspec.yaml
✅  Figma MCP    figma__get_screenshot resolved
✅  Port script  → 8139 (OK)
✅  git worktree supported
✅  .gitignore marker present

Summary: 10 ✅ / 1 ⚠️ / 0 ❌
```

On ❌, exit with non-zero so CI can consume the result.
