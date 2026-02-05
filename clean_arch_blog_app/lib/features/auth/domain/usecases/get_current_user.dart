import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/core/usecases/usecases.dart';
import 'package:clean_arch_blog_app/features/auth/domain/entities/user.dart';
import 'package:clean_arch_blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements UseCases<UserEntity, void> {
  final AuthRepository _authRepository;

  GetCurrentUser(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(void params) async {
    return await _authRepository.getCurrentUserData();
  }
}
