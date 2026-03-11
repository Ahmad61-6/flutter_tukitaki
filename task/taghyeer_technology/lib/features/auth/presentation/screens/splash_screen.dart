import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    Get.find<SplashScreenController>();
    final colorScheme = Get.theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: colorScheme.secondary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.blur_on_rounded,
                size: 40.sp,
                color: colorScheme.secondary,
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              "Taghyeer Tech",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 8.0,
                color: colorScheme.primary,
              ),
            ),

            SizedBox(height: 12.h),

            Text(
              "Think beyond limits.",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
                color: Get.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}