import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  });
  Future<Either<Failure, UserEntity>> checkCachedUser();
  Future<Either<Failure, void>> signOut();
}