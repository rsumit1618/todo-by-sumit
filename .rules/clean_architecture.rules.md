# Clean Architecture Rules

## Layer Direction

- `domain` must not import from `data` or app `lib`.
- `data` may import from `domain`.
- `lib` presentation may import from `domain` and DI providers exposed by `data`.
- Business rules belong in `domain/usecase`, not in Flutter widgets.
- Platform, Firebase, SQLite, REST, and plugin calls belong in `data`, not `domain`.

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
- Use `NetworkError` for REST/Firebase/Firestore/auth failures.
- Do not throw from repositories for expected failures.

## Do Not

- Do not call REST/Firebase/SQLite directly from widgets.
- Do not import data models into `domain`.
- Do not place UI state inside repositories.
- Do not create a second architecture style for new features.
