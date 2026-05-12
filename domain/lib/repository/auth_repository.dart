import 'package:dartz/dartz.dart';
import 'package:domain/entities/auth_user_entity.dart';
import 'package:domain/errors/network_error.dart';

abstract class AuthRepository {
  Future<Either<NetworkError, AuthUserEntity>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<NetworkError, AuthUserEntity>> registerWithEmail({
    required String email,
    required String password,
  });

  Future<Either<NetworkError, AuthUserEntity>> loginWithGoogle();

  Future<Either<NetworkError, bool>> logout();

  AuthUserEntity? getCurrentUser();
}
