# Clean Architecture Rules

## Layer Direction

- `domain` must not import from `data` or app `lib`.
- `data` may import from `domain`.
- `lib` presentation may import from `domain` and DI providers exposed by `data`.
- Business rules belong in `domain/usecase`, not in Flutter widgets.
- Platform, SQLite, REST, secure storage, and plugin calls belong in `data`, not `domain`.
- Firebase code should remain configuration-only unless a real Firebase feature is requested.

## Feature Slice Pattern

For a new feature, add matching files by layer:

- `domain/lib/entities/<feature>_entity.dart`
- `domain/lib/repository/<feature>_repository.dart`
- `domain/lib/usecase/<action>_<feature>_usecase.dart`
- `data/lib/models/...`
- `data/lib/source/<feature>/<local|remote|network>/...`
- `data/lib/repository/<feature>_repository_impl.dart`
- `lib/di/view_model_provider/<feature>/...`
- `lib/presentation/<feature>/...`

## Error Flow

- Repository methods should return `Either<BaseErrorSubtype, T>`.
- Use `LocalError` for SQLite/local database failures.
- Use `LocalStorageError` for secure storage failures.
- Use `NetworkError` for REST/auth/network failures.
- Do not throw from repositories for expected failures.

## Do Not

- Do not call REST/Firebase/SQLite directly from widgets.
- Do not import data models into `domain`.
- Do not place UI state inside repositories.
- Do not create a second architecture style for new features.
- Do not add Firebase repositories, Firestore data sources, or push notification code unless requested.
