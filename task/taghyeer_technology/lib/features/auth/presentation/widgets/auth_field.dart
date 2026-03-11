import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: TextStyle(color: Get.theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}