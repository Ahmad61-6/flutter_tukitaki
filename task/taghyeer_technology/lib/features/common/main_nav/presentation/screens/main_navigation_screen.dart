import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../post/presentation/controllers/post_controller.dart';
import '../../../../post/presentation/screens/posts_screen.dart';
import '../../../../product/presentation/controllers/product_controller.dart';
import '../../../../product/presentation/screens/products_screen.dart';
import '../../../../settings/presentaion/screens/settings_screen.dart';
import '../controllers/main_bottom_nav_controller.dart';



class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<Widget> _screens = [
    const ProductsScreen(),
    const PostsScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductController>().getProducts(isRefresh: true);
      Get.find<PostController>().getPosts(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Get.theme.colorScheme;

    return GetBuilder<MainBottomNavController>(
      builder: (navController) {
        return Scaffold(
          body: _screens[navController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: navController.selectedIndex,
            onDestinationSelected: navController.changeIndex,
            backgroundColor: colorScheme.surface,
            elevation: 8,
            indicatorColor: colorScheme.secondary.withValues(alpha: 0.2),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.inventory_2_outlined),
                selectedIcon: Icon(Icons.inventory_2),
                label: 'Products',
              ),
              NavigationDestination(
                icon: Icon(Icons.article_outlined),
                selectedIcon: Icon(Icons.article),
                label: 'Posts',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}