import 'package:dartz/dartz.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/starter_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetDashboardSummaryUseCase
    extends BaseUseCase<NetworkError, GetDashboardSummaryUseCaseParam, bool> {
  final StarterRepository _starterRepository;

  GetDashboardSummaryUseCase(this._starterRepository);

  @override
  Future<Either<NetworkError, bool>> execute({
    required GetDashboardSummaryUseCaseParam params,
  }) async {
    return _starterRepository.getDashboardSummary();
  }
}

class GetDashboardSummaryUseCaseParam extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
