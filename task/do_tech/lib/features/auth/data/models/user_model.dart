import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';


class UserModel extends UserEntity {
  UserModel({
    required super.uId,
    required super.name,
    required super.email,
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
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uId,
      'name': name,
      'email': email,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
