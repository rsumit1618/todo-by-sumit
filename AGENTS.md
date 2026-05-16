# KickStack AI Agent Rules

This file is the first document an AI agent must read before changing this
repository.

## Required Reading Order

1. `AGENTS.md`
2. `docs/ARCHITECTURE.md`
3. `.rules/README.md`
4. The README for the layer being changed:
   - `lib/README.md`
   - `domain/README.md`
   - `data/README.md`

## Non-Negotiable Rules

- Keep the company page standard: `Page -> PageView -> PageViewModel`.
- Do not introduce a second presentation architecture.
- UI text must come from localization, for example `S.of(context).login`.
- UI colors must come from `AppColors` or the app theme.
- Widgets must not call REST, SQLite, secure storage, or repositories directly.
- View models call use cases only.
- Domain must not import from `data` or app `lib`.
- Data may import from `domain`; domain must stay platform independent.
- Repositories must return `Either<BaseErrorSubtype, Result>` for expected failures.
- Do not add Firebase repository/database code unless the user explicitly asks.
- Keep Firebase config placeholders only until a real Firebase feature is requested.
- Do not add product-specific banking, payment, todo, or demo names to reusable code.
- Do not run build, test, or analyze unless the user explicitly asks.
- Run generation only when generated files are affected.

## Before Editing

An AI agent must answer these checks internally before editing:

- Which layer owns this change?
- Is the change a feature, shared UI, domain rule, data source, or app wiring?
- Does the change need localization keys?
- Does the change need generated files?
- Does the change preserve dependency direction?
- Is this code reusable company standard or app-specific feature code?

## Feature Pattern

New production features should follow this shape:

```text
lib/presentation/<feature>/<feature>_page.dart
lib/presentation/<feature>/<feature>_page_view.dart
lib/presentation/<feature>/<feature>_page_view_model.dart
lib/di/view_model_provider/<feature>/<feature>_provider.dart
domain/lib/entities/<feature>_entity.dart
domain/lib/repository/<feature>_repository.dart
domain/lib/usecase/<action>_<feature>_usecase.dart
data/lib/models/remote/<feature>/<feature>_dto.dart
data/lib/source/<feature>/network/<feature>_remote_data_source.dart
data/lib/source/<feature>/network/<feature>_remote_data_source_impl.dart
data/lib/repository/<feature>_repository_impl.dart
```

Use only the files needed for the feature. Do not create empty layers.

## Verification Checklist

Before final response, verify:

- No visible text is hardcoded in new UI.
- No colors are hardcoded in new UI.
- No widget imports repository, data source, Dio, SQLite, or secure storage.
- New APIs are added in `data/lib/remote/api_service.dart`.
- New use cases are wired in `lib/di/usecase_provider/usecase_provider.dart`.
- New view models are wired in `lib/di/view_model_provider`.
- New routes are registered in `lib/main/navigation`.
- README or docs are updated when architecture or setup changes.

