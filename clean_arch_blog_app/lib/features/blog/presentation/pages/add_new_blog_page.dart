import 'package:clean_arch_blog_app/core/common/widgets/loader.dart';
import 'package:clean_arch_blog_app/core/theme/app_colors.dart';
import 'package:clean_arch_blog_app/core/utils/validators/app_validators.dart';
import 'package:clean_arch_blog_app/core/widgets/custom_app_bar.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_arch_blog_app/features/blog/presentation/controllers/add_new_blog_page_controller.dart';
import 'package:clean_arch_blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final pageController = Get.find<AddNewBlogPageController>();
  final blogTitleTEController = TextEditingController();
  final blogContentTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    blogTitleTEController.dispose();
    blogContentTEController.dispose();
    super.dispose();
  }

  void _handleUpload() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await pageController.uploadBlog(
        blogTitleTEController.text.trim(),
        blogContentTEController.text.trim(),
      );

      if (isSuccess && mounted) {
        blogTitleTEController.clear();
        blogContentTEController.clear();
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add New Blog',
        showBackButton: true,
        actions: [
          Obx(
            () => Visibility(
              visible: pageController.isLoading.value == false,

              replacement: Padding(
                padding: EdgeInsets.all(12.0),
                child: SizedBox(height: 20.h, width: 20.w, child: Loader()),
              ),

              child: IconButton(
                onPressed: _handleUpload,
                icon: Icon(Icons.done_rounded, size: 30.r),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Obx(() {
                    final isImageSelected =
                        pageController.selectedImage.value != null;

                    if (isImageSelected) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () => pageController.selectImage(),
                            child: SizedBox(
                              height: 150.h,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  pageController.selectedImage.value!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5.h,
                            right: 5.w,
                            child: GestureDetector(
                              onTap: () => pageController.removeImage(),
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => pageController.selectImage(),
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            dashPattern: [10, 4],
                            radius: Radius.circular(10),
                            strokeWidth: 1,
                            strokeCap: StrokeCap.round,
                            padding: const EdgeInsets.all(16),
                            color: AppColors.greyColor,
                          ),
                          child: SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_outlined,
                                    size: 35.r,
                                    color: AppColors.whiteColor,
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    'Select your image',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),

                  SizedBox(height: 10.h),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          [
                            'Technology',
                            'Business',
                            'Programming',
                            'Entertainment',
                          ].map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Obx(() {
                                final isSelected = pageController
                                    .selectedCategories
                                    .contains(entry);
                                return GestureDetector(
                                  onTap: () => pageController
                                      .selectedCategoryItems(entry),
                                  child: Chip(
                                    label: Text(entry),
                                    backgroundColor: isSelected
                                        ? AppColors.gradient1
                                        : AppColors.backgroundColor,
                                    side: isSelected
                                        ? BorderSide.none
                                        : const BorderSide(
                                            color: AppColors.borderColor,
                                          ),
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.greyColor,
                                    ),
                                  ),
                                );
                              }),
                            );
                          }).toList(),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  AuthField(
                    hintText: 'Blog Title',
                    controller: blogTitleTEController,
                    validator: AppValidator.validateName,
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  BlogEditor(
                    hintText: 'Blog Content',
                    teContoller: blogContentTEController,
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
