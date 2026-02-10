import 'package:clean_arch_blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_helper.dart';
import '../../domain/entities/blog.dart';

class BlogPageController extends GetxController {
  final GetAllBlogs _getAllBlogs;

  BlogPageController({required GetAllBlogs getAllBlogs})
    : _getAllBlogs = getAllBlogs;

  final RxList<Blog> _blogs = <Blog>[].obs;

  RxList<Blog> get blogs => _blogs;
  final RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  Future<void> getAllBlogs() async {
    _isLoading.value = true;
    final result = await _getAllBlogs.call(NoParams());
    result.fold(
      (failure) {
        _isLoading.value = false;
        AppHelperFunctions.showSnackBar("Error", failure.message, true);
      },
      (blogs) {
        _isLoading.value = false;
        _blogs.value = blogs;
        for (final blog in blogs) {
          debugPrint(
            "Blog: ${blog.blogId}\n${blog.title}\n${blog.blogContent}\n-----\n-----\n",
          );
        }
      },
    );
  }
}
