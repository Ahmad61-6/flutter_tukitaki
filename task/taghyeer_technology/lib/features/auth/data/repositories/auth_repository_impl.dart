import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/connection/connection_checker.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final ConnectionChecker _connectionChecker;

  AuthRepositoryImpl(
      this._remoteDataSource,
      this._localDataSource,
      this._connectionChecker,
      );

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(Failure('No internet connection'));
      }

      final userModel = await _remoteDataSource.login(
        username: username,
        password: password,
      );

      await _localDataSource.cacheUserData(userModel);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> checkCachedUser() async {
    try {
      final cachedUser = await _localDataSource.getCachedUserData();
      return right(cachedUser);
    } on CacheException {
      return left(Failure('No cached user found. Please log in.'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _localDataSource.clearCachedUserData();
      return right(null);
    } catch (e) {
      return left(Failure('Failed to clear session data.'));
    }
  }
}