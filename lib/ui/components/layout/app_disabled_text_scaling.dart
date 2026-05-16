import 'package:flutter/material.dart';

class AppDisabledTextScaling extends StatelessWidget {
  final Widget child;

  const AppDisabledTextScaling({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(
        textScaler: mediaQuery.textScaler.clamp(
          minScaleFactor: 1,
          maxScaleFactor: 1,
        ),
      ),
      child: child,
    );
  }
}
