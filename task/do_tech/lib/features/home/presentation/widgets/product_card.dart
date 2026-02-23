import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textColor,

                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: -0.3,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 2.h, left: 4.w),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.w,
                  color: AppColors.primaryNew,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}