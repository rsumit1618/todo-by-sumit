import 'package:dartz/dartz.dart';
import 'package:domain/entities/auth_user_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class LoginWithGoogleUseCase
    extends BaseUseCase<NetworkError, LoginWithGoogleUseCaseParam, AuthUserEntity> {
  final AuthRepository _authRepository;

  LoginWithGoogleUseCase(this._authRepository);

  @override
  Future<Either<NetworkError, AuthUserEntity>> execute({
    required LoginWithGoogleUseCaseParam params,
  }) {
    return _authRepository.loginWithGoogle();
  }
}

class LoginWithGoogleUseCaseParam extends Params {
  @override
  Either<AppError, bool> verify() => Right(true);
}
