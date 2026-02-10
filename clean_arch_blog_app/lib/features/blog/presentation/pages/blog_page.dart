import 'package:clean_arch_blog_app/core/common/widgets/loader.dart';
import 'package:clean_arch_blog_app/core/constants/app_sizer.dart';
import 'package:clean_arch_blog_app/core/theme/app_colors.dart';
import 'package:clean_arch_blog_app/core/widgets/custom_app_bar.dart';
import 'package:clean_arch_blog_app/features/blog/presentation/controllers/blog_page_controller.dart';
import 'package:clean_arch_blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:clean_arch_blog_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final BlogPageController controller = Get.find<BlogPageController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<BlogPageController>().getAllBlogs();
  }

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
      body: SafeArea(
        child: Obx(
          () => Visibility(
            visible: controller.isLoading.value == false,
            replacement: Loader(),
            child: Visibility(
              visible: controller.blogs.isEmpty == false,
              replacement: Center(child: Text("No blogs available yet.")),
              child: RefreshIndicator(
                onRefresh: () => controller.getAllBlogs(),
                child: ListView.builder(
                  itemCount: controller.blogs.length,

                  itemBuilder: (context, index) {
                    final blog = controller.blogs[index];
                    return BlogCard(blog: blog, color: AppColors.gradient1);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
