# Dependency Injection Rules

## Provider Locations

- Network providers: `data/lib/di/network_di.dart`
- Firebase providers: add `data/lib/di/firebase_di.dart` only when a real Firebase feature is requested.
- Local providers: `data/lib/di/local_di.dart`
- Data source providers: keep close to `network_di.dart`, `local_di.dart`, or a dedicated data source DI file when the project grows.
- Repository providers: `data/lib/di/repository_di.dart`
- Use case providers: `lib/di/usecase_provider/usecase_provider.dart`
- View model providers: `lib/di/view_model_provider/<feature>`

## Provider Style

- Use Riverpod `Provider` for services, data sources, repositories, and use cases.
- Use `ChangeNotifierProvider.autoDispose` for screen view models.
- Keep provider names explicit: `<feature>RepositoryProvider`, `<action>UseCaseProvider`, `<feature>ViewModelProvider`.

## Startup Overrides

- `appLocalDatabaseProvider` must be overridden in `main()` after `AppLocalDatabase.create()`.
- Tests that render app routes using local DB must also override `appLocalDatabaseProvider`.

## Lazy Dependencies

- If optional remote/Firebase services are not needed for local screens, do not read those providers during local screen construction.
- Prefer passing `() => ref.read(remoteProvider)` callbacks where remote work is optional.

## Do Not

- Do not create repositories in view models manually.
- Do not create use cases in widgets.
- Do not make global singletons when an existing provider can supply the dependency.
