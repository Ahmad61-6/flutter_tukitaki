import 'package:do_tech/features/auth/presentation/pages/signin_page.dart';
import 'package:do_tech/features/auth/presentation/pages/splash_page.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/pages/signup_page.dart';

class AppRoutes {
static const String  init = '/';
static const String signupPage = '/signup';
static const String signInPage = '/signin';

static List<GetPage> routes = [
  GetPage(name: init, page: () => const SplashPage()),
  GetPage(name: signInPage, page: () => const SignInPage()),
  GetPage(name: signupPage, page: () => const SignupPage()),

];


}