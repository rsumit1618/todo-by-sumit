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
- Return Firebase/Dio/SQLite/plugin-specific types.
- Throw expected data errors.

## Local-First Rules

- Local CRUD uses SQLite through local data sources.
- Local records may include sync flags when a real sync feature exists.
- Sync behavior should be explicit in use cases and repositories.
- Do not construct remote/Firebase dependencies for local-only flows.

## Lazy Provider Rule

If a repository supports optional remote behavior, remote providers should be lazy when possible. This prevents local/offline flows from failing because optional services are not configured.
