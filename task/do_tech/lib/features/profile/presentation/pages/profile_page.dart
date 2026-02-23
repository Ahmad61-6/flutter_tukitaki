import 'package:do_tech/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/controllers/auth_controller.dart';
import '../../../../core/constants/app_sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_assets/assets_path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authController = Get.find<AuthController>();

  void _handleLogout() {
    Get.defaultDialog(
      title: "Logout",
      titleStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      middleText: "Are you sure you want to log out?",
      middleTextStyle: TextStyle(fontSize: 14.sp, color: AppColors.cardBg2),
      textConfirm: "Yes, Logout",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.textColor,
      buttonColor: AppColors.itemGradientColor[0],
      radius: 12.r,
      onConfirm: () {
        Get.back();

        Get.find<SignOutController>().signOut();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.userModel;
    final userName = user?.username ?? "Hasan Mahmud";
    final userEmail = user?.email ?? "hasan.mahmud@example.com";

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.primaryBg,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryNew.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 46.w,
                    backgroundColor: AppColors.colorWhite,
                    backgroundImage: const AssetImage(AssetsPath.person),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                userName,
                style: TextStyle(
                  color: AppColors.primaryBg,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                userEmail,
                style: TextStyle(
                  color: AppColors.cardBg2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 40.h),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    menuTile(
                      icon: Icons.person_outline,
                      title: "Edit Profile",
                      onTap: () {},
                    ),
                    divider(),
                    menuTile(
                      icon: Icons.settings_outlined,
                      title: "Settings",
                      onTap: () {},
                    ),
                    divider(),
                    menuTile(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onTap: () {},
                    ),
                    divider(),

                    menuTile(
                      icon: Icons.logout,
                      title: "Logout",
                      iconColor: AppColors.itemGradientColor[0],
                      textColor: AppColors.itemGradientColor[0],
                      onTap: _handleLogout,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      leading: Icon(icon, color: iconColor ?? AppColors.primaryNew, size: 26.w),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.textColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16.w,
        color: AppColors.levelLight,
      ),
      onTap: onTap,
    );
  }

  Widget divider() {
    return Divider(
      color: AppColors.levelLight.withValues(alpha: 0.3),
      height: 1,
      indent: 60.w,
      endIndent: 20.w,
    );
  }
}
