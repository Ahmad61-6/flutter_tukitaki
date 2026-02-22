import 'package:do_tech/core/bindings/controller_binder.dart';
import 'package:do_tech/core/constants/app_sizer.dart';
import 'package:do_tech/core/theme/app_theme.dart';
import 'package:do_tech/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
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
    return Sizer(builder: (context, orientation, deviceType){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.routes,
        initialRoute: AppRoutes.init,
        initialBinding: ControllerBinder(),
        theme: AppTheme.lightTheme,
        defaultTransition: PlatformUtils.isIOS
            ? Transition.cupertino
            : Transition.rightToLeft,
        builder: (context, child) => PlatformUtils.isIOS
            ? CupertinoTheme(data: CupertinoThemeData(), child: child!)
            : child!,
        transitionDuration: const Duration(milliseconds: 100),
      );
    });
  }
}
