import 'package:clean_arch_blog_app/features/auth/domain/entities/user.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

class GetAuthState {
  final AuthRepository _authRepository;

  GetAuthState(this._authRepository);

  Stream<Either<Failure, UserEntity>> call() {
    return _authRepository.authStateChanges;
  }
}
