class Blog {
  final String blogId;
  final String posterId;
  final String title;
  final String blogContent;
  final String? imageUrl;
  final List<String> categories;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? posterName;
  final String? posterAvatarUrl;

  Blog({
    required this.blogId,
    required this.posterId,
    required this.title,
    required this.blogContent,
    this.imageUrl,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
    this.posterName,
    this.posterAvatarUrl,
  });
}
