import 'package:flutter/material.dart';
import 'package:task_1/features/auth/presentation/screens/splash_screen.dart';

import '../features/auth/presentation/screens/form_screen.dart';
import '../features/home/presentation/screen/home_screen.dart';
import '../features/settings/presentation/screens/theme_settings_screen.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  late Widget screen;

  if (settings.name == SplashScreen.name) {
    screen = const SplashScreen();
  } else if (settings.name == HomeScreen.name) {
    screen = const HomeScreen();
  } else if (settings.name == FormScreen.name) {
    screen = const FormScreen();
  } else if (settings.name == '/theme-settings') {
    screen = const ThemeSettingsScreen();
  } else {
    screen = const Scaffold(body: Center(child: Text('Screen not found')));
  }

  return MaterialPageRoute(builder: (ctx) => screen);
}
