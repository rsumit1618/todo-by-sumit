import 'package:data/core/config/flavors.dart';
import 'package:data/core/config/network_config.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static bool get isConfigured {
    final options = currentPlatform;
    return options.apiKey.isNotEmpty &&
        options.appId.isNotEmpty &&
        options.messagingSenderId.isNotEmpty &&
        options.projectId.isNotEmpty;
  }

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return _getIosConfig();
      case TargetPlatform.android:
        return _getAndroidConfig();
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static FirebaseOptions _getIosConfig() {
    switch (NetworkConfig.currentFlavor) {
      case ProductFlavor.dev:
        return iosDev;
      case ProductFlavor.uat:
        return iosUat;
      case ProductFlavor.prod:
        return iosProd;
    }
  }

  static FirebaseOptions _getAndroidConfig() {
    switch (NetworkConfig.currentFlavor) {
      case ProductFlavor.dev:
        return androidDev;
      case ProductFlavor.uat:
        return androidUat;
      case ProductFlavor.prod:
        return androidProd;
    }
  }

  //  Android Firebase Configurations
  static const FirebaseOptions androidShared = FirebaseOptions(
    apiKey: 'AIzaSyDBbJ4GvUizADaHDaFyEvbKhG2CZTGWJgM',
    appId: '1:1017778655111:android:04b4457527e0102a954d22',
    messagingSenderId: '1017778655111',
    projectId: 'focusflow-ai-2eb25',
    databaseURL: 'https://focusflow-ai-2eb25-default-rtdb.firebaseio.com',
    storageBucket: 'focusflow-ai-2eb25.firebasestorage.app',
  );

  static const FirebaseOptions androidDev = androidShared;

  static const FirebaseOptions androidUat = androidShared;

  static const FirebaseOptions androidProd = androidShared;


  //  iOS Firebase Configurations
  static const FirebaseOptions iosDev = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    databaseURL: '',
    storageBucket: '',
    iosClientId: '',
    iosBundleId: 'com.sr.todo.dev',
  );

  static const FirebaseOptions iosUat = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    databaseURL: '',
    storageBucket: '',
    iosClientId: '',
    iosBundleId: 'com.sr.todo.uat',
  );


  static const FirebaseOptions iosProd = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    databaseURL: '',
    storageBucket: '',
    iosClientId: '',
    iosBundleId: 'com.sr.todo',
  );

}
