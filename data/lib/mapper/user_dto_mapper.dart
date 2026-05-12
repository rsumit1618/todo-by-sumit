import 'package:data/models/remote/user/user_dto.dart';
import 'package:domain/entities/user_entity.dart';

class UserMapper {
  /// DTO → Domain
  UserEntity toDomain(UserDto dto) {
    return UserEntity(
      id: dto.id ?? '',
      name: dto.name ?? '',
      email: dto.email ?? '',
      mobile: dto.mobile ?? '',
      address: dto.address ?? '',
    );
  }

  /// Domain → DTO
  UserDto toDto(UserEntity entity) {
    return UserDto(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      mobile: entity.mobile,
      address: entity.address,
    );
  }
}