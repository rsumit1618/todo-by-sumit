# AI Agent Rules

Use root `AGENTS.md` as the source of truth for AI behavior.

Before editing, an AI agent must verify:

- The target layer is known.
- The company page standard is preserved.
- Localization and theme rules are followed.
- Generated files are updated only when required.
- No build/test/analyze command is run unless requested.
- No new Firebase repository/database code is added unless requested.

After editing, an AI agent must summarize:

- Files changed by layer.
- Whether generation was run.
- Whether build/test/analyze was skipped or requested.
- Any remaining manual setup.

