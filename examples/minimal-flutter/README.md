# minimal-flutter example

A single-package Flutter project used as a CI fixture and a reference for how a project looks **after** running `/flutter-golden-cycle-init`.

## What CI does with this

1. Simulates `/flutter-golden-cycle-init` by rendering the `assets/*.tmpl` templates into `test/helpers/golden_host.dart` and `test/flutter_test_config.dart` with these config values:
   - `uiPackage: "."`
   - `goldenViewport: { width: 1440, height: 900 }`
   - `goldenTolerance: 0.02`
   - `theme.fontChoice: "system"`
2. Runs `flutter analyze --fatal-infos` on the rendered project.
3. Runs `flutter test` with the two `expectLater(... matchesGoldenFile ...)` assertions marked `skip: true` until baselines land.

## Using this locally

```sh
cd examples/minimal-flutter
flutter pub get
# From the repo root, render templates (manual for now; /flutter-golden-cycle-init in a real session):
# (see .github/workflows/ci.yml for the exact commands)
flutter analyze
flutter test
```
