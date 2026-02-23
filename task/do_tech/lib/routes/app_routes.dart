import 'package:do_tech/features/auth/presentation/pages/signin_page.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/pages/signup_page.dart';
import '../features/auth/presentation/pages/splash_screen.dart';
import '../features/shared/presentation/pages/main_bottom_nav_bar_page.dart';

class AppRoutes {
  AppRoutes._();
  static const String init = '/';
static const String signupPage = '/signup';
static const String signInPage = '/signin';

static const String mainBottomNavBarPage = '/mainBottomNavBarPage';



static List<GetPage> routes = [
  GetPage(name: init, page: () => const SplashScreen()),
  GetPage(name: signInPage, page: () => const SignInPage()),
  GetPage(name: signupPage, page: () => const SignupPage()),
  GetPage(name: mainBottomNavBarPage, page: () => const MainBottomNavBarPage()),


];


}