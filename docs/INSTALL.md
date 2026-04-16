# Install

Two ways to install the plugin. Use the marketplace path unless you need to hack on the plugin itself.

## Marketplace (recommended)

```bash
/plugin marketplace add happinessee/flutter-golden-cycle
/plugin install flutter-golden-cycle
```

Claude Code handles versioning and updates. Run `/plugin update` to pull new releases.

## Git clone (for plugin development)

```bash
git clone https://github.com/happinessee/flutter-golden-cycle.git ~/src/flutter-golden-cycle
claude --plugin-dir ~/src/flutter-golden-cycle
# In the session:
/plugin install flutter-golden-cycle
```

This loads the plugin from your checkout, so edits are picked up on next session start.

## First-time setup in a project

Once the plugin is installed:

```
cd <your-flutter-project>
/flutter-golden-cycle-init
/flutter-golden-cycle-doctor
```

`init` writes `.claude/flutter-golden-cycle.config.json` and installs the golden helpers into your UI package. `doctor` verifies the install. Commit both.

## Uninstall

```bash
/plugin uninstall flutter-golden-cycle
```

Files installed into your project (`golden_host.dart`, `flutter_test_config.dart`, config) are left in place — they're your code now. Remove them by hand if you want a clean slate.
