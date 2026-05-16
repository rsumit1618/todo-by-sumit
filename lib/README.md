# App Layer

The app layer contains Flutter UI, page view models, route wiring, localization, theme, and shared UI widgets.

## Where To Start

```text
presentation/splash                  Starter menu
presentation/rest_api_example        REST API call from UI through use case
presentation/sqlite_example          SQLite CRUD and UI stream sync
presentation/shared_provider_example Provider data shared across screens
presentation/websocket_example       REST seed plus WebSocket live list updates
main/navigation                      Route names and route builder
di/usecase_provider                  App-level use case providers
di/view_model_provider               Screen view model providers
ui/atoms                             Small primitives such as text, icon, loader, divider
ui/components/buttons                Shared action buttons
ui/components/forms                  Text fields, dropdowns, checkboxes, formatters
ui/components/feedback               Info, success, warning, and error banners
ui/components/layout                 Keyboard/text-scaling wrappers
ui/components/lists                  Generic list helpers
ui/components/overlays               Dialogs and bottom sheets
ui/components/streams                AppStreamBuilder and stream listeners
ui/components/surfaces               Card-style containers
```

## UI Rules

- Use `S.of(context)` for visible text.
- Use `AppColors` or theme values for colors.
- Keep screen logic in view models.
- Use `AppStreamBuilder` for stream-driven UI examples.
- Put reusable controls under `ui/components/`, not inside feature folders.

## Adding A Screen

1. Add `feature_name_page.dart`, `feature_name_page_view.dart`, and `feature_name_page_view_model.dart` under `presentation/feature_name`.
2. Add a provider under `di/view_model_provider/feature_name`.
3. Add a route in `main/navigation/route_path.dart` and `app_router.dart`.
4. Add all visible text to `lib/l10n/intl_en.arb` and generated localization files.
