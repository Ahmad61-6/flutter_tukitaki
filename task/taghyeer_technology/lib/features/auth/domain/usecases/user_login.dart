import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class UserLogin {
  final AuthRepository repository;

  UserLogin(this.repository);

  Future<Either<Failure, UserEntity>> call(UserLoginParams params) async {
    return await repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String username;
  final String password;

  UserLoginParams({
    required this.username,
    required this.password,
  });
}