// lib/features/settings/presentation/screens/theme_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/app/controllers/theme_controller.dart';

import '../../../../app/app_colors.dart';
import '../widgets/color_option.dart';
import '../widgets/theme_mode_option.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});
  static const String name = '/theme-settings';

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Mode Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Mode',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Column(
                        children: [
                          ThemeModeOption(
                            title: 'System Default',
                            subtitle: 'Follow device theme',
                            value: ThemeMode.system,
                            groupValue: themeController.themeMode,
                            onChanged: themeController.setThemeMode,
                            icon: Icons.phone_iphone,
                          ),
                          ThemeModeOption(
                            title: 'Light Theme',
                            subtitle: 'Always use light mode',
                            value: ThemeMode.light,
                            groupValue: themeController.themeMode,
                            onChanged: themeController.setThemeMode,
                            icon: Icons.light_mode,
                          ),
                          ThemeModeOption(
                            title: 'Dark Theme',
                            subtitle: 'Always use dark mode',
                            value: ThemeMode.dark,
                            groupValue: themeController.themeMode,
                            onChanged: themeController.setThemeMode,
                            icon: Icons.dark_mode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Color Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accent Color',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Choose your favorite accent color',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: AppColors.availableSeeds.map((color) {
                          return ColorOption(
                            color: color,
                            isSelected:
                                themeController.seedColor.value == color.value,
                            onTap: () => themeController.setSeedColor(color),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Quick Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.swap_horiz),
                            label: const Text('Toggle Theme'),
                            onPressed: themeController.toggleThemeMode,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset Colors'),
                            onPressed: () => themeController.setSeedColor(
                              AppColors.defaultSeed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
