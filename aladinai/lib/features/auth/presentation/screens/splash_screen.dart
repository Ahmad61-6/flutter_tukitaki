import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/features/auth/presentation/screens/form_screen.dart';
import 'package:task_1/features/auth/presentation/widgets/app_logo.dart';
import 'package:task_1/features/home/presentation/screen/home_screen.dart';

import '../../../../app/utils/app_version_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _moveToNextScreen();
    });
  }

  Future<void> _moveToNextScreen() async {
    final SharedPreferences prefs = Get.find<SharedPreferences>();
    if (prefs.getString('current_user') != null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, HomeScreen.name);
      }
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, FormScreen.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              AppLogo(),
              const SizedBox(height: 24),
              Text(
                'Task',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Spacer(),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(AppVersionService.currentAppVersion),
            ],
          ),
        ),
      ),
    );
  }
}
