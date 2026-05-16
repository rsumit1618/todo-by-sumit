import 'dart:core';

import 'flavors.dart';

class NetworkConfig {
  static const ProductFlavor currentFlavor = ProductFlavor.dev;
  static const String _baseUrl = 'https://api.example.com';
  static const String _webSocketUrl = 'wss://api.example.com/ws/v1/live-updates';

  static List<String> get certificateFingerprints {
    switch (currentFlavor) {
      case ProductFlavor.dev:
        return const [];
      case ProductFlavor.uat:
        return const ["REPLACE_WITH_UAT_SHA256_FINGERPRINT"];
      case ProductFlavor.prod:
        return const ["REPLACE_WITH_PROD_SHA256_FINGERPRINT"];
    }
  }

  static String get baseUrl {
    switch (currentFlavor) {
      case ProductFlavor.dev:
        return _baseUrl;
      case ProductFlavor.uat:
        return _baseUrl;
      case ProductFlavor.prod:
        return _baseUrl;
    }
  }

  static String get webSocketUrl {
    switch (currentFlavor) {
      case ProductFlavor.dev:
        return _webSocketUrl;
      case ProductFlavor.uat:
        return _webSocketUrl;
      case ProductFlavor.prod:
        return _webSocketUrl;
    }
  }
}
