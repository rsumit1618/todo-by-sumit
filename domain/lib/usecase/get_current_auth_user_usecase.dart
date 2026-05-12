import 'package:domain/entities/auth_user_entity.dart';
import 'package:domain/repository/auth_repository.dart';

class GetCurrentAuthUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentAuthUserUseCase(this._authRepository);

  AuthUserEntity? execute() => _authRepository.getCurrentUser();
}
