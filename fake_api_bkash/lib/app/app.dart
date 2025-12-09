import 'package:fake_api_bkash/app/controller_binder.dart';
import 'package:fake_api_bkash/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}