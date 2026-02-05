import 'dart:io';

import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:clean_arch_blog_app/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    File? image,
  });

  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Stream<Either<Failure, UserEntity>> get authStateChanges;

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getCurrentUserData();
}
