import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/core/usecases/usecases.dart';
import 'package:clean_arch_blog_app/features/auth/domain/entities/user.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCases<UserEntity, LoginParams> {
  final AuthRepository _authRepository;

  UserLogin(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await _authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
