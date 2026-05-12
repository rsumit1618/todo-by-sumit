import 'package:data/core/config/flavors.dart';
import 'package:data/core/config/network_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_widget.dart';
import 'package:flutter_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter_clean_architecture/di/view_model_provider/app/app_module.dart';
import 'package:flutter_clean_architecture/generated/l10n.dart';
import 'package:flutter_clean_architecture/main/app_view_model.dart';
import 'package:flutter_clean_architecture/main/navigation/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'navigation/route_path.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, watch) {
    return BaseWidget<AppViewModel>(
      providerBase: appViewModel,
      onModelReady: (model) {
        var appViewModelRef = watch.watch(appViewModel);
      },
        builder: (context, appModel, child) {

          return MaterialApp(
            navigatorKey: appLevelKey,
            navigatorObservers: [
              DashboardRefreshRouteObserver(),
            ],
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);

              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: mediaQuery.textScaler.clamp(
                    minScaleFactor: 1.0,
                    maxScaleFactor: 1.5,
                  ),
                ),
                child: ResponsiveBreakpoints.builder(
                  breakpoints: const [
                    Breakpoint(start: 0, end: 450, name: MOBILE),
                    Breakpoint(start: 451, end: 800, name: TABLET),
                    Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                  ],
                  child: child??const SizedBox.shrink(),
                ),
              );
            },
            onGenerateTitle: (context) => getCurrentTitle(
              currentFlavor: NetworkConfig.currentFlavor,
              context: context,
            ),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: RoutePaths.splash,
            onGenerateRoute: AppRouter.generateRoute,
          );
        }
    );
  }

  String getCurrentTitle({required ProductFlavor currentFlavor, required BuildContext context}) {
    switch (currentFlavor) {
      case ProductFlavor.dev:
        return S.of(context).appName;
      case ProductFlavor.uat:
        return S.of(context).appName;
      default:
        return S.of(context).appName;
    }
  }
}

/// Observer will refresh dashboard on pop from any page to dashboard and first tab selected
class DashboardRefreshRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  Future<void> didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    super.didPush(route, previousRoute);
    // Handle the pushed route
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if(previousRoute?.settings.name == RoutePaths.splash){
      debugPrint("did pop payment login");
      return;
    }
    if(previousRoute?.settings.name == RoutePaths.login){
      var context = previousRoute?.navigator?.context;
    }
  }
// You can override other methods like didReplace, didRemove, etc. as needed
}
