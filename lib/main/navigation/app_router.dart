import 'package:flutter/cupertino.dart';
import 'package:kick_stack/main/navigation/route_path.dart';
import 'package:kick_stack/presentation/rest_api_example/rest_api_example_page.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_detail_page.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_page.dart';
import 'package:kick_stack/presentation/sqlite_example/task_home_page.dart';
import 'package:kick_stack/presentation/splash/splash_page.dart';
import 'package:kick_stack/presentation/websocket_example/websocket_example_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint("navigation to page : ${settings.name}");
    switch (settings.name) {
      case RoutePaths.splash:
        return CupertinoPageRoute(
          builder: (context) => const SplashPage(),
          settings: const RouteSettings(name: RoutePaths.splash),
        );

      case RoutePaths.restApiExample:
        return CupertinoPageRoute(
          builder: (context) => const RestApiExamplePage(),
          settings: const RouteSettings(name: RoutePaths.restApiExample),
        );

      case RoutePaths.sqliteExample:
        return CupertinoPageRoute(
          builder: (context) => const TaskHomePage(),
          settings: const RouteSettings(name: RoutePaths.sqliteExample),
        );

      case RoutePaths.sharedProviderExample:
        return CupertinoPageRoute(
          builder: (context) => const SharedRestPage(),
          settings: const RouteSettings(name: RoutePaths.sharedProviderExample),
        );

      case RoutePaths.sharedProviderDetail:
        return CupertinoPageRoute(
          builder: (context) => const SharedRestDetailPage(),
          settings: const RouteSettings(name: RoutePaths.sharedProviderDetail),
        );

      case RoutePaths.webSocketExample:
        return CupertinoPageRoute(
          builder: (context) => const WebSocketExamplePage(),
          settings: const RouteSettings(name: RoutePaths.webSocketExample),
        );

      default:
        return CupertinoPageRoute(builder: (context) => Container());
    }
  }
}
