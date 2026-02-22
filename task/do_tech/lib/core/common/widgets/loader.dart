import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/theme/app_colors.dart';

class Loader extends StatelessWidget {
  final double? size;

  const Loader({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 40.h,
        width: size ?? 40.w,
        child: CircularProgressIndicator(
          color: AppColors.primaryNew,

          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.5),

          strokeWidth: 3.5.w,

          strokeAlign: CircularProgressIndicator.strokeAlignCenter,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}