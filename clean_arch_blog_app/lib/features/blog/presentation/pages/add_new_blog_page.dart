import 'package:clean_arch_blog_app/core/theme/app_colors.dart';
import 'package:clean_arch_blog_app/core/utils/validators/app_validators.dart';
import 'package:clean_arch_blog_app/core/widgets/custom_app_bar.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_arch_blog_app/features/blog/presentation/controllers/add_new_blog_page_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add New Blog',
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.done_rounded, size: 30.r),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0.w),
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: [10, 4],
                  radius: Radius.circular(10),
                  strokeWidth: 1,
                  strokeCap: StrokeCap.round,
                  padding: EdgeInsets.all(16),
                  color: AppColors.greyColor,
                ),
                child: SizedBox(
                  height: 150.h,
                  width: double.infinity,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: .center,
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
              ),
            ),

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
                    ].asMap().entries.map((entry) {
                      final int index = entry.key;
                      final String category = entry.value;

                      // ... inside your map loop ...
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Obx(() {
                          final bool isSelected =
                              pageController.selectedCategoryIndex.value ==
                              index;

                          return ChoiceChip(
                            label: Text(category),
                            selected: isSelected,

                            // 1. Logic for Background Color
                            selectedColor: AppColors.gradient1,
                            backgroundColor: AppColors.transparentColor,

                            // 2. Logic for Border (Side)
                            // Material 3 ChoiceChip usually handles border automatically,
                            // but to match your exact design:
                            side: isSelected
                                ? BorderSide.none
                                : const BorderSide(
                                    color: AppColors.borderColor,
                                  ),

                            // 3. Logic for Text Color
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.greyColor,
                              fontSize: 12.sp,
                            ),

                            // 4. Handle Tap
                            onSelected: (bool selected) {
                              if (selected) {
                                pageController.changeBlogCategory(index);
                              }
                            },

                            // Remove standard padding if you want it compact
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 5.h,
                            ),
                            showCheckmark:
                                false, // Hides the default check icon
                          );
                        }),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  AuthField(
                    hintText: 'Blog Title',
                    controller: blogTitleTEController,
                    validator: AppValidator.validateName,
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  AuthField(
                    hintText: 'Blog Content',
                    controller: blogContentTEController,
                    validator: AppValidator.validateName,
                    obscureText: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
