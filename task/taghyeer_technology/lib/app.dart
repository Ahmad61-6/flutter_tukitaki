
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:taghyeer_technology/core/bindings/controller_binder.dart';
import 'package:taghyeer_technology/routes/app_routes.dart';

import 'core/constants/app_sizer.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/controller/theme_controller.dart';

class PlatformUtils {
  static bool get isIOS =>
      foundation.defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isAndroid =>
      foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Obx(()=> GetMaterialApp(
          title: 'My App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.routes,
          initialRoute: AppRoutes.init,
          initialBinding: ControllerBinder(),
          defaultTransition: PlatformUtils.isIOS
              ? Transition.cupertino
              : Transition.rightToLeft,
          builder: (context, child) => PlatformUtils.isIOS
              ? CupertinoTheme(
            data: const CupertinoThemeData(),
            child: child!,
          )
              : child!,
          transitionDuration: const Duration(milliseconds: 100),
        ));
      },
    );
  }
}
