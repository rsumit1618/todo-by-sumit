# Data Layer Rules

## Purpose

The `data` package implements storage, network, mapping, and repository contracts.

## Models

- Local database models live under `data/lib/models/local`.
- Remote/API DTOs live under `data/lib/models/remote`.
- DTOs may use `json_annotation`.
- DTOs must map to and from domain entities.
- Never return DTOs from domain repository contracts.

## Data Sources

- Data source interfaces live under `data/lib/source/<feature>/<type>`.
- Implementations should be named `<Feature><Type>DataSourceImpl`.
- Local data sources handle SQLite.
- Remote/network data sources handle REST/Dio/Retrofit.
- Firebase data sources should be added only when a real Firebase feature is requested.

## SQLite

- SQLite setup belongs in `AppLocalDatabase`.
- Tables should be created in `AppLocalDatabase.create()`.
- Use local data sources for queries and writes.
- Do not open database connections in view models or widgets.

## Firebase

- Firebase repository/database code is not part of the active starter.
- Keep `google-services.json` and `firebase_options.dart` only as placeholders.
- Add Firebase Auth, Firestore, Analytics, Messaging, or Storage code only when requested.
- Firebase calls must live in data sources or services, never in widgets or view models.

## REST

- REST endpoints belong in `ApiService`.
- Network data sources wrap `ApiService`.
- Repositories decide whether REST is currently used.
- If REST is prepared for future use, do not call it from active flows until the feature requires it.
