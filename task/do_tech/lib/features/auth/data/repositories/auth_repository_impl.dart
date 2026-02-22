import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/internet_checker.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  const AuthRepositoryImpl(this._authRemoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure('No internet connection'));
      }
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
  }) async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure('No internet connection'));
      }
      final user = await _authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      debugPrint(
        "------User Information------\n-->${user.name}\n-->${user.email}",
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (!await (_connectionChecker.isConnected)) {
      return left(Failure('No internet connection'));
    }
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
      if (!await (_connectionChecker.isConnected)) {}
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
        ),
      );
    });
  }
}
