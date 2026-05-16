# Presentation and MVVM Rules

## Presentation Structure

Each feature screen should follow the existing pattern:

- `<feature>_page.dart`: extends `BasePage<ViewModel>`.
- `<feature>_page_view.dart`: extends `BasePageViewWidget<ViewModel>`.
- `<feature>_page_view_model.dart`: extends `BasePageViewModel`.
- `lib/di/view_model_provider/<feature>/<feature>_provider.dart`: exposes the Riverpod `ChangeNotifierProvider`.

## Page Rules

- Pages wire the provider through `provideBase()`.
- Pages may override scaffold appearance methods.
- Pages should not contain business logic.
- `onModelReady()` may trigger initial loading.

## View Rules

- Views render state and forward user actions to the view model.
- Views should not call repositories, use cases, Firebase, REST, or SQLite.
- Controllers should be disposed.
- Avoid large business branches inside widgets.

## ViewModel Rules

- View models depend on use cases, not repositories or data sources.
- View models own UI state such as loading, messages, selected input, and screen lists.
- View models should expose simple methods for UI actions.
- View models should expose streams/state consumed by the page view.
- Prefer `setLoading(event.status == Status.LOADING)` for request loading.
- Emit user-visible messages through `BasePageViewModel` UI event helpers.
- Keep optional remote/Firebase construction lazy when the screen supports local/offline mode.

## Base Classes

- `BaseViewModel` extends `ChangeNotifier`.
- `BasePageViewModel` adds loading state and a standard `UiEvent` stream.
- `BaseWidget` watches a Riverpod provider and gives the model to builders.
- `BaseStatefulPage` composes page model, scaffold, UI events, and page view.
