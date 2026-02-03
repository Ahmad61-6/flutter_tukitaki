import 'dart:io';

import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/core/usecases/usecases.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSingUp implements UseCases<String, SignUpParams> {
  final AuthRepository _authRepository;

  UserSingUp(this._authRepository);

  @override
  Future<Either<Failure, String>> call(SignUpParams params) async {
    return await _authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
      image: params.image,
    );
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;
  File? image;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });
}
