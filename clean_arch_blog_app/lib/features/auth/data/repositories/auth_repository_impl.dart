import 'dart:io';

import 'package:clean_arch_blog_app/core/error/exceptions.dart';
import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  const AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      final userId = await _authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
        image: image,
      );
      return right(userId);
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
