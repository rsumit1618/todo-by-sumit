import 'package:dartz/dartz.dart';
import 'package:data/remote/firebase_auth_service.dart';
import 'package:domain/entities/auth_user_entity.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepositoryImpl(this._firebaseAuthService);

  @override
  Future<Either<NetworkError, AuthUserEntity>> loginWithEmail({
    required String email,
    required String password,
  }) {
    return _mapAuthCall(
      _firebaseAuthService.loginWithEmail(email, password),
    );
  }

  @override
  Future<Either<NetworkError, AuthUserEntity>> registerWithEmail({
    required String email,
    required String password,
  }) {
    return _mapAuthCall(
      _firebaseAuthService.registerWithEmail(email, password),
    );
  }

  @override
  Future<Either<NetworkError, AuthUserEntity>> loginWithGoogle() {
    return _mapAuthCall(_firebaseAuthService.loginWithGoogle());
  }

  @override
  Future<Either<NetworkError, bool>> logout() async {
    try {
      await _firebaseAuthService.logout();
      return Right(true);
    } catch (error) {
      return Left(NetworkError(
        httpError: 502,
        message: error.toString(),
        cause: Exception(error.toString()),
      ));
    }
  }

  @override
  AuthUserEntity? getCurrentUser() {
    final user = _firebaseAuthService.currentUser;
    if (user == null) return null;
    return _mapUser(user);
  }

  Future<Either<NetworkError, AuthUserEntity>> _mapAuthCall(
    Future<UserCredential> call,
  ) async {
    try {
      final credential = await call;
      final user = credential.user;
      if (user == null) {
        return Left(NetworkError(
          httpError: 404,
          message: 'User not found',
          cause: Exception('User not found'),
        ));
      }
      return Right(_mapUser(user));
    } catch (error) {
      return Left(NetworkError(
        httpError: 502,
        message: error.toString(),
        cause: Exception(error.toString()),
      ));
    }
  }

  AuthUserEntity _mapUser(User user) {
    return AuthUserEntity(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }
}
