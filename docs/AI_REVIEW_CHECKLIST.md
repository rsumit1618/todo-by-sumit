# AI Review Checklist

Use this checklist before accepting AI-generated code.

## Architecture

- Does each screen use `Page -> PageView -> PageViewModel`?
- Does the view model call use cases only?
- Does domain avoid importing `data` or app `lib`?
- Do repositories implement domain contracts?
- Are data sources the only classes calling Retrofit, SQLite, or storage?

## UI

- Is every visible string localized?
- Are colors from `AppColors` or theme?
- Is reusable UI placed under `lib/ui/components`?
- Are screen widgets free of business logic?
- Is loading state shown from `loadingStream` or feature state?

## API

- Is the endpoint declared in `ApiService`?
- Is there a data source wrapping `ApiService`?
- Does the repository use `safeApiCall`?
- Are DTOs mapped to domain entities?
- Did generated files need updating?

## Local DB

- Is the table declared in `AppLocalDatabase`?
- Are SQL queries inside a local data source?
- Are local models mapped to domain entities?
- Are expected failures returned as `LocalError`?

## Security

- Are passwords never persisted?
- Are tokens stored only with secure storage?
- Is SSL pinning preserved for non-dev flavors?
- Is dev-only certificate override not used for production?

## Cleanup

- No unused demo/example imports.
- No duplicate architecture style.
- No product-specific names in shared/base code.
- README or docs updated when workflow changed.

