import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class BiometricServiceHelper {
  final LocalAuthentication _localAuth;

  BiometricServiceHelper(this._localAuth);

  /// Check if device supports biometrics
  Future<bool> canCheckBiometrics() async {
    try {
      final isSupported = await _localAuth.isDeviceSupported();
      final canCheck = await _localAuth.canCheckBiometrics;
      return isSupported && canCheck;
    } catch (_) {
      return false;
    }
  }

  /// Get available biometric types (fingerprint, face, etc.)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (_) {
      return [];
    }
  }

  /// Stop ongoing authentication
  Future<bool> stopAuthentication() async {
    try {
      return await _localAuth.stopAuthentication();
    } catch (_) {
      return false;
    }
  }

  /// Authenticate using biometrics
  Future<bool> authenticate({
    required String reason,
    String androidTitle = "Biometric Authentication",
    bool biometricOnly = true,
    bool stickyAuth = false,
    bool useErrorDialogs = true,
  }) async {
    try {
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          biometricOnly: biometricOnly,
          stickyAuth: stickyAuth,
          useErrorDialogs: useErrorDialogs,
          sensitiveTransaction: true,
        ),
        authMessages: [
          AndroidAuthMessages(
            signInTitle: androidTitle,
            cancelButton: "Cancel",
          ),
          const IOSAuthMessages(cancelButton: 'No thanks',),
        ],
      );

      return didAuthenticate;
    } catch (e) {
      if (kDebugMode) {
        print("Biometric error: $e");
      }
      return false;
    }
  }
}
