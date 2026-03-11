import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';

abstract interface class PostRepository {
  Future<Either<Failure, PaginatedPostsEntity>> getPosts({
    required int limit,
    required int skip,
  });
}