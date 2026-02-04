class UserEntity {
  final String uId;
  final String name;
  final String email;
  final String? imageUrl;

  UserEntity({
    required this.uId,
    required this.name,
    required this.email,
    this.imageUrl,
  });
}
