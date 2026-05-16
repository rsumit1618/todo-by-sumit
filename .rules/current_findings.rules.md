# Current Architecture Findings

These are existing issues or risks observed while analyzing the project. Treat this file as a cleanup backlog, not as required behavior for new features.

## High Priority

- `UserRepositoryImpl` still has unimplemented local DB and storage methods. Any code path calling them will throw.
- `UserRepositoryDsImpl` has methods that throw `UnimplementedError`.
- `GetUserFromNetworkUseCase` calls `getUserNameFromLocalNetwork()`, while the current implementation internally calls a local DB datasource method name. The naming is misleading.
- Firebase Auth and Firestore providers require `Firebase.initializeApp()` before use. Guest/local KickStack flows were adjusted to be lazy, and future guest features should follow that pattern.

## Medium Priority

- `ApiService.g.dart` is generated code but was manually extended for prepared KickStack REST endpoints. Regenerating Retrofit may overwrite it unless `build_runner` is run after keeping `api_service.dart` correct.
- `data/lib/di/usecase_di.dart` appears unused and contains only commented examples.
- `data/lib/remote/firebase_service.dart` is empty.
- Some app imports depend on packages that are transitive through `data`; direct root dependencies were added for common cases, but future imports should be checked.
- `NetworkConfig.currentFlavor` is a compile-time constant set to `dev`; Android/iOS build flavors do not currently switch this Dart value by themselves.

## Low Priority / Lint Cleanup

- Many existing enum constants use uppercase names and trigger lint info.
- Several unused imports and unused variables exist in older files.
- Generated localization files import `intl`; keep `intl` as a direct app dependency.
- The app uses a custom `BasePageViewWidget`/`DataProviderElement` pattern. It works, but it is uncommon and should be changed only deliberately.

## KickStack Feature Notes

- Guest KickStacks are stored locally in SQLite.
- Email/password and Google login are wired through domain use cases and data repositories.
- Sync uploads local KickStacks to Firestore under `users/{userId}/KickStacks`.
- REST KickStack endpoints are prepared in `ApiService` and `KickStackNetworkDataSource`, but the active home flow does not use REST yet.
