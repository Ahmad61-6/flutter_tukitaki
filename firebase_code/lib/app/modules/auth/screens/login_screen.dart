import 'package:firebase_code/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/auth/auth_scaffold_background.dart';
import '../../home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<SharedPreferenceService>();
  final TextEditingController te = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthScaffoldBackground(),
          Positioned(
            top: 140,
            bottom: 100,
            left: 30,
            right: 30,
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  TextFormField(
                    controller: te,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.saveCredential(value: te.text.trim());
                        Get.offAll(() => HomeScreen());
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
