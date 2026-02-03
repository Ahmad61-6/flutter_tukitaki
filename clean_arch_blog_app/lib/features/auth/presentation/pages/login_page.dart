import 'package:clean_arch_blog_app/core/theme/app_colors.dart';
import 'package:clean_arch_blog_app/core/utils/validators/app_validators.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/controllers/login_screen_controller.dart';
import 'package:clean_arch_blog_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailTEController = TextEditingController();
  final passwordTEController = TextEditingController();
  final loginController = Get.find<LoginScreenController>();

  void _clearForm() {
    emailTEController.clear();
    passwordTEController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () =>DeviceUtility.hideKeyboard(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                  key: _formKey,
                child: Obx(()=>
                    Column(

                      mainAxisAlignment: .center,
                      children: [
                        SizedBox(height: 100.h,),
                        Text("Sign in.",style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20.h,),
                        AuthField(hintText: 'Email',controller: emailTEController,validator: AppValidator.validateEmail,obscureText: false,)
                        ,SizedBox(height: 20.h,),
                        AuthField(hintText: 'Password',controller: passwordTEController,validator: AppValidator.validatePassword,obscureText: loginController.obscureText.value,suffixIcon: loginController.obscureText.value ? Icon(Icons.visibility) : Icon(Icons.visibility_off),onTap: loginController.passwordVisibility,),
                        SizedBox(height: 20.h,),
                        const AuthGradientButton(text: 'Sign in'),
                        SizedBox(height: 30.h,),
                        GestureDetector(
                          onTap: ()=> Get.toNamed(AppRoutes.signupPage),
                          child: RichText(text: TextSpan(
                              text: 'Don\'t have an account?  ',style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                    text: 'Signup',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: AppColors.gradient2,
                                        fontWeight: FontWeight.bold
                                    )
                                )
                              ]
                          )),
                        )

                      ],
                    ),)
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
    super.dispose();
  }
}
