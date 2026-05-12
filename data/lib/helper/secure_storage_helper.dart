import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final SecureStorageHelper _instance = SecureStorageHelper._privateConstructor();

  factory SecureStorageHelper() => _instance;

  SecureStorageHelper._privateConstructor();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  static const String IS_FIRST_LOGIN = "isFirstLogin";

  static SecureStorageHelper get instance => _instance;

  Future<bool> getIsFirstLoginFromSecureStorage() async {
    final isFirstLogin = await _storage.read(key: IS_FIRST_LOGIN);
    return isFirstLogin?.isEmpty ?? true;
  }

  Future<bool> setIsFirstLoginToSecureStorage() async {
    await _storage.write(key: IS_FIRST_LOGIN, value: 'notFirst');
    return true;
  }

  // NEW: Helper method to handle keychain errors
  Future<void> _safeWrite({required String key,required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } on PlatformException catch (e) {
      if (e.code == '-25299' || e.message?.contains('already exists') == true) {
        // Delete and retry
        await _storage.delete(key: key);
        await _storage.write(key: key, value: value);
      } else {
        rethrow;
      }
    }
  }
}
