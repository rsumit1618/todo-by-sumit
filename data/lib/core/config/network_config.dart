import 'dart:core';

import 'flavors.dart';

class NetworkConfig {
  static const ProductFlavor currentFlavor = ProductFlavor.dev;
  static const String _baseUrl = 'https://social-backend-qrfn.onrender.com';

  static String get projectId {
    switch (currentFlavor) {
      case ProductFlavor.dev:
        return "your-firebase-project-id";
      case ProductFlavor.uat:
        return "your-firebase-project-id";
      case ProductFlavor.prod:
        return "your-firebase-project-id";
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
}
