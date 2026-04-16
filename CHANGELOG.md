# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - TBD

### Added
- Initial public release.
- 7-phase workflow (Issue → Worktree → Figma Context → Reuse → TDD → Review Gate → PR → Completion).
- Deterministic per-worktree web port allocation (`scripts/worktree-port.sh` + PowerShell variant).
- Golden test helper templates (`assets/golden_host.dart.tmpl`, `assets/flutter_test_config.dart.tmpl`).
- Figma MCP integration with runtime tool-name resolution and graceful fallback when absent.
- Hybrid config: `plugin.json` `userConfig` prompts at install time; `.claude/flutter-golden-cycle.config.json` overrides for team sharing.
- Four slash commands: `init`, `baseline`, `doctor`, `cleanup`.
- Manual issue source (Linear / GitHub adapters deferred to 0.2).
- README in English (primary), Korean, Spanish, Simplified Chinese.

### Known Limitations
- No automated config-schema migration between versions.
- Uninstalling the plugin leaves user-project assets in place (intentional).
- Widgetbook-based UI gate deferred to 0.2.
- Dark-mode and locale golden variants deferred to 0.3.
