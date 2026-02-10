import 'dart:io';

import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/core/usecases/usecases.dart';
import 'package:clean_arch_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/blog.dart';

class UploadBlog implements UseCases<Blog, UploadBlogParams> {
  final BlogRepository _blogRepository;

  UploadBlog(this._blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await _blogRepository.uploadBlog(
      file: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      categories: params.categories,
      posterName: params.posterName,
      posterAvtUrl: params.posterAvtUrl,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String posterName;
  final String posterAvtUrl;
  final String title;
  final String content;
  final File image;
  final List<String> categories;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
    required this.posterName,
    required this.posterAvtUrl,
  });
}
