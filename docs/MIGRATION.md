# Migration

This file lists every schema-visible change in the project config between released versions. Automatic migration tooling is planned for v0.2; until then, migrate by hand from the notes below.

## v0.1.0 (initial release)

Nothing to migrate.

The config schema is captured in [`assets/config.schema.json`](../assets/config.schema.json). Reference it from your config via the `$schema` field for editor completion:

```json
{
  "$schema": "https://raw.githubusercontent.com/happinessee/flutter-golden-cycle/main/assets/config.schema.json"
}
```

## Planned — v0.2.x

Expected additions (backwards-compatible):

- `issueSource` gains `"linear"` and `"github"` options.
- New optional `linear.teamId` and `github.repo` sub-objects for adapter configuration.
- New optional `catalog.app` for Widgetbook-backed Phase 4b.

Existing v0.1 configs will continue to work unchanged.

## Planned — v0.3.x (tentative)

Expected additions:

- `golden.variants` matrix (theme × locale) so dark mode / i18n snapshots have first-class support.

This may change the shape of `test/goldens/<widget>/...` paths. Migration will be documented here before release.
