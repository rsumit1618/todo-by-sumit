import 'package:dartz/dartz.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_storage_error.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetUserFromLocalStorageUseCase extends BaseUseCase<LocalStorageError,GetUserFromLocalStorageUseCaseParam,bool>{
  @override
  Future<Either<LocalStorageError, bool>> execute({required GetUserFromLocalStorageUseCaseParam params}) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}

class GetUserFromLocalStorageUseCaseParam extends Params {

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}