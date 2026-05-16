import 'dart:io';
import 'package:data/core/config/flavors.dart';
import 'package:data/core/config/network_config.dart';
import 'package:flutter/foundation.dart';

class AppHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    // Allow bad certificate ONLY in dev flavor and debug mode
    if (NetworkConfig.currentFlavor == ProductFlavor.dev && !kReleaseMode) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
            return true;
          };
    }

    return client;
  }
}
