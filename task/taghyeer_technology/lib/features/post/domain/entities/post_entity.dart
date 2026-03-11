class PostEntity {
  final int id;
  final String title;
  final String body;

  PostEntity({
    required this.id,
    required this.title,
    required this.body,
  });
}

class PaginatedPostsEntity {
  final List<PostEntity> posts;
  final int total;

  PaginatedPostsEntity({required this.posts, required this.total});
}