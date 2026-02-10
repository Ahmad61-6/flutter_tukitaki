import 'dart:io';

import 'package:clean_arch_blog_app/core/error/exceptions.dart';
import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/features/blog/data/data_source/blog_remote_data_sources.dart';
import 'package:clean_arch_blog_app/features/blog/data/models/blog_model.dart';
import 'package:clean_arch_blog_app/features/blog/domain/entities/blog.dart';
import 'package:clean_arch_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSources _blogRemoteDataSources;

  BlogRepositoryImpl(this._blogRemoteDataSources);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File file,
    required String title,
    required String content,
    required String posterId,
    required String posterName,
    required String posterAvtUrl,
    required List<String> categories,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        blogId: const Uuid().v1(),
        posterId: posterId,

        title: title,
        blogContent: content,
        imageUrl: '',
        posterName: posterName,
        posterAvatarUrl: posterAvtUrl,
        categories: categories,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final image = await _blogRemoteDataSources.uploadBlogImage(
        image: file,
        blogId: blogModel.blogId,
      );
      blogModel = blogModel.copyWith(imageUrl: image);
      final blog = await _blogRemoteDataSources.uploadBlog(blogModel);
      return right(blog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await _blogRemoteDataSources.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
