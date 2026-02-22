
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/usecases.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

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
