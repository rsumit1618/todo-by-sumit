import 'package:dartz/dartz.dart';
import 'package:domain/entities/live_update_entity.dart';
import 'package:domain/errors/network_error.dart';

abstract class LiveUpdateRepository {
  Future<Either<NetworkError, List<LiveUpdateEntity>>> getInitialLiveUpdates();
}
