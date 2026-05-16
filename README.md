# KickStack

KickStack is a small Flutter clean architecture starter with enough real examples to begin a production app without carrying product-specific code.

It includes:

- REST API flow with Dio, Retrofit, repository, and use case
- SQLite CRUD flow with local data source and UI sync
- Shared Riverpod provider data across multiple screens
- WebSocket live-list example with delete support
- Secure storage helper
- SSL certificate pinning configuration
- Firebase config placeholders only, for later setup
- Small shared UI kit under `lib/ui/components`

Package/application id: `com.sr.kickstack`

## Layers

```text
lib/      App layer: screens, view models, routing, localization, theme, UI kit, app DI
domain/   Business layer: entities, use cases, repository contracts, errors
data/     Data layer: Retrofit APIs, Dio, SQLite, secure storage, models, repository impls
```

Dependency direction:

```text
lib -> domain
lib -> data only for dependency wiring and app bootstrapping
data -> domain
domain -> no Flutter app or data dependency
```

Layer guides:

- [Full architecture guide](docs/ARCHITECTURE.md)
- [Getting started from this starter](docs/GETTING_STARTED.md)
- [Feature guide](docs/FEATURE_GUIDE.md)
- [AI agent rules](AGENTS.md)
- [AI prompts](docs/AI_PROMPTS.md)
- [AI review checklist](docs/AI_REVIEW_CHECKLIST.md)
- [Architecture diagrams](docs/DIAGRAMS.md)
- [App layer](lib/README.md)
- [Domain layer](domain/README.md)
- [Data layer](data/README.md)

## AI-Assisted Development

Before using any AI coding tool with this project, point it to:

```text
AGENTS.md
docs/ARCHITECTURE.md
.rules/README.md
```

The agent must verify the rules before changing code. Prompt templates are in
`docs/AI_PROMPTS.md`.

## Starter Screens

- Splash menu: `lib/presentation/splash`
- REST API example: `lib/presentation/rest_api_example`
- SQLite example: `lib/presentation/sqlite_example`
- Shared provider example: `lib/presentation/shared_provider_example`
- WebSocket live updates: `lib/presentation/websocket_example`

## API Paths

Current starter endpoints are defined in `data/lib/remote/api_service.dart`:

```text
POST   /api/v1/dashboard/summary
GET    /api/v1/profile
GET    /api/v1/catalog/products
POST   /api/v1/auth/login
GET    /api/v1/tasks
POST   /api/v1/tasks
PUT    /api/v1/tasks/{id}
DELETE /api/v1/tasks/{id}
GET    /api/v1/live-updates
WS     /ws/v1/live-updates
```

Set the backend host in `data/lib/core/config/network_config.dart`.

## Generation

After editing Retrofit or JSON models in `data/`, run only this from the `data` folder:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## SSL

Configure SSL and certificate pinning in:

- `data/lib/core/config/network_config.dart`
- `data/lib/di/network_di.dart`
- `data/lib/core/app/app_http_override.dart`

Keep bad-certificate overrides limited to local/dev. Replace the placeholder SHA-256 fingerprints before production.
