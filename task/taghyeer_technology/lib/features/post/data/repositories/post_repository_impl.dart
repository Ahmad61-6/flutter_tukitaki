import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/connection/connection_checker.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;
  final ConnectionChecker _connectionChecker;

  PostRepositoryImpl(this._remoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, PaginatedPostsEntity>> getPosts({
    required int limit,
    required int skip,
  }) async {
    try {
      if (!await _connectionChecker.isConnected) {
        return left(Failure('No internet connection'));
      }
      final result = await _remoteDataSource.getPosts(limit, skip);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('An unexpected error occurred'));
    }
  }
}