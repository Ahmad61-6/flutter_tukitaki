import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AuthScaffoldBackground extends StatelessWidget {
  const AuthScaffoldBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.scaffoldBackgroundLinearStartColor,
            AppColors.scaffoldBackgroundLinearEndColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.46, 0.91],
        ),
      ),
    );
  }
}
