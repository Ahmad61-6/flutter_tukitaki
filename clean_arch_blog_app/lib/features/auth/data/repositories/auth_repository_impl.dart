import 'dart:io';

import 'package:clean_arch_blog_app/core/error/exceptions.dart';
import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/features/auth/data/models/user_model.dart';
import 'package:clean_arch_blog_app/features/auth/domain/entities/user.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // TODO: implement authStateChanges
  Stream<User?> get authStateChanges => throw UnimplementedError();

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
