import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Stream<Either<Failure, UserEntity>> get authStateChanges;

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getCurrentUserData();
}
