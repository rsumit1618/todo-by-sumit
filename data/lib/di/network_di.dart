import 'package:data/core/config/flavors.dart';
import 'package:data/core/config/network_config.dart';
import 'package:data/core/network/custom_pretty_dio_logger.dart';
import 'package:data/remote/api_service.dart';
import 'package:data/source/user/network/user_repository_ds.dart';
import 'package:data/source/user/network/user_repository_ds_impl.dart';
import 'package:data/source/todo/network/todo_network_data_source.dart';
import 'package:data/source/todo/network/todo_network_data_source_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';


final baseOptionsProvider = Provider<BaseOptions>(
      (ref) => BaseOptions(baseUrl: NetworkConfig.baseUrl),
);

final prettyDioLoggerProvider = Provider<CustomPrettyDioLogger>(
      (ref) => CustomPrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    logPrint: (log) {
      if (!kReleaseMode) debugPrint(log);
    },
  ),
);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(ref.read(baseOptionsProvider));

  // Logger only if not prod
  if (NetworkConfig.currentFlavor != ProductFlavor.prod) {
    dio.interceptors.add(ref.read(prettyDioLoggerProvider));
  }

  // Certificate pinning
  dio.interceptors.addAll([
    if (NetworkConfig.currentFlavor == ProductFlavor.uat)
      CertificatePinningInterceptor(
        allowedSHAFingerprints: [
          "09:AB:EE:22:57:80:C3:F2:F8:E7:8D:04:2C:5F:B7:3D:18:3B:DD:77:8F:04:A0:AC:64:D6:F2:12:7D:ED:4F:A2",
          "20:4B:9F:6B:7C:B2:F9:D7:88:8B:A5:03:56:4E:A2:8C:C7:6D:85:2F:1D:BE:A6:14:AE:5E:46:17:E5:F2:54:10",
        ],
      )
    else if (NetworkConfig.currentFlavor == ProductFlavor.prod)
      CertificatePinningInterceptor(
        allowedSHAFingerprints: [
          "B1:C2:09:F2:6B:D1:B3:25:D9:2D:5D:09:02:EC:26:67:BD:D9:DA:D3:69:51:59:7F:8D:9B:3F:4D:4A:BB:DB:21",
          "BD:EA:11:07:5B:84:47:6C:A4:57:9C:30:BA:6F:66:5E:50:7F:93:C2:89:04:14:DC:4A:26:B8:37:A8:B2:06:00",
          "4B:D5:5F:42:B3:0F:97:22:D7:7B:50:D9:D3:8A:CD:54:9D:D1:0C:DD:0B:11:46:9F:5B:7D:2B:3E:76:02:7B:F3",
          "84:4F:B0:1D:CF:F5:C4:D5:E4:CA:BB:84:84:87:03:04:9F:F9:FB:06:EB:EE:EB:98:4E:4F:46:FD:05:5C:2F:D6",
        ],
      )
  ]);

  return dio;
});

final apiServiceProvider = Provider<ApiService>(
      (ref) => ApiService(
    ref.read(dioProvider),
    baseUrl: NetworkConfig.baseUrl,
  ),
);

var userRepoProviderDs = Provider<UserRepositoryDs>(
      (ref) => UserRepositoryDsImpl(ref.read(apiServiceProvider)),
);

final todoNetworkDataSourceProvider = Provider<TodoNetworkDataSource>(
  (ref) => TodoNetworkDataSourceImpl(ref.read(apiServiceProvider)),
);
