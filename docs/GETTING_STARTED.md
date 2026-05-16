# Getting Started From This Starter

Use this guide when a new developer or AI agent starts a real project from
KickStack.

## Create Your Own Project Repository

After cloning or copying the starter, create your own git history:

```powershell
git remote -v
git remote remove origin
git remote add origin <your-git-url>
git status
git add .
git commit -m "Initial project setup from KickStack"
git push -u origin main
```

If you copied the folder and want a completely new git history:

```powershell
Remove-Item -Recurse -Force .git
git init
git add .
git commit -m "Initial project setup from KickStack"
git branch -M main
git remote add origin <your-git-url>
git push -u origin main
```

## Rename App Identity

Change these before production work:

- `pubspec.yaml`: package name and description
- `android/app/build.gradle`: `namespace` and `applicationId`
- `android/app/src/main/AndroidManifest.xml`: app label
- `ios/Runner.xcodeproj/project.pbxproj`: bundle identifiers
- `ios/Runner/Info.plist`: display name
- `web/index.html` and `web/manifest.json`: web app name
- `lib/l10n/intl_en.arb`: `appName`
- `lib/firebase_options.dart`: only when Firebase is configured

## Configure Backend

Set base URLs in:

```text
data/lib/core/config/network_config.dart
```

Update:

- `baseUrl`
- `webSocketUrl`
- certificate fingerprints per flavor

## Configure SSL

Files:

```text
data/lib/core/config/network_config.dart
data/lib/di/network_di.dart
data/lib/core/app/app_http_override.dart
```

Rules:

- Dev may use relaxed certificate handling only for local testing.
- UAT and production should use valid SHA-256 certificate fingerprints.
- Do not allow bad certificates in production.

## Remove Starter Example Screens

The starter includes example screens to teach REST, SQLite, shared provider, and
WebSocket flow. After your real features are ready, remove example routes and
folders.

Remove these app folders when no longer needed:

```text
lib/presentation/rest_api_example
lib/presentation/sqlite_example
lib/presentation/shared_provider_example
lib/presentation/websocket_example
lib/di/view_model_provider/rest_api_example
lib/di/view_model_provider/sqlite_example
lib/di/view_model_provider/shared_provider_example
lib/di/view_model_provider/websocket_example
```

Then clean:

- `lib/main/navigation/route_path.dart`
- `lib/main/navigation/app_router.dart`
- `lib/presentation/splash/splash_page_view.dart`
- `lib/di/usecase_provider/usecase_provider.dart`
- feature entities/use cases/repositories in `domain`
- feature DTOs/data sources/repositories in `data`
- related localization keys in `lib/l10n/intl_en.arb`

Do not remove base classes, theme, shared UI, network config, secure storage, or
error classes unless the company standard changes.

## Generation

Run generation only when Retrofit or JSON-generated files change:

```powershell
cd data
dart run build_runner build --delete-conflicting-outputs
```

