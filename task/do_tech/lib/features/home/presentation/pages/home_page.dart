import 'package:do_tech/core/theme/app_colors.dart';
import 'package:do_tech/core/utils/app_assets/assets_path.dart';
import 'package:do_tech/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/controllers/auth_controller.dart';
import '../../../../core/constants/app_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 188.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBg,
                    image: DecorationImage(
                      image: AssetImage(AssetsPath.homeAppBarBg),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),

                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),

                        headerRow(),

                        SizedBox(height: 28.h),

                        const CustomSearchBar(
                          hintText: 'Search Products',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

  Widget headerRow() {
    final authController = Get.find<AuthController>();

    final String userName = authController.userModel?.username ?? "Hasan Mahmud";
    return Row(
      children: [
        CircleAvatar(
          radius: 20.w,
          backgroundImage: const AssetImage(AssetsPath.person),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 12.w),


        Text(
          userName,
          style: TextStyle(
            color: AppColors.colorWhite,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        const Spacer(),

        Image.asset(
          AssetsPath.notificationBellIcon,
          width: 24.w,
          height: 24.h,
          color: AppColors.colorWhite,
        ),
        SizedBox(width: 16.w),

        Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              AssetsPath.cartIcon,
              width: 24.w,
              height: 24.h,
              color: AppColors.colorWhite,
            ),
            Positioned(
              top: -6.h,
              right: -6.w,
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration:  BoxDecoration(
                  color:AppColors.itemGradientColor[0],
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "1",
                  style: TextStyle(
                    color: AppColors.colorWhite,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 16.w),

        Image.asset(
          AssetsPath.menuIcon,
          width: 24.w,
          height: 24.h,
          color: AppColors.colorWhite,
        ),
      ],
    );
  }
}