# AI Prompts

Use these prompts with an AI coding agent. Keep prompts short and specific.

## Required Prefix

Add this before any implementation prompt:

```text
Read AGENTS.md, docs/ARCHITECTURE.md, and the relevant layer README files before editing. Follow the company Page -> PageView -> PageViewModel standard. Do not run build, test, or analyze unless I explicitly ask. Run generation only if generated files are affected.
```

## Add A New REST API

```text
Add a new REST API for <feature/action>. Endpoint: <METHOD> <PATH>. Request fields: <fields>. Response fields: <fields>. Follow KickStack clean architecture: ApiService, remote data source, repository impl, domain repository, use case, provider wiring, and view model call. Use localization for visible text and AppColors/theme for colors.
```

## Add Registration Flow

```text
Add a production registration flow. Fields: full name, email, password, confirm password. Endpoint: POST /api/v1/auth/register. Use Page, PageView, PageViewModel. Validate input in RegisterUserUseCaseParam.verify(). Add DTOs, AuthRepository contract/impl, AuthRemoteDataSource, RegisterUserUseCase, provider wiring, route, and localization. Do not store password. Store auth token only through secure storage if returned.
```

## Add Login Flow

```text
Add a production login flow. Endpoint: POST /api/v1/auth/login. Fields: email and password. Use company architecture and RequestManager. Add localized labels/errors. Store returned access token with SecureStorageHelper. Do not call ApiService directly from UI or view model.
```

## Add SQLite Feature

```text
Add a local SQLite feature named <feature>. It needs create, read, update, delete. Add entity, repository contract, use cases, local model, local data source, repository impl, DI providers, and a screen using AppStreamBuilder. Add table creation in AppLocalDatabase. Use localization for all visible text.
```

## Add WebSocket Feature

```text
Add a WebSocket live update feature for <feature>. Initial data comes from REST endpoint <METHOD> <PATH>. Live updates come from <WS_PATH>. Support upsert and delete events. Keep socket handling in view model or a dedicated service/data source, not in widgets. Use smooth list updates and localized text.
```

## Remove Starter Examples

```text
Remove KickStack starter example screens now that real features exist. Delete REST API, SQLite, shared provider, and WebSocket example presentation/provider files. Clean routes, splash buttons, example use cases, example repositories, example DTOs, example data sources, and localization keys. Keep base architecture, shared UI, network config, secure storage, SSL config, and Firebase placeholders.
```

## Code Review Prompt

```text
Review this change against AGENTS.md and docs/ARCHITECTURE.md. Focus on layer violations, hardcoded text/colors, missing localization, missing DI wiring, direct API/database calls from UI, incorrect loading/error handling, generated-file needs, and missing documentation.
```

