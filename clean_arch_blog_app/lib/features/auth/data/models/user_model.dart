import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uId,
    required super.name,
    required super.email,
    super.imageUrl,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uId: data?['uid'] ?? '',
      name: data?['name'] ?? '',
      email: data?['email'] ?? '',
      imageUrl: data?['profile_pic'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uId,
      'name': name,
      'email': email,
      if (imageUrl != null) 'profile_pic': imageUrl,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
