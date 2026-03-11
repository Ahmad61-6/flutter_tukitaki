import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class UserSignOut {
  final AuthRepository repository;

  UserSignOut(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}