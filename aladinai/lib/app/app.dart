import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/app/controllers/theme_controller.dart';
import 'package:task_1/app/routes.dart';
import 'package:task_1/controller_binder.dart';
import 'package:task_1/features/auth/presentation/screens/splash_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final ThemeController controller = Get.find();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: App.navigatorKey,
        theme: controller.lightTheme,
        darkTheme: controller.darkTheme,
        themeMode: controller.themeMode,
        home: SplashScreen(),
        initialRoute: SplashScreen.name,
        onGenerateRoute: onGenerateRoute,
        initialBinding: ControllerBinder(),
      );
    });
  }
}
