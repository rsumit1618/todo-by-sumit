import 'package:dartz/dartz.dart';
import 'package:domain/entities/auth_user_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class LoginWithEmailUseCase
    extends BaseUseCase<NetworkError, LoginWithEmailUseCaseParam, AuthUserEntity> {
  final AuthRepository _authRepository;

  LoginWithEmailUseCase(this._authRepository);

  @override
  Future<Either<NetworkError, AuthUserEntity>> execute({
    required LoginWithEmailUseCaseParam params,
  }) {
    return _authRepository.loginWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginWithEmailUseCaseParam extends Params {
  final String email;
  final String password;

  LoginWithEmailUseCaseParam({
    required this.email,
    required this.password,
  });

  @override
  Either<AppError, bool> verify() =>
      Right(email.trim().isNotEmpty && password.isNotEmpty);
}
