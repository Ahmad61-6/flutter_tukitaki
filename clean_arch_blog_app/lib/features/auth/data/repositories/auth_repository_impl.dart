import 'dart:io';

import 'package:clean_arch_blog_app/core/error/exceptions.dart';
import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/features/auth/domain/entities/user.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  const AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authRemoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      final user = await _authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
        image: image,
      );
      debugPrint(
        "------User Information------\n-->${user.name}\n-->${user.email}\n-->${user.imageUrl}",
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserData() async {
    try {
      final user = await _authRemoteDataSource.getCurrentUserData();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Stream<Either<Failure, UserEntity>> get authStateChanges {
    return _authRemoteDataSource.authStateChanges.map((user) {
      if (user == null) {
        return left(Failure('User is logged out'));
      }
      return right(
        UserEntity(
          uId: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          imageUrl: user.photoURL ?? '',
        ),
      );
    });
  }
}
