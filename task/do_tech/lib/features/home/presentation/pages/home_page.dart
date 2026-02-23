  import 'package:do_tech/core/theme/app_colors.dart';
  import 'package:do_tech/core/utils/app_assets/assets_path.dart';
  import 'package:do_tech/features/home/presentation/controllers/home_controller.dart';
  import 'package:do_tech/features/home/presentation/widgets/category_card.dart';
  import 'package:do_tech/features/home/presentation/widgets/custom_search_bar.dart';
  import 'package:do_tech/features/home/presentation/widgets/product_card.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

  import '../../../../core/common/controllers/auth_controller.dart';
  import '../../../../core/constants/app_sizer.dart';
  import '../widgets/home_shimmer_layout.dart';

  class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
      final controller = Get.put(HomeController());
      final authController = Get.find<AuthController>();

      return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => controller.isLoading.value
            ? const HomeShimmerLayout()
            : SingleChildScrollView(
          child: Column(
            children: [
              headerSection(authController),
              whiteBodySection(context, controller),
            ],
          ),
        ),
        ),
      );
    }

    Widget headerSection(AuthController authController) {
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primaryBg,
          image: DecorationImage(
            image: AssetImage(AssetsPath.homeAppBarBg),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                headerRow(authController),
                SizedBox(height: 24.h),
                const CustomSearchBar(hintText: 'Search Products'),
                SizedBox(height: 12.h),
                promoSection(),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      );
    }

    Widget headerRow(AuthController authController) {
      final String userName = authController.userModel?.username ?? "Hasan Mahmud";

      return Row(
        children: [
          CircleAvatar(
            radius: 20.w,
            backgroundImage: const AssetImage(AssetsPath.person),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: 10.w),
          Text(
            userName,
            style: TextStyle(
              color: AppColors.colorWhite,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Image.asset(AssetsPath.notificationBellIcon, width: 24.w, height: 24.h, color: AppColors.colorWhite),
          SizedBox(width: 16.w),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(AssetsPath.cartIcon, width: 24.w, height: 24.h, color: AppColors.colorWhite),
              Positioned(
                top: -6.h,
                right: -6.w,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: AppColors.itemGradientColor[0],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "1",
                    style: TextStyle(color: AppColors.colorWhite, fontSize: 10.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Image.asset(AssetsPath.menuIcon, width: 24.w, height: 24.h, color: AppColors.colorWhite),
        ],
      );
    }

    Widget promoSection() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text(
                "Unlock Peak Performance with\nthe perfect Lubricant Oils",
                style: TextStyle(
                  color: AppColors.colorWhite,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3.h,
                ),
              ),
            ),
          ),
          Image.asset(AssetsPath.oilsImage, width: 105.w, fit: BoxFit.contain),
        ],
      );
    }

    Widget whiteBodySection(BuildContext context, HomeController controller) {
      return Padding(
        padding: EdgeInsets.only(
          top: 24.h,
          bottom: 24.h + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: categoriesSection(controller),
            ),
            SizedBox(height: 25.h),
            whatsNewSection(),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: featuredProductsSection(controller),
            ),
          ],
        ),
      );
    }

    Widget categoriesSection(HomeController controller) {
      return SizedBox(
        height: 130.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 80.w,
              child: CategoryCard(category: controller.categories[index]),
            );
          },
        ),
      );
    }

    Widget whatsNewSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "What's New",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 140.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    AssetsPath.bannerImage,
                    width: 280.w,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    Widget featuredProductsSection(HomeController controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Featured Products",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.textColor),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.featuredProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: controller.featuredProducts[index],
              );
            },
          ),
        ],
      );
    }
  }