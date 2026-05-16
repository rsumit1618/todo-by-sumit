# Data Layer

The data package owns network, local database, secure storage, model mapping, and repository implementations.

## Important Files

```text
core/config/network_config.dart       Base URL, WebSocket URL, flavor, SSL fingerprints
core/app/app_http_override.dart       Dev-only certificate override
remote/api_service.dart               Retrofit REST endpoints
remote/utils/safe_api_call.dart       Network error wrapping
helper/app_local_database_helper.dart SQLite database and tables
helper/secure_storage_helper.dart     Token/preference storage helper
repository/starter_repository_impl.dart REST repository implementation
repository/task_repository_impl.dart  SQLite repository implementation
repository/live_update_repository_impl.dart REST initial live-list repository
source/starter/network                REST remote data source
source/live_update/network            Live update REST seed data source
source/task/local                     SQLite local data source
source/task/network                   Task REST data source example
```

## API Flow

```text
ApiService
-> RemoteDataSource
-> RepositoryImpl
-> domain Repository contract
-> domain UseCase
-> app ViewModel
-> UI
```

## Local DB Flow

```text
AppLocalDatabase
-> TaskLocalDataSourceImpl
-> TaskRepositoryImpl
-> TaskRepository
-> UseCase
-> ViewModel stream
-> UI
```

## Generation

Run from this `data` folder after changing Retrofit or JSON files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## SSL

Set `NetworkConfig.certificateFingerprints` per flavor. Production should use real SHA-256 certificate fingerprints and should not rely on `AppHttpOverrides`.
