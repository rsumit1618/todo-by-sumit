# Domain Layer Rules

## Purpose

The `domain` package is the pure business layer. It should stay independent from Flutter, Firebase, Dio, SQLite, Retrofit, Riverpod, and platform APIs.

## Entities

- Entities live in `domain/lib/entities`.
- Entities should be plain Dart classes.
- Entities should not contain JSON, Firestore, SQLite, or UI annotations.
- Use `copyWith` when mutation-like behavior is needed.

## Repository Contracts

- Repository contracts live in `domain/lib/repository`.
- Contracts describe what the app needs, not how data is fetched.
- Return `Future<Either<ErrorType, ResultType>>` for async operations that can fail.
- Use domain entities in signatures.
- Do not expose DTOs, database rows, `Response`, `DocumentSnapshot`, or `UserCredential`.

## Use Cases

- Use cases live in `domain/lib/usecase`.
- Use cases extend `BaseUseCase<E, P, T>` when they perform async operations.
- Params classes extend `Params` and implement `verify()`.
- Use cases depend on repository interfaces only.
- Use cases may assemble domain entities from primitive inputs.

## Auth Rules

- Domain auth exposes `AuthUserEntity`, not Firebase `User`.
- Login/register/google sign-in contracts belong in `AuthRepository`.
- Sync use cases should take a user id or domain auth entity, not a Firebase user object.
