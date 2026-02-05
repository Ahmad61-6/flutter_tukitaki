import 'package:clean_arch_blog_app/core/constants/app_sizer.dart';
import 'package:clean_arch_blog_app/core/widgets/custom_app_bar.dart';
import 'package:clean_arch_blog_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Blogs',
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.addNewBlogPage);
            },
            icon: Icon(Icons.add, size: 30.r),
          ),
        ],
      ),
    );
  }
}
