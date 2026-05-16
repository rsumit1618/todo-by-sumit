# Domain Layer

The domain package contains app business contracts and use cases. It should stay independent from Flutter, Dio, SQLite, and platform APIs.

## Current Examples

```text
entities/task_entity.dart                    Local task entity
repository/starter_repository.dart           REST starter contract
repository/task_repository.dart              SQLite task contract
repository/live_update_repository.dart       REST seed contract for live updates
usecase/get_dashboard_summary_usecase.dart   REST use case example
usecase/get_live_updates_usecase.dart        Live update REST seed example
usecase/create_task_usecase.dart             SQLite create example
usecase/get_local_tasks_usecase.dart         SQLite read example
usecase/update_task_usecase.dart             SQLite update example
usecase/delete_task_usecase.dart             SQLite delete example
errors/network_error.dart                    Minimal HTTP/network error mapping
```

## Adding A Use Case

1. Add or update an entity if business data is needed.
2. Add a method to a repository contract.
3. Add a use case that accepts `Params` and returns `Either<AppError, Result>`.
4. Wire the use case in the app layer provider.

Keep DTOs and local database models in `data/`; domain should expose clean business objects only.

The starter intentionally keeps domain errors small. Add feature-specific error
types only when a real feature needs them.
