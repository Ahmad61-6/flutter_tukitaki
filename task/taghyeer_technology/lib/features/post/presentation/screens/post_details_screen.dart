import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../domain/entities/post_entity.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostEntity post = Get.arguments;
    final colorScheme = Get.theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                height: 1.3,
              ),
            ),

            SizedBox(height: 24.h),
            const Divider(),
            SizedBox(height: 24.h),

            Text(
              post.body,
              style: TextStyle(
                fontSize: 16.sp,
                height: 1.8.h,
                color: Get.theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}