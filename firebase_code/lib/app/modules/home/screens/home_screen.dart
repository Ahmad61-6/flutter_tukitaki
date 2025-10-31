import 'package:firebase_code/app/modules/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/shared_preference_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<SharedPreferenceService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.removeCred();
          Get.offAll(() => const LoginScreen());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout),
      ),
      body: Center(
        child: Text(
          "Home Screen",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
