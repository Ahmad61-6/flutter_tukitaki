import 'package:flutter/material.dart';

import '../../../../app/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetPaths.appLogo, height: 120, width: width ?? 120);
  }
}
