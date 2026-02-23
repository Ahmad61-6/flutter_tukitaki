import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/theme/app_colors.dart';

class HomeShimmerLayout extends StatelessWidget {
  const HomeShimmerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.primaryBg),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Shimmer.fromColors(
                  baseColor: AppColors.colorWhite.withValues(alpha: 0.1),
                  highlightColor: AppColors.colorWhite.withValues(alpha: 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Container(width: 40.w, height: 40.w, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          SizedBox(width: 10.w),
                          Container(width: 120.w, height: 18.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.w))),
                          const Spacer(),
                          Container(width: 24.w, height: 24.h, color: Colors.white),
                          SizedBox(width: 16.w),
                          Container(width: 24.w, height: 24.h, color: Colors.white),
                          SizedBox(width: 16.w),
                          Container(width: 24.w, height: 24.h, color: Colors.white),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Container(width: double.infinity, height: 48.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.w))),
                      SizedBox(height: 12.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 200.w, height: 40.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.w))),
                          Container(width: 105.w, height: 90.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.w))),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 130.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (context, index) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) => Container(
                        width: 80.w,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(width: 100.w, height: 20.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.w))),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 140.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      separatorBuilder: (context, index) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) => Container(
                        width: 280.w,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.w)),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(width: 150.w, height: 20.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.w))),
                  ),
                  SizedBox(height: 12.h),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.w)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}