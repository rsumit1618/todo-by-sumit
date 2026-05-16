# Current Architecture Findings

Treat this file as a cleanup backlog and project context, not as required
behavior for new features.

## Current Standard

- KickStack now uses the company `Page -> PageView -> PageViewModel` pattern.
- Firebase is configuration-only until a real Firebase feature is requested.
- Starter examples show REST, SQLite, shared provider state, and WebSocket live updates.
- Network errors are intentionally minimal and HTTP-focused.
- Shared UI lives under `lib/ui/components`.

## Watch Items

- `NetworkConfig.currentFlavor` is a compile-time constant set to `dev`; Android/iOS build flavors do not currently switch this Dart value by themselves.
- Generated localization files are maintained in the repo. If localization tooling is added later, regenerate them from `lib/l10n/intl_en.arb`.
- `BasePageViewWidget` uses a custom `ComponentElement`. This is part of the company standard and should be changed only deliberately.
- Example screens should be removed once a real project has its own production flows.

## AI Agent Notes

- Read `AGENTS.md` before changing code.
- Run generation only when generated files are affected.
- Do not run build, test, or analyze unless requested.
- Keep docs updated when architecture or setup changes.
