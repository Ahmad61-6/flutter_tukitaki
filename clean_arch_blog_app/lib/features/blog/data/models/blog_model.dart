import 'package:clean_arch_blog_app/features/blog/domain/entities/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.blogId,
    required super.posterId,
    required super.title,
    required super.blogContent,
    required super.imageUrl, // Ensure this matches your Entity
    required super.categories,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      blogId: map['blog_id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      blogContent: map['blog_content'] as String,
      imageUrl: map['image_url'] as String?,
      categories: List<String>.from(map['categories'] ?? []),

      createdAt: (map['created_at'] as Timestamp).toDate(),
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
    );
  }

  // 2. TO FIRESTORE (App -> Database)
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'blog_id': blogId,
      'poster_id': posterId,
      'title': title,
      'blog_content': blogContent,
      'image_url': imageUrl,
      'categories': categories,
      // Convert Dart DateTime to Firestore Timestamp
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }

  // Optional: CopyWith is very useful for updating state locally
  BlogModel copyWith({
    String? blogId,
    String? posterId,
    String? title,
    String? blogContent,
    String? imageUrl,
    List<String>? categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      blogId: blogId ?? this.blogId,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      blogContent: blogContent ?? this.blogContent,
      imageUrl: imageUrl ?? this.imageUrl,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
