
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/usecases.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCases<UserEntity, void> {
  final AuthRepository _authRepository;

  GetCurrentUser(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(void params) async {
    return await _authRepository.getCurrentUserData();
  }
}
