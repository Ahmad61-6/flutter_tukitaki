import '../../../../core/network/network_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/urls/api_urls.dart';
import '../models/post_model.dart';
import '../../domain/entities/post_entity.dart';

abstract interface class PostRemoteDataSource {
  Future<PaginatedPostsEntity> getPosts(int limit, int skip);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final NetworkClient _networkClient;

  PostRemoteDataSourceImpl(this._networkClient);

  @override
  Future<PaginatedPostsEntity> getPosts(int limit, int skip) async {
    final response = await _networkClient.getRequest(
      ApiUrls.paginatedPosts(limit, skip),
    );

    if (response.isSuccess && response.responseData != null) {
      final data = response.responseData!;
      final List<dynamic> postsJson = data['posts'];

      final posts = postsJson.map((json) => PostModel.fromJson(json)).toList();
      final total = data['total'] as int;

      return PaginatedPostsEntity(posts: posts, total: total);
    } else {
      throw ServerException(response.errorMessage ?? 'Failed to fetch posts');
    }
  }
}