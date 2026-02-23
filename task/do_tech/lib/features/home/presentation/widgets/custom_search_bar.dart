import 'package:do_tech/core/constants/app_sizer.dart';
import 'package:do_tech/core/theme/app_colors.dart';
import 'package:do_tech/core/utils/app_assets/assets_path.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;

  const CustomSearchBar({
    super.key,
    this.onTap,
    this.hintText = 'Search Products',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(10.w),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AssetsPath.searchIcon,
              height: 20.h,
              width: 20.w,
              color: AppColors.primaryNew,
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  color: AppColors.hintTextColor2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2.h,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}