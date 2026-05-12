# Routing, Flavor, and Firebase Rules

## Routing

- Route constants live in `lib/main/navigation/route_path.dart`.
- Route construction lives in `lib/main/navigation/app_router.dart`.
- `MaterialApp.initialRoute` should use a route constant.
- Do not hardcode route strings in widgets.

## Android Flavors

The package ids are:

- dev: `com.sr.todo.dev`
- uat: `com.sr.todo.uat`
- prod: `com.sr.todo`

Rules:

- Android `namespace` stays `com.sr.todo`.
- Base `applicationId` stays `com.sr.todo`.
- `dev` uses `applicationIdSuffix ".dev"`.
- `uat` uses `applicationIdSuffix ".uat"`.
- `prod` has no suffix.
- `MainActivity.kt` package declaration stays `com.sr.todo`.

## iOS Bundle Identifiers

The bundle identifiers are:

- dev: `com.sr.todo.dev`
- uat: `com.sr.todo.uat`
- prod: `com.sr.todo`

Rules:

- Keep matching Xcode schemes: `dev`, `uat`, `prod`.
- Keep matching build configurations: `Debug-dev`, `Release-dev`, `Profile-dev`, etc.

## Firebase

- All environments currently use the same Firebase project.
- Android flavor-specific `google-services.json` files live in:
  - `android/app/src/dev/google-services.json`
  - `android/app/src/uat/google-services.json`
  - `android/app/src/prod/google-services.json`
- Do not keep a root `android/app/google-services.json` if it contains unrelated package clients.
- Flutter Firebase options live in `lib/firebase_options.dart`.
- Initialize Firebase before using Auth/Firestore.
- Guest/local-only flows should not require Firebase initialization.
