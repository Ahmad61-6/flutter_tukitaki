import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../../../../core/utils/validators/app_validators.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/login_screen_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final loginController = Get.find<LoginScreenController>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _usernameController.clear();
    _passwordController.clear();
    if (!loginController.obscureText.value) {
      loginController.togglePasswordVisibility();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Get.theme.colorScheme;

    return GestureDetector(
      onTap: () => DeviceUtility.hideKeyboard(context),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Obx(
                      () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign in.",
                        style: TextStyle(
                          fontSize: 42.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                          letterSpacing: -1.0,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Welcome back to Nova. Please enter your details.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Get.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                        ),
                      ),

                      SizedBox(height: 48.h),

                      AuthField(
                        hintText: 'Username (e.g., emilys)',
                        controller: _usernameController,
                        validator: (val) => AppValidator.validateNotEmpty(val, 'Username'),
                      ),

                      SizedBox(height: 16.h),

                      AuthField(
                        hintText: 'Password',
                        controller: _passwordController,
                        validator: AppValidator.validatePassword,
                        obscureText: loginController.obscureText.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginController.obscureText.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: colorScheme.secondary,
                          ),
                          onPressed: loginController.togglePasswordVisibility,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      AuthButton(
                        text: 'Sign in',
                        isLoading: loginController.isLoading.value,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool isSuccess = await loginController.login(
                              _usernameController.text.trim(),
                              _passwordController.text.trim(),
                            );

                            if (isSuccess) {
                              _clearForm();
                              Get.offAllNamed(AppRoutes.mainBottomNav);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}