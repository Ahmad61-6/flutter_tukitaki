import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/usecases.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class UserSingUp implements UseCases<UserEntity, SignUpParams> {
  final AuthRepository _authRepository;

  UserSingUp(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await _authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
