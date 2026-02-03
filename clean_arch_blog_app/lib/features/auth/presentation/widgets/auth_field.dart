import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.obscureText,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: suffixIcon!,
          onPressed: onTap,
        )
            : null,
      ),
    );
  }
}
