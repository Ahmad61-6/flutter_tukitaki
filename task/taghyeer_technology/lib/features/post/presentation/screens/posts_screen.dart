import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/common/widgets/error_state_widget.dart';
import '../../../../core/common/widgets/pagination_loader.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/post_controller.dart';
import '../widgets/post_card.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostController controller = Get.find<PostController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        controller.getPosts(isRefresh: false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Posts')),
      body: Obx(() {

        if (controller.isInitialLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return ErrorStateWidget(
            errorMessage: controller.errorMessage.value,
            onRetry: () => controller.getPosts(isRefresh: true),
          );
        }

        if (controller.postList.isEmpty) {
          return const Center(child: Text("No posts found."));
        }

        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.all(16.w),
          itemCount: controller.postList.length + (controller.canLoadMore ? 1 : 0),
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {

            if (index == controller.postList.length) {
              return const PaginationLoader();
            }

            final post = controller.postList[index];
            return PostCard(
              post: post,
              onTap: () {
                Get.toNamed(AppRoutes.postDetails, arguments: post);
              },
            );
          },
        );
      }),
    );
  }
}