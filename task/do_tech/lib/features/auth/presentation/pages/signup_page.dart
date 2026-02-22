import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/constants/app_sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_assets/assets_path.dart';
import '../../../../core/utils/device/device_utils.dart';
import '../../../../core/utils/validators/app_validators.dart';
import '../controllers/signup_page_controller.dart';
import '../widgets/auth_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailTEController = TextEditingController();
  final passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final nameTEController = TextEditingController();
  final confirmPasswordTEController = TextEditingController();
  final signupPageController = Get.find<SignupPageController>();
  void _clearForm() {
    nameTEController.clear();
    emailTEController.clear();
    passwordTEController.clear();
    confirmPasswordTEController.clear();
    signupPageController.resetVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtility.hideKeyboard(context),
      child: Scaffold(
        backgroundColor: AppColors.primaryBg,
        body: Padding(
          padding: EdgeInsets.all(12.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Obx(
                () => Column(
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(height: 250.h),
                    AuthField(
                      hintText: 'Name',
                      controller: nameTEController,
                      validator: AppValidator.validateName,
                      obscureText: false,
                      prefixIcon: Image.asset(AssetsPath.personIcon),
                    ),
                    SizedBox(height: 15.h),

                    AuthField(
                      hintText: 'Email',
                      controller: emailTEController,
                      validator: AppValidator.validateEmail,
                      obscureText: false,
                      prefixIcon: Image.asset(
                        AssetsPath.personIcon,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    AuthField(
                      hintText: 'Password',
                      controller: passwordTEController,
                      validator: AppValidator.validatePassword,
                      obscureText: signupPageController.obscureText.value,
                      suffixIcon: signupPageController.obscureText.value
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onTap: signupPageController.passwordVisibility,
                      prefixIcon: Image.asset(
                        AssetsPath.passwordLeadingIcon,
                        color: AppColors.colorWhite,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SizedBox(
                          height: 30.h,
                          width: 30.w,
                          child: Checkbox(
                            value: signupPageController.checkBoxValue.value,
                            onChanged: (bool? value) {
                              signupPageController.checkBoxVisibility(value);
                            },
                          ),
                        ),
                        Text(
                          'Remember username',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          AssetsPath.stashQuestionLightIcon,
                          width: 24.w,
                          height: 24.h,
                          color: AppColors.colorWhite,
                        ),
                      ],
                    ),

                    SizedBox(height: 45.h),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(

                        visible: signupPageController.isLoading.value == false,
                        replacement: Loader(),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await signupPageController.signUp(
                                nameTEController.text.trim(),
                                emailTEController.text.trim(),
                                passwordTEController.text.trim(),
                              );
                              if (result) {
                                _clearForm();
                                // Get.offAllNamed(AppRoutes.blogPage);
                              }
                            }
                          },

                          child: Text('Sign up'),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    GestureDetector(
                      onTap: () => Get.back(),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?  ',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: AppColors.colorWhite),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color: AppColors.primaryLight,
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
    );
  }
}
