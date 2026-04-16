# Config Reference

Project config lives at `.claude/flutter-golden-cycle.config.json`. Schema: [`assets/config.schema.json`](../assets/config.schema.json).

## Priority

1. `.claude/flutter-golden-cycle.config.json` (committed, team-shared).
2. Plugin `userConfig` values set at install time.
3. Built-in defaults from `config.schema.json`.

## Fields

| Field | Type | Default | Notes |
|---|---|---|---|
| `uiPackage` | string (path) | `packages/ui` | Where goldens live. Single-package projects use `.`. |
| `defaultRunApp` | string (path) | `.` | App path for Phase 4b's `flutter run`. |
| `defaultRunDevice` | enum | `chrome` | `chrome` pairs with deterministic web ports. Other values: `macos`, `linux`, `windows`, `ios`, `android`. |
| `goldenViewport.width` | number | `1440` | Logical pixels. |
| `goldenViewport.height` | number | `900` | Logical pixels. |
| `goldenTolerance` | number | `0.02` | 0.0 = strict, 0.02 = 2%. Absorbs Skia AA drift across OSes. |
| `theme.fontChoice` | enum | `system` | `system` \| `custom` \| `bundled`. |
| `theme.fontFamily` | string | — | Required when `fontChoice != "system"`. |
| `theme.fontAssetPackage` | string | — | Flutter package that owns font files (for `fontFamily: 'X', package: 'Y'` lookup). |
| `theme.fontFiles` | array | — | List of `{path, weight, style}` entries used when `fontChoice` is `custom` or `bundled`. |
| `commitScopes` | string[] | `["ui", "app"]` | Allowed Conventional Commit scopes. |
| `issueSource` | enum | `manual` | v0.1 supports only `manual`. v0.2 adds `linear`, `github`. |

## Example — single-package Flutter project, system font

```json
{
  "$schema": "https://raw.githubusercontent.com/happinessee/flutter-golden-cycle/main/assets/config.schema.json",
  "uiPackage": ".",
  "goldenViewport": { "width": 1440, "height": 900 },
  "goldenTolerance": 0.02,
  "theme": { "fontChoice": "system" }
}
```

## Example — monorepo with a ui package and custom font

```json
{
  "$schema": "https://raw.githubusercontent.com/happinessee/flutter-golden-cycle/main/assets/config.schema.json",
  "uiPackage": "packages/ui",
  "defaultRunApp": "apps/main",
  "defaultRunDevice": "chrome",
  "goldenViewport": { "width": 1920, "height": 1080 },
  "goldenTolerance": 0.02,
  "theme": {
    "fontChoice": "custom",
    "fontFamily": "Inter",
    "fontAssetPackage": "ui",
    "fontFiles": [
      { "path": "fonts/Inter-Regular.ttf", "weight": 400 },
      { "path": "fonts/Inter-Medium.ttf", "weight": 500 },
      { "path": "fonts/Inter-Bold.ttf", "weight": 700 }
    ]
  },
  "commitScopes": ["ui", "app", "core", "data"]
}
```

## Tolerance choice

Lower tolerance catches more regressions but produces more cross-OS flakes.

| Value | When to pick it |
|---|---|
| `0.00` | Per-platform goldens or Docker'd rendering. Deterministic CI only. |
| `0.005` (0.5%) | Single-OS CI, no gradient/shader-heavy widgets. |
| `0.02` (2%) | **Default.** Multi-OS CI with typical Material 3 widgets — absorbs Skia AA drift. |
| `> 0.02` | Smells like a regression hiding — prefer per-platform goldens instead. |
