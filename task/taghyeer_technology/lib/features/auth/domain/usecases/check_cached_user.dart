import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CheckCachedUser {
  final AuthRepository repository;
  CheckCachedUser(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.checkCachedUser();
  }
}