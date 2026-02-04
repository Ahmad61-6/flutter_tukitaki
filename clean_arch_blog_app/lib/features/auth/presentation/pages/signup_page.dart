import 'package:clean_arch_blog_app/core/common/widgets/loader.dart';
import 'package:clean_arch_blog_app/core/constants/app_sizer.dart';
import 'package:clean_arch_blog_app/core/utils/validators/app_validators.dart';
import 'package:clean_arch_blog_app/core/widgets/custom_app_bar.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../controllers/signup_page_controller.dart';
import '../widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final nameTEController = TextEditingController();
  final emailTEController = TextEditingController();
  final passwordTEController = TextEditingController();
  final confirmPasswordTEController = TextEditingController();
  final signupController = Get.find<SignupPageController>();

  void _clearForm() {
    emailTEController.clear();
    passwordTEController.clear();
    confirmPasswordTEController.clear();
    signupController.resetVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtility.hideKeyboard(context),
      child: Scaffold(
        appBar: CustomAppBar(backgroundColor: AppColors.backgroundColor),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Obx(
                  () => Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "Signup.",
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () => signupController.pickImage(),
                        child: Obx(() {
                          final file = signupController.selectedImage.value;
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: file != null
                                ? FileImage(file)
                                : null,
                            child: file == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                    color: Colors.grey,
                                  )
                                : null,
                          );
                        }),
                      ),
                      SizedBox(height: 10.h),
                      AuthField(
                        hintText: 'Name',
                        controller: nameTEController,
                        validator: AppValidator.validateName,
                        obscureText: false,
                      ),
                      SizedBox(height: 12.h),
                      AuthField(
                        hintText: 'Email',
                        controller: emailTEController,
                        validator: AppValidator.validateEmail,
                        obscureText: false,
                      ),
                      SizedBox(height: 12.h),
                      AuthField(
                        hintText: 'Password',
                        controller: passwordTEController,
                        validator: AppValidator.validatePassword,
                        obscureText: signupController.obscureText1.value,
                        suffixIcon: signupController.obscureText1.value
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onTap: () => signupController.changeVisibility(1),
                      ),
                      SizedBox(height: 12.h),
                      AuthField(
                        hintText: 'Confirm Password',
                        controller: confirmPasswordTEController,
                        validator: (value) {
                          return AppValidator.validateConfirmPassword(
                            value,
                            passwordTEController.text,
                          );
                        },
                        obscureText: signupController.obscureText2.value,
                        suffixIcon: signupController.obscureText2.value
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onTap: () => signupController.changeVisibility(2),
                      ),
                      SizedBox(height: 12.h),
                      Visibility(
                        visible: signupController.isLoading.value == false,
                        replacement: Loader(),
                        child: AuthGradientButton(
                          text: 'Signup',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await signupController.signUp(
                                nameTEController.text.trim(),
                                emailTEController.text.trim(),
                                passwordTEController.text.trim(),
                                signupController.selectedImage.value,
                              );
                              if (result) {
                                _clearForm();
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 18.h),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?  ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign in',
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      color: AppColors.gradient2,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
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

  @override
  void dispose() {
    emailTEController.dispose();
    passwordTEController.dispose();
    confirmPasswordTEController.dispose();
    super.dispose();
  }
}
