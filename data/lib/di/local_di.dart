import 'package:data/helper/app_local_database_helper.dart';
import 'package:data/helper/biometric_service_helper.dart';
import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/source/todo/local/todo_local_data_source.dart';
import 'package:data/source/todo/local/todo_local_data_source_impl.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final appLocalDatabaseProvider = Provider<AppLocalDatabase>((ref) {
  throw UnimplementedError("Override in main()");
});

final secureStorageProvider =
Provider<SecureStorageHelper>((ref) => SecureStorageHelper());

final deviceInfoPluginProvider =
Provider<DeviceInfoPlugin>((ref) => DeviceInfoPlugin());

final localAuthenticationProvider =
Provider<LocalAuthentication>((ref) => LocalAuthentication());

final bioMetricSourceProvider = Provider<BiometricServiceHelper>(
      (ref) => BiometricServiceHelper(
    ref.read(localAuthenticationProvider),
  ),
);

final todoLocalDataSourceProvider = Provider<TodoLocalDataSource>(
  (ref) => TodoLocalDataSourceImpl(
    ref.read(appLocalDatabaseProvider),
  ),
);
