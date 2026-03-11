import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<Either<Failure, PaginatedPostsEntity>> call(int limit, int skip) async {
    return await repository.getPosts(limit: limit, skip: skip);
  }
}