import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/core/usecases/usecases.dart';
import 'package:fpdart/fpdart.dart';

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
