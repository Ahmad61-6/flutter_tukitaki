class UserModel {
  final String firstName;

  final String lastName;

  final String email;

  final String? phoneNumber;

  final String? bio;

  final String? profilePictureUrl;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.bio,
    this.profilePictureUrl,
  });

  String get fullName => '$firstName $lastName';

  static const UserModel empty = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: null,
    bio: null,
    profilePictureUrl: null,
  );

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? bio,
    String? profilePictureUrl,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, email: $email)';
  }
}
