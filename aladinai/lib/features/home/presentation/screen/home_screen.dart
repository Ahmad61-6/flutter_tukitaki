import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/features/auth/presentation/screens/form_screen.dart';

import '../../../../app/controllers/theme_controller.dart';
import '../../../settings/presentation/screens/theme_settings_screen.dart';
import '../controllers/home_screen_controller.dart';
import '../widgets/user_post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String name = '/home';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Feed'),
        centerTitle: false,
        actions: [
          // Theme Toggle Button
          Obx(() {
            final themeController = Get.find<ThemeController>();
            return IconButton(
              icon: Icon(
                themeController.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: themeController.toggleThemeMode,
              tooltip: 'Toggle Theme',
            );
          }),
          // Settings Button
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(ThemeSettingsScreen.name),
            tooltip: 'Settings',
          ),
          // Logout Button - FIXED: Use Get.offAllNamed
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await controller.logout();
              Get.offAllNamed(FormScreen.name);
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.user.value == null) {
          return _buildEmptyState(context);
        }

        return _buildInfiniteFeed(controller);
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_search_outlined,
                size: 60,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Profile Found',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Please create your profile to see your personalized feed',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(FormScreen.name),
              child: const Text('Create Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfiniteFeed(HomeController controller) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 100 &&
            !controller.isLoadingMore.value &&
            controller.displayedItems.value < 100) {
          controller.loadMoreItems();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: controller.itemCount.value,
        itemBuilder: (context, index) {
          if (index >= controller.displayedItems.value) {
            return _buildLoadingIndicator(controller, context);
          }

          return UserPostCard(
            user: controller.user.value!,
            index: index,
            key: ValueKey('user_card_$index'),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator(
    HomeController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          if (controller.isLoadingMore.value)
            const CircularProgressIndicator()
          else
            Text(
              'You\'ve reached the end!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
        ],
      ),
    );
  }
}
