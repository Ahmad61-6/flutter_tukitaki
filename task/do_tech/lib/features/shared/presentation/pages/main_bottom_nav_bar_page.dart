import 'package:do_tech/core/constants/app_sizer.dart';
import 'package:do_tech/core/utils/app_assets/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../road_assist/presentation/pages/road_assist_page.dart';
import '../../../service/presentation/pages/services_page.dart';
import '../controllers/bottom_nav_controller.dart';

class MainBottomNavBarPage extends StatelessWidget {
  const MainBottomNavBarPage({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    ServicesPage(),
    RoadAssistPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavController>(
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
          index: controller.currentIndex,
          children: _pages,
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingQRButton(),
          bottomNavigationBar: bottomAppBar(controller),
        );
      },
    );
  }

  Widget _buildFloatingQRButton() {
    return Container(
      height: 70.h,
      width: 70.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: AppColors.itemGradientColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        onPressed: () {
          debugPrint("QR Scanner Tapped");
        },
        child: Image.asset(
          AssetsPath.floatingQrIcon,
          width: 36.w,
          height: 36.h,
        ),
      ),
    );
  }

  Widget bottomAppBar(MainNavController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.w)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.w)),
        child: BottomAppBar(
          height: 85.h,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10.0,
          color: AppColors.primaryLight,
          elevation: 0,
          child: SizedBox(
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navItem(
                  iconPath: AssetsPath.bottomNavMarketPlaceIcon,
                  label: 'Marketplace',
                  index: 0,
                  controller: controller,
                ),
                navItem(
                  iconPath: AssetsPath.bottomNavServicesIcon,
                  label: 'Services',
                  index: 1,
                  controller: controller,
                ),

                SizedBox(width: 75.w),

                navItem(
                  iconPath: AssetsPath.bottomNavRoadAssisIcon,
                  label: 'Roadside\nassistance',
                  index: 2,
                  controller: controller,
                ),
                navItem(
                  iconPath: AssetsPath.bottomNavProfileIcon,
                  label: 'Profile',
                  index: 3,
                  controller: controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem({
    required String iconPath,
    required String label,
    required int index,
    required MainNavController controller,
  }) {
    final isSelected = controller.currentIndex == index;
    final textColor = isSelected ? AppColors.primaryNew : AppColors.textColor;

    final double iconSizeHeight = 24.h;
    final double iconSizeWidth = 24.w;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.changeIndex(index),
        child: Container(
          padding: EdgeInsets.only(top: 12.h),
          child: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            children: [
              isSelected
                  ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: AppColors.itemGradientColor,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Image.asset(
                  iconPath,
                  height: iconSizeHeight,
                  width: iconSizeWidth,
                ),
              )
                  : Image.asset(
                iconPath,
                height: iconSizeHeight,
                width: iconSizeWidth,
                color: AppColors.colorBlack,
              ),
              SizedBox(height: 4.h),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12.sp,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      height: 1.1.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}