class AuthUserEntity {
  final String id;
  final String? email;
  final String? displayName;

  const AuthUserEntity({
    required this.id,
    this.email,
    this.displayName,
  });
}
