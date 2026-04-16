---
description: Generate .claude/flutter-golden-cycle.config.json for this project and install golden-test helper files into the configured UI package. Idempotent — defaults to skipping existing files.
argument-hint: "[--force | --diff | --skip-existing]"
---

# /flutter-golden-cycle-init

Initializes the plugin for the current project. Reads `userConfig` values supplied at install time, collects anything still missing via `AskUserQuestion`, writes the resolved config to `.claude/flutter-golden-cycle.config.json`, and installs golden-test helpers into the configured UI package.

## Arguments

| Flag | Behavior |
|---|---|
| *(none)* or `--skip-existing` | Default. Skip target files that already exist; still (re)writes the config file. |
| `--diff` | For each conflict, show a unified diff of existing vs template and ask the user per-file. |
| `--force` | Backup existing files to `<path>.bak.<timestamp>` then overwrite. |

## Flow

### 1. Collect config

Read these values from (in priority order) (a) the existing `.claude/flutter-golden-cycle.config.json` if present, (b) `${user_config.*}` values set at install time, (c) built-in defaults. For anything still unknown, ask via `AskUserQuestion`.

<!-- TODO(user): design the exact prompt wording, question grouping, and
     option sets here. Below is a functional default set — revise for tone,
     order, and whether any question should be multi-select. The key
     decision is how much to ask up front vs. infer/default.

     Required values to end up with:
       - uiPackage (path, required)
       - defaultRunApp (path, default ".")
       - defaultRunDevice (select: chrome | macos | linux | windows)
       - goldenViewport.width / .height (number pair, default 1440x900)
       - goldenTolerance (number, default 0.02)
       - theme.fontChoice (select: bundled | custom | system)
       - theme.fontFamily (string, required if fontChoice != "system")
       - theme.fontFiles (array of {path, weight, style}, required if fontChoice != "system")
       - commitScopes (array of strings, default ["ui","app"])
-->

**Starter prompt set (feel free to replace):**

1. *"Where does your design-system package live?"* (select: `packages/ui` / `lib` (single-package) / Other)
2. *"Which device should Phase 4b's `flutter run` default to?"* (select: `chrome` (recommended) / `macos` / `linux` / `windows`)
3. *"Golden viewport — desktop 1440×900, tablet 1024×768, mobile 375×812, custom?"* (select)
4. *"Font strategy?"* (select: `system` (recommended, no extra setup) / `bundled` (pick from Inter/Pretendard) / `custom` (you provide))
5. If `custom` or `bundled`: follow-up questions for family name + file paths.

### 2. Write config file

Create `.claude/` and `.claude/flutter-golden-cycle.config.json`. Include `"$schema": "https://raw.githubusercontent.com/happinessee/flutter-golden-cycle/main/assets/config.schema.json"` as the first key so editors get completion.

### 3. Install templates

For each target, render the template from `${CLAUDE_PLUGIN_ROOT}/assets/*.tmpl`, substituting `{{placeholders}}` with resolved config values, then write to:

| Source (`assets/`) | Destination |
|---|---|
| `golden_host.dart.tmpl` | `<uiPackage>/test/helpers/golden_host.dart` |
| `flutter_test_config.dart.tmpl` | `<uiPackage>/test/flutter_test_config.dart` |

Honor the idempotency flag from arguments.

### 4. Update .gitignore

Append the contents of `${CLAUDE_PLUGIN_ROOT}/assets/gitignore.fragment` to the project's root `.gitignore` — but only if the marker `# --- flutter-golden-cycle` is not already present (detect to avoid duplicate appends on re-run).

### 5. Report

Print a summary table of what was created / skipped / backed up, and the next command to run:

> Run `/flutter-golden-cycle-doctor` to verify the install.

## Error handling

- `<uiPackage>` does not exist → fail loudly with suggested `mkdir -p <path>/test/helpers`.
- `<uiPackage>/pubspec.yaml` does not list `flutter_test` in `dev_dependencies` → warn but continue.
- Config file exists with incompatible schema version → print the diff and route the user to `docs/MIGRATION.md`.
