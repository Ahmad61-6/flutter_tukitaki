import 'package:clean_arch_blog_app/core/constants/app_sizer.dart';
import 'package:clean_arch_blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Signup",style: TextStyle(
                fontSize: 50.sp,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 20.h,),
            AuthField(hintText: 'Email')
            ,SizedBox(height: 20.h,),
            AuthField(hintText: 'Password'),
            SizedBox(height: 20.h,),
            AuthField(hintText: 'Confirm Password'),
          ],
        ),
      ),
    );
  }
}
