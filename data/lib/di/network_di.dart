import 'package:data/core/config/flavors.dart';
import 'package:data/core/config/network_config.dart';
import 'package:data/core/network/custom_pretty_dio_logger.dart';
import 'package:data/remote/api_service.dart';
import 'package:data/source/live_update/network/live_update_remote_data_source.dart';
import 'package:data/source/live_update/network/live_update_remote_data_source_impl.dart';
import 'package:data/source/starter/network/starter_remote_data_source.dart';
import 'package:data/source/starter/network/starter_remote_data_source_impl.dart';
import 'package:data/source/task/network/task_network_data_source.dart';
import 'package:data/source/task/network/task_network_data_source_impl.dart';
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

  final fingerprints = NetworkConfig.certificateFingerprints;
  if (fingerprints.isNotEmpty) {
    dio.interceptors.add(
      CertificatePinningInterceptor(allowedSHAFingerprints: fingerprints),
    );
  }

  return dio;
});

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiService(ref.read(dioProvider), baseUrl: NetworkConfig.baseUrl),
);

final starterRemoteDataSourceProvider = Provider<StarterRemoteDataSource>(
  (ref) => StarterRemoteDataSourceImpl(ref.read(apiServiceProvider)),
);

final liveUpdateRemoteDataSourceProvider =
    Provider<LiveUpdateRemoteDataSource>(
      (ref) => LiveUpdateRemoteDataSourceImpl(ref.read(apiServiceProvider)),
    );

final taskNetworkDataSourceProvider = Provider<TaskNetworkDataSource>(
  (ref) => TaskNetworkDataSourceImpl(ref.read(apiServiceProvider)),
);
