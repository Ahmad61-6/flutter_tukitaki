import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/features/auth/presentation/screens/form_screen.dart'; // Adjust path

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                FormScreen.name,
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.user.value == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_search_outlined,
                    size: 80,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No Profile Found',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please create your profile to see the feed.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(FormScreen.name),
                    child: const Text('Create Profile'),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

          itemBuilder: (context, index) {
            return UserPostCard(user: controller.user.value!);
          },
        );
      }),
    );
  }
}
