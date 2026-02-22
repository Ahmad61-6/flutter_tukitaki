import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetAuthState {
  final AuthRepository _authRepository;

  GetAuthState(this._authRepository);

  Stream<Either<Failure, UserEntity>> call() {
    return _authRepository.authStateChanges;
  }
}
