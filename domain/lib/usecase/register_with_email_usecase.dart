import 'package:dartz/dartz.dart';
import 'package:domain/entities/auth_user_entity.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RegisterWithEmailUseCase extends BaseUseCase<NetworkError,
    RegisterWithEmailUseCaseParam, AuthUserEntity> {
  final AuthRepository _authRepository;

  RegisterWithEmailUseCase(this._authRepository);

  @override
  Future<Either<NetworkError, AuthUserEntity>> execute({
    required RegisterWithEmailUseCaseParam params,
  }) {
    return _authRepository.registerWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterWithEmailUseCaseParam extends Params {
  final String email;
  final String password;

  RegisterWithEmailUseCaseParam({
    required this.email,
    required this.password,
  });

  @override
  Either<AppError, bool> verify() =>
      Right(email.trim().isNotEmpty && password.isNotEmpty);
}
