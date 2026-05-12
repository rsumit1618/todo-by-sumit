import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? address;

  UserDto({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.address,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}