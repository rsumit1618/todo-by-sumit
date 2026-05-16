# Feature Guide

This guide shows how to add production features using the company standard.

## Add A New REST API

Example: add `GET /api/v1/profile`.

1. Add API method:

```text
data/lib/remote/api_service.dart
```

2. Add remote data source:

```text
data/lib/source/profile/network/profile_remote_data_source.dart
data/lib/source/profile/network/profile_remote_data_source_impl.dart
```

3. Add DTO:

```text
data/lib/models/remote/profile/profile_dto.dart
```

4. Add domain entity and repository contract:

```text
domain/lib/entities/profile_entity.dart
domain/lib/repository/profile_repository.dart
```

5. Add repository implementation:

```text
data/lib/repository/profile_repository_impl.dart
```

6. Add use case:

```text
domain/lib/usecase/get_profile_usecase.dart
```

7. Wire providers:

```text
data/lib/di/network_di.dart
data/lib/di/repository_di.dart
lib/di/usecase_provider/usecase_provider.dart
```

8. Call the use case from the view model.

9. Run generation from `data/` if Retrofit/JSON files changed.

## Add A Registration Flow

Recommended feature folder:

```text
lib/presentation/registration
```

Presentation files:

```text
registration_page.dart
registration_page_view.dart
registration_page_view_model.dart
```

Domain files:

```text
domain/lib/entities/registration_entity.dart
domain/lib/repository/auth_repository.dart
domain/lib/usecase/register_user_usecase.dart
```

Data files:

```text
data/lib/models/remote/auth/register_user_request_dto.dart
data/lib/models/remote/auth/register_user_response_dto.dart
data/lib/source/auth/network/auth_remote_data_source.dart
data/lib/source/auth/network/auth_remote_data_source_impl.dart
data/lib/repository/auth_repository_impl.dart
```

Provider files:

```text
lib/di/view_model_provider/registration/registration_provider.dart
```

Routing files:

```text
lib/main/navigation/route_path.dart
lib/main/navigation/app_router.dart
```

Localization:

```text
lib/l10n/intl_en.arb
lib/generated/l10n.dart
lib/generated/intl/messages_en.dart
```

Registration rules:

- Validate input in `RegisterUserUseCaseParam.verify()`.
- Keep password visibility and form state in the view model.
- Never call `ApiService` from the view model.
- Never store password in local DB or secure storage.
- Store only tokens/session values through secure storage after successful auth.
- Use localized labels, hints, errors, and button text.

## Add SQLite Local Feature

Use this structure:

```text
domain/lib/entities/<feature>_entity.dart
domain/lib/repository/<feature>_repository.dart
domain/lib/usecase/create_<feature>_usecase.dart
domain/lib/usecase/get_local_<feature>s_usecase.dart
domain/lib/usecase/update_<feature>_usecase.dart
domain/lib/usecase/delete_<feature>_usecase.dart
data/lib/models/local/<feature>_local_model.dart
data/lib/source/<feature>/local/<feature>_local_data_source.dart
data/lib/source/<feature>/local/<feature>_local_data_source_impl.dart
data/lib/repository/<feature>_repository_impl.dart
```

Add tables in:

```text
data/lib/helper/app_local_database_helper.dart
```

## Add Shared Provider Flow

Use a non-autoDispose provider when multiple screens must share the same view
model instance:

```dart
final exampleViewModelProvider =
    ChangeNotifierProvider<ExamplePageViewModel>(
  (ref) => ExamplePageViewModel(...),
);
```

Use `autoDispose` when state should reset after leaving the screen.

