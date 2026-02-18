import 'package:cached_network_image/cached_network_image.dart'; // Import this
import 'package:clean_arch_blog_app/core/constants/app_sizer.dart';
import 'package:clean_arch_blog_app/core/helpers/app_helper.dart';
import 'package:clean_arch_blog_app/core/theme/app_colors.dart';
import 'package:clean_arch_blog_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/blog.dart';

class BlogViewers extends StatelessWidget {
  final Blog blog;

  const BlogViewers({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'By ${blog.posterName ?? "Unknown"}',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "${AppHelperFunctions.formatDateTime(blog.updatedAt)} . ${AppHelperFunctions.calculateReadingTime(blog.blogContent)} min read",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.greyColor.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  if (blog.imageUrl != null && blog.imageUrl!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: blog.imageUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,

                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 200.h,

                              width: double.infinity,
                              color: Colors.white,
                            ),
                          );
                        },

                        errorWidget: (context, url, error) => Container(
                          height: 200.h,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 20.h),
                  Text(
                    blog.blogContent,
                    style: TextStyle(fontSize: 16.sp, height: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
