import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/main/navigation/route_path.dart';
import 'package:flutter_clean_architecture/presentation/login/login_page.dart';
import 'package:flutter_clean_architecture/presentation/splash/splash_page.dart';
import 'package:flutter_clean_architecture/presentation/todo/todo_home_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint("navigation to page : ${settings.name}");
    switch (settings.name) {
      case RoutePaths.splash:
        return CupertinoPageRoute(
            builder: (context) => SplashPage(),
            settings: const RouteSettings(name: RoutePaths.splash));

      case RoutePaths.todoHome:
        return CupertinoPageRoute(
            builder: (context) => const TodoHomePage(),
            settings: const RouteSettings(name: RoutePaths.todoHome));

      case RoutePaths.login:
        return CupertinoPageRoute(
            builder: (context) => const LoginPage(),
            settings: const RouteSettings(name: RoutePaths.login));

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
