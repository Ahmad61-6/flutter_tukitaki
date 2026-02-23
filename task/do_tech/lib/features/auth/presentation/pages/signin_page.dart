import 'package:do_tech/core/constants/app_sizer.dart';
import 'package:do_tech/core/theme/app_colors.dart';
import 'package:do_tech/core/utils/app_assets/assets_path.dart';
import 'package:do_tech/core/utils/device/device_utils.dart';
import 'package:do_tech/core/utils/validators/app_validators.dart';
import 'package:do_tech/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/signin_page_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailTEController = TextEditingController();
  final passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final signInPageController = Get.find<SignInPageController>();


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
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  SizedBox(height: 300.h),
                  AuthField(
                    hintText: 'Username',
                    controller: emailTEController,
                    validator: AppValidator.validateName,
                    obscureText: false,
                    prefixIcon: Image.asset(
                      AssetsPath.personIcon,
                      color: AppColors.colorWhite,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  SizedBox(height: 15.h),

                 Obx(()=>  AuthField(
                   hintText: 'Password',
                   controller: passwordTEController,
                   validator: AppValidator.validatePassword,
                   obscureText: signInPageController.obscureText.value,
                   suffixIcon: signInPageController.obscureText.value
                       ? Icon(Icons.visibility)
                       : Icon(Icons.visibility_off),
                   onTap:  signInPageController.passwordVisibility,
                   prefixIcon: Image.asset(
                     AssetsPath.passwordLeadingIcon,
                     color: AppColors.colorWhite,
                     width: 20.w,
                     height: 20.h,
                   ),
                 ),),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child:Obx(()=> Checkbox(
                          value: signInPageController.checkBoxValue.value,
                          onChanged: signInPageController.checkBoxVisibility,
                        ),)
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
                    child: Obx(()=>Visibility(
                      visible: signInPageController.isLoading.value == false,
                      replacement: Loader(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool isSuccess = await signInPageController.login(
                              emailTEController.text.trim(),
                              passwordTEController.text.trim(),
                              context,
                            );
                            if (isSuccess) {
                              _clearForm();
                              Get.offAllNamed(AppRoutes.mainBottomNavBarPage);
                            }
                          }
                        },

                        child: Text(
                          'Sign in',
                        ),
                      ),
                    ),),
                  ),
                  SizedBox(height: 35.h),
                  GestureDetector(
                    onTap: () {
                      _clearForm();
                      Get.toNamed(AppRoutes.signupPage);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?  ',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.colorWhite,
                        ),
                        children: [
                          TextSpan(
                            text: 'Signup',
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
    );
  }
  void _clearForm() {
    emailTEController.clear();
    passwordTEController.clear();
    signInPageController.resetVisibility();
  }
  @override
  void dispose() {
    super.dispose();
    emailTEController.dispose();
        passwordTEController.dispose();
  }
}
