import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/splash_page_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashScreenController>();

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.8 + (value * 0.2),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [

                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: AppColors.itemGradientColor,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'DoTech',
                      style: TextStyle(
                        fontSize: 42.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.colorWhite,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Evaluation Task',
                    style: TextStyle(
                      color: AppColors.hintTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            CircularProgressIndicator(
              color: AppColors.primaryNew,
              strokeWidth: 3.w,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}