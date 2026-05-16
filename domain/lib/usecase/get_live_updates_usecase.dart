import 'package:dartz/dartz.dart';
import 'package:domain/entities/live_update_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/live_update_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetLiveUpdatesUseCase
    extends
        BaseUseCase<
          NetworkError,
          GetLiveUpdatesUseCaseParam,
          List<LiveUpdateEntity>
        > {
  final LiveUpdateRepository _liveUpdateRepository;

  GetLiveUpdatesUseCase(this._liveUpdateRepository);

  @override
  Future<Either<NetworkError, List<LiveUpdateEntity>>> execute({
    required GetLiveUpdatesUseCaseParam params,
  }) {
    return _liveUpdateRepository.getInitialLiveUpdates();
  }
}

class GetLiveUpdatesUseCaseParam extends Params {
  @override
  Either<AppError, bool> verify() => Right(true);
}
