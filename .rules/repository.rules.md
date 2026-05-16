# Repository Rules

## Domain Contracts

- Repository interfaces live in `domain/lib/repository`.
- Repository implementations live in `data/lib/repository`.
- Implementations must implement a domain repository interface.

## Responsibilities

Repositories may:

- Choose between local, remote, and network data sources.
- Map DTOs/local models to domain entities.
- Convert exceptions to `Either` errors.
- Coordinate sync behavior.

Repositories must not:

- Hold widget state.
- Know about routes, pages, or controllers.
- Return Firebase/Dio/SQLite-specific types.
- Throw expected data errors.

## Offline-First KickStack Rules

- Guest KickStack CRUD uses local SQLite.
- Firestore must not be constructed or called for guest-only local reads.
- Sync requires a logged-in user id.
- Local records should be marked unsynced after local edits.
- Sync should upload local KickStacks, then refresh local storage from Firestore.

## Lazy Provider Rule

If a repository supports both local and Firebase/remote behavior, remote providers should be lazy when possible. This prevents guest/offline flows from failing because Firebase is not initialized yet.
