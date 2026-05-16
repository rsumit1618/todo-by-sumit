# Routing, Flavor, and Firebase Placeholder Rules

## Routing

- Route constants live in `lib/main/navigation/route_path.dart`.
- Route construction lives in `lib/main/navigation/app_router.dart`.
- `MaterialApp.initialRoute` should use a route constant.
- Do not hardcode route strings in widgets.

## Android Flavors

The package ids are:

- dev: `com.sr.kickstack.dev`
- uat: `com.sr.kickstack.uat`
- prod: `com.sr.kickstack`

Rules:

- Android `namespace` stays `com.sr.kickstack`.
- Base `applicationId` stays `com.sr.kickstack`.
- `dev` uses `applicationIdSuffix ".dev"`.
- `uat` uses `applicationIdSuffix ".uat"`.
- `prod` has no suffix.
- `MainActivity.kt` package declaration stays `com.sr.kickstack`.

## iOS Bundle Identifiers

The bundle identifiers are:

- dev: `com.sr.kickstack.dev`
- uat: `com.sr.kickstack.uat`
- prod: `com.sr.kickstack`

Rules:

- Keep matching Xcode schemes: `dev`, `uat`, `prod`.
- Keep matching build configurations: `Debug-dev`, `Release-dev`, `Profile-dev`, etc.

## Firebase Placeholders

- Firebase is configuration-only in the active starter.
- Android flavor-specific `google-services.json` files live in:
  - `android/app/src/dev/google-services.json`
  - `android/app/src/uat/google-services.json`
  - `android/app/src/prod/google-services.json`
- Do not keep a root `android/app/google-services.json` if it contains unrelated package clients.
- Flutter Firebase options live in `lib/firebase_options.dart`.
- Do not add Firebase Auth, Firestore, Messaging, Storage, Analytics, or repository code unless requested.
- Initialize Firebase before using any future Firebase feature.
- Local-only flows should not require Firebase initialization.
