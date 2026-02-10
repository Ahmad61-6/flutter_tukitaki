import 'dart:io';

import 'package:clean_arch_blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File file,
    required String title,
    required String content,
    required String posterId,
    required String posterName,
    required String posterAvtUrl,
    required List<String> categories,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
