# Domain Layer Rules

## Purpose

The `domain` package is the pure business layer. It should stay independent from Flutter app code, Firebase, Dio, SQLite, Retrofit, Riverpod, and platform APIs.

## Entities

- Entities live in `domain/lib/entities`.
- Entities should be plain Dart classes.
- Entities should not contain JSON, Firestore, SQLite, Retrofit, or UI annotations.
- Use `copyWith` when mutation-like behavior is needed.

## Repository Contracts

- Repository contracts live in `domain/lib/repository`.
- Contracts describe what the app needs, not how data is fetched.
- Return `Future<Either<BaseErrorSubtype, ResultType>>` for async operations that can fail.
- Use domain entities in signatures.
- Do not expose DTOs, database rows, `Response`, platform SDK objects, or plugin objects.

## Use Cases

- Use cases live in `domain/lib/usecase`.
- Use cases extend `BaseUseCase<E, P, T>` when they perform async operations.
- Params classes extend `Params` and implement `verify()`.
- Use cases depend on repository interfaces only.
- Use cases may assemble domain entities from primitive inputs.

## Auth Rules

- Domain auth should expose app-owned entities, not Firebase or plugin user objects.
- Login/register contracts belong in an auth repository contract.
- Store tokens through secure storage in `data`, not in domain.
- Add Firebase auth contracts only when Firebase auth is explicitly requested.
