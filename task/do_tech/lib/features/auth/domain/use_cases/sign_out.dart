
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/usecases.dart';
import '../repositories/auth_repository.dart';

class UserSignOut implements UseCases<void, NoParams> {
  final AuthRepository _authRepository;

  UserSignOut(this._authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepository.signOut();
  }
}

class NoParams {}
