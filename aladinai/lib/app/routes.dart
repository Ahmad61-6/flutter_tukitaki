import 'package:flutter/material.dart';
import 'package:task_1/features/auth/presentation/screens/splash_screen.dart';

import '../features/auth/presentation/screens/form_screen.dart';
import '../features/home/presentation/screen/home_screen.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  late Widget screen;

  if (settings.name == SplashScreen.name) {
    screen = const SplashScreen();
  } else if (settings.name == HomeScreen.name) {
    screen = const HomeScreen();
  } else if (settings.name == FormScreen.name) {
    screen = const FormScreen();
  }

  return MaterialPageRoute(builder: (ctx) => screen);
}
