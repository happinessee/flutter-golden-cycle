# Figma Setup

The Figma integration is optional. Without it, Phase 3a-0 (design-context capture) is silently skipped and the rest of the workflow runs unchanged.

## Prerequisites

Install the Figma MCP plugin in Claude Code — this is a separate plugin, not part of `flutter-golden-cycle`:

```bash
/plugin install figma
```

Then authenticate it per the Figma plugin's own docs. Verify with:

```bash
/flutter-golden-cycle-doctor
# Check item #8 (Figma MCP) should show ✅.
```

## How `flutter-golden-cycle` uses it

When you (or the issue you're working on) provide a Figma URL, the workflow:

1. **Resolves the Figma MCP tool names at runtime.** We don't hardcode them — different Figma plugin builds use different identifiers. The skill calls `ToolSearch` to find them.
2. **Freezes the design context** by pulling three artifacts and writing them under `.claude/worktrees/<branch>/.figma-refs/`:

   | File | Tool | Used by |
   |---|---|---|
   | `screenshot.png` | `get_screenshot` | Phase 4b AI visual check (side-by-side with rendered goldens) |
   | `design-context.json` | `get_design_context` | Phase 3a reuse discovery + Phase 3b golden planning |
   | `tokens.json` | `get_variable_defs` | Phase 4a token-drift check |
   | `node-url.txt` | trigger URL | PR body |

3. **Does NOT generate Flutter code** from these artifacts. They're the intent spec; implementation still goes through Phase 3a reuse discovery first. **1:1 visual fidelity ≠ 1:1 code duplication.**

## Sharing `.figma-refs/` with your team

By default `/flutter-golden-cycle-init` adds `.figma-refs/` to `.gitignore`. This is the safe default because:
- Pre-release designs may be confidential.
- Screenshots can balloon repo size.
- Designers may update the source Figma, making committed screenshots stale.

If your team **does** want reviewers to see the Figma source alongside the PR, override per-PR by force-adding:

```bash
git add -f .claude/worktrees/<branch>/.figma-refs/screenshot.png
```

Or, to allow-list screenshots repo-wide, add an exception after the ignore rule:

```gitignore
.figma-refs/
!.figma-refs/screenshot.png
```

## Troubleshooting

| Symptom | Fix |
|---|---|
| `ToolSearch("figma screenshot")` returns 0 results | Figma plugin not installed or loaded with a different identifier. Run `/plugin list` and adjust the search query, or reinstall. |
| Phase 3a-0 runs but `screenshot.png` is empty | Check authentication: run the Figma plugin's own doctor / whoami command. |
| Figma node id not recognized | The URL must be a `figma.com/design/...` link; Figma Make / FigJam have separate flows. See the main SKILL.md for URL parsing rules. |
