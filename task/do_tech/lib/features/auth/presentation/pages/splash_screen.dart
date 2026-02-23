import 'package:do_tech/core/common/widgets/loader.dart';
import 'package:do_tech/core/constants/app_sizer.dart';
import 'package:do_tech/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/controllers/auth_controller.dart';
import '../../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _routeUser();
  }

  Future<void> _routeUser() async {


    await Future.delayed(const Duration(seconds: 2));

    final bool isLoggedIn = await Get.find<AuthController>().isUserAlreadyLoggedIn();

    if (isLoggedIn) {
      await Get.find<AuthController>().loadUserData();
      Get.offAllNamed(AppRoutes.mainBottomNavBarPage);
    } else {
      Get.offAllNamed(AppRoutes.signInPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
             Text(
              "DO TECH",
              style: TextStyle(
                color: AppColors.colorWhite,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
             SizedBox(height: 40.h),
             Loader()
          ],
        ),
      ),
    );
  }
}