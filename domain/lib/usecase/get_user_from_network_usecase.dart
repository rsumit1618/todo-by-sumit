import 'package:dartz/dartz.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/local_storage_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetUserFromNetworkUseCase extends BaseUseCase<NetworkError,GetUserFromNetworkUseCaseParam,bool>{
  final UserRepository _userRepository;

  GetUserFromNetworkUseCase(this._userRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required GetUserFromNetworkUseCaseParam params}) async {
    return _userRepository.getUserNameFromLocalNetwork();
  }
}

class GetUserFromNetworkUseCaseParam extends Params {

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}