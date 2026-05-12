# Data Layer Rules

## Purpose

The `data` package implements storage, network, Firebase, mapping, and repository contracts.

## Models

- Local database models live under `data/lib/models/local`.
- Remote/API/Firestore DTOs live under `data/lib/models/remote`.
- DTOs may use `json_annotation`.
- DTOs must map to and from domain entities.
- Never return DTOs from domain repository contracts.

## Data Sources

- Data source interfaces live under `data/lib/source/<feature>/<type>`.
- Implementations should be named `<Feature><Type>DataSourceImpl`.
- Local data sources handle SQLite.
- Remote data sources handle Firestore/Firebase.
- Network data sources handle REST/Dio/Retrofit.

## SQLite

- SQLite setup belongs in `AppLocalDatabase`.
- Tables should be created in `AppLocalDatabase.create()`.
- Use local data sources for queries and writes.
- Do not open database connections in view models or widgets.

## Firestore

- Firestore calls belong in Firestore data sources or services.
- Keep collection paths centralized in the Firestore data source.
- The same Firebase project may be used for all flavors, but app ids and bundle ids must still match each flavor.

## REST

- REST endpoints belong in `ApiService`.
- Network data sources wrap `ApiService`.
- Repositories decide whether REST is currently used.
- If REST is prepared for future use, do not call it from active flows until the feature requires it.
