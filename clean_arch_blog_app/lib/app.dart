import 'package:clean_arch_blog_app/core/bindings/controller_binder.dart';
import 'package:clean_arch_blog_app/core/constants/app_sizer.dart';
import 'package:clean_arch_blog_app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'core/theme/app_theme.dart';

class PlatformUtils {
  static bool get isIOS =>
      foundation.defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isAndroid =>
      foundation.defaultTargetPlatform == TargetPlatform.android;
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Blog app',
          theme: AppTheme.darkThemeMode,
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBinder(),
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.init,
          defaultTransition: PlatformUtils.isIOS
              ? Transition.cupertino
              : Transition.rightToLeft,
          builder: (context, child) => PlatformUtils.isIOS
              ? CupertinoTheme(data: CupertinoThemeData(), child: child!)
              : child!,
          transitionDuration: const Duration(milliseconds: 100),
        );
      },
    );
  }
}
