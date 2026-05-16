import 'package:dartz/dartz.dart';
import 'package:data/models/remote/live_update/live_update_dto.dart';
import 'package:data/remote/utils/safe_api_call.dart';
import 'package:data/source/live_update/network/live_update_remote_data_source.dart';
import 'package:domain/entities/live_update_entity.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/live_update_repository.dart';

class LiveUpdateRepositoryImpl extends LiveUpdateRepository {
  final LiveUpdateRemoteDataSource _remoteDataSource;

  LiveUpdateRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkError, List<LiveUpdateEntity>>>
  getInitialLiveUpdates() async {
    final response = await safeApiCall(_remoteDataSource.getInitialLiveUpdates());
    return response!.fold((error) => Left(error), (body) {
      final content = body.content;
      final rawItems = content is Map<String, dynamic>
          ? content['items']
          : content;
      if (rawItems is! List) {
        return const Right([]);
      }

      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .map((json) => LiveUpdateDto.fromJson(json).toEntity())
          .toList();
      return Right(items);
    });
  }
}
