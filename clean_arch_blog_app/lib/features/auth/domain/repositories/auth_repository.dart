import 'dart:io';

import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    File? image,
  });

  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Stream<User?> get authStateChanges;

  Future<void> signOut();
}
